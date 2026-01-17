import { Module, forwardRef } from '@nestjs/common';
import { MailerModule } from '@nestjs-modules/mailer';
import { EjsAdapter } from '@nestjs-modules/mailer/dist/adapters/ejs.adapter';
import { join } from 'path';
import { MailerService } from './mailer.service';
import { AuthModule } from '../auth/auth.module';
import { CommonModule } from '../common/common.module';

// Determine if we should use SendGrid (production) or SMTP (local development)
const useSendGrid = !!process.env.SENDGRID_API_KEY;

@Module({
  imports: [
    MailerModule.forRoot({
      transport: useSendGrid ? {
        // SendGrid SMTP configuration (works on Render and other platforms)
        host: 'smtp.sendgrid.net',
        port: 587,
        secure: false,
        auth: {
          user: 'apikey',
          pass: process.env.SENDGRID_API_KEY,
        },
        // Add connection timeout and retry settings
        connectionTimeout: 60000, // 60 seconds
        greetingTimeout: 30000, // 30 seconds
        socketTimeout: 60000, // 60 seconds
        // Add TLS settings for better compatibility
        tls: {
          rejectUnauthorized: false,
        },
      } : {
        // Fallback to Gmail SMTP for local development
        host: process.env.MAIL_HOST || 'smtp.gmail.com',
        port: parseInt(process.env.MAIL_PORT || '587'),
        secure: process.env.MAIL_SECURE === 'true', // true for 465, false for other ports
        auth: {
          user: process.env.MAIL_USER || '',
          pass: process.env.MAIL_PASSWORD || '',
        },
        // Add connection timeout and retry settings
        connectionTimeout: 60000, // 60 seconds
        greetingTimeout: 30000, // 30 seconds
        socketTimeout: 60000, // 60 seconds
        // Add TLS settings for better compatibility
        tls: {
          rejectUnauthorized: false,
        },
      },
      defaults: {
        from: useSendGrid ?
          `"SendIT" <noreply@sendit.com>` :
          (process.env.MAIL_FROM ||
          `"SendIT" <${process.env.MAIL_USER || 'noreply@sendit.com'}>`),
      },
      template: {
        dir: join(__dirname, 'templates'),
        adapter: new EjsAdapter(),
        options: {
          strict: false, // Changed from true to false to be more permissive
          debug: false, // Disable debug mode to prevent HTML logging
        },
      },
    }),
    forwardRef(() => AuthModule),
    CommonModule,
  ],
  providers: [MailerService],
  exports: [MailerService],
})
export class SendITMailerModule {}
