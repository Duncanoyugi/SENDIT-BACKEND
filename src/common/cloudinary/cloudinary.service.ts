import { Injectable, Logger } from '@nestjs/common';
import { v2 as cloudinary } from 'cloudinary';
import { Readable } from 'stream';

export interface UploadResult {
  url: string;
  publicId: string;
  width: number;
  height: number;
  format: string;
  size: number;
}

export interface UploadOptions {
  folder?: string;
  transformation?: {
    width?: number;
    height?: number;
    crop?: string;
    quality?: number | string;
  };
}

@Injectable()
export class CloudinaryService {
  private readonly logger = new Logger(CloudinaryService.name);
  private isConfigured = false;

  constructor() {
    const cloudName = process.env.CLOUDINARY_CLOUD_NAME;
    const apiKey = process.env.CLOUDINARY_API_KEY;
    const apiSecret = process.env.CLOUDINARY_API_SECRET;

    if (!cloudName || !apiKey || !apiSecret) {
      this.logger.warn('⚠️ Cloudinary credentials not configured - image uploads will be disabled');
      this.logger.warn('Please set CLOUDINARY_CLOUD_NAME, CLOUDINARY_API_KEY, and CLOUDINARY_API_SECRET environment variables');
      this.isConfigured = false;
      return;
    }

    cloudinary.config({
      cloud_name: cloudName,
      api_key: apiKey,
      api_secret: apiSecret,
    });

    this.isConfigured = true;
    this.logger.log('✅ Cloudinary configured successfully');
  }

  async uploadImage(
    file: Express.Multer.File,
    options: UploadOptions = {},
  ): Promise<UploadResult> {
    if (!this.isConfigured) {
      throw new Error('Cloudinary is not configured. Please set the required environment variables.');
    }

    try {
      const uploadOptions = {
        folder: options.folder || 'sendit-profiles',
        transformation: {
          width: options.transformation?.width || 400,
          height: options.transformation?.height || 400,
          crop: options.transformation?.crop || 'fill',
          quality: options.transformation?.quality || 'auto',
        },
      };

      return new Promise((resolve, reject) => {
        const uploadStream = cloudinary.uploader.upload_stream(
          uploadOptions,
          (error, result) => {
            if (error) {
              this.logger.error('Cloudinary upload failed:', error);
              reject(new Error('Failed to upload image'));
            } else if (result) {
              resolve({
                url: result.secure_url,
                publicId: result.public_id,
                width: result.width,
                height: result.height,
                format: result.format,
                size: result.bytes,
              });
            } else {
              reject(new Error('Upload result is undefined'));
            }
          },
        );

        // Convert buffer to stream
        const readableStream = new Readable();
        readableStream.push(file.buffer);
        readableStream.push(null);
        readableStream.pipe(uploadStream);
      });
    } catch (error) {
      this.logger.error('Image upload error:', error);
      throw new Error('Failed to process image upload');
    }
  }

  async deleteImage(publicId: string): Promise<void> {
    if (!this.isConfigured) {
      throw new Error('Cloudinary is not configured. Please set the required environment variables.');
    }

    try {
      await cloudinary.uploader.destroy(publicId);
      this.logger.log(`Image deleted successfully: ${publicId}`);
    } catch (error) {
      this.logger.error('Failed to delete image:', error);
      throw new Error('Failed to delete image');
    }
  }

  async updateProfilePicture(
    file: Express.Multer.File,
    currentPublicId?: string,
  ): Promise<UploadResult> {
    if (!this.isConfigured) {
      throw new Error('Cloudinary is not configured. Please set the required environment variables.');
    }

    try {
      // Delete old image if it exists
      if (currentPublicId) {
        try {
          await this.deleteImage(currentPublicId);
        } catch (error) {
          this.logger.warn('Failed to delete old profile picture:', error);
          // Continue with upload even if deletion fails
        }
      }

      // Upload new image
      return await this.uploadImage(file, {
        folder: 'sendit-profiles',
        transformation: {
          width: 400,
          height: 400,
          crop: 'fill',
          quality: 'auto',
        },
      });
    } catch (error) {
      this.logger.error('Profile picture update failed:', error);
      throw new Error('Failed to update profile picture');
    }
  }
}
