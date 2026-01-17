/*
  Warnings:

  - The values [PENDING,PICKED_UP,IN_TRANSIT,DELIVERED,CANCELLED] on the enum `ParcelStatus` will be removed. If these variants are still used in the database, this will fail.
  - The values [USER] on the enum `UserRole` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `sentAt` on the `notifications` table. All the data in the column will be lost.
  - You are about to drop the column `subject` on the `notifications` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `notifications` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `parcel_status_history` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `parcel_status_history` table. All the data in the column will be lost.
  - You are about to drop the column `basePrice` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `category` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `deliveredAt` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `deliveryLatitude` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `deliveryLongitude` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `pickedUpAt` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `pickupLatitude` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `pickupLongitude` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `receiverId` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `totalPrice` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `trackingId` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `firstLogin` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `firstName` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `lastName` on the `users` table. All the data in the column will be lost.
  - You are about to drop the `parcel_locations` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `system_settings` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `weight_pricing` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[trackingNumber]` on the table `parcels` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[licenseNumber]` on the table `users` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `title` to the `notifications` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `type` on the `notifications` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `recipientEmail` to the `parcels` table without a default value. This is not possible if the table is not empty.
  - Added the required column `recipientName` to the `parcels` table without a default value. This is not possible if the table is not empty.
  - Added the required column `recipientPhone` to the `parcels` table without a default value. This is not possible if the table is not empty.
  - Added the required column `senderEmail` to the `parcels` table without a default value. This is not possible if the table is not empty.
  - Added the required column `senderName` to the `parcels` table without a default value. This is not possible if the table is not empty.
  - Added the required column `senderPhone` to the `parcels` table without a default value. This is not possible if the table is not empty.
  - Added the required column `trackingNumber` to the `parcels` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "DriverApplicationStatus" AS ENUM ('NOT_APPLIED', 'PENDING', 'APPROVED', 'REJECTED');

-- CreateEnum
CREATE TYPE "VehicleType" AS ENUM ('MOTORCYCLE', 'CAR', 'VAN', 'TRUCK');

-- CreateEnum
CREATE TYPE "ReviewType" AS ENUM ('SERVICE', 'DRIVER', 'DELIVERY_SPEED', 'COMMUNICATION', 'OVERALL');

-- CreateEnum
CREATE TYPE "NotificationType" AS ENUM ('PARCEL_CREATED', 'PARCEL_ASSIGNED', 'PARCEL_PICKED_UP', 'PARCEL_IN_TRANSIT', 'PARCEL_DELIVERED_TO_RECIPIENT', 'PARCEL_DELIVERED', 'PARCEL_COMPLETED', 'DRIVER_ASSIGNED', 'PAYMENT_RECEIVED', 'REVIEW_RECEIVED');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('PENDING', 'PAID', 'FAILED', 'REFUNDED');

-- AlterEnum
BEGIN;
CREATE TYPE "ParcelStatus_new" AS ENUM ('pending', 'assigned', 'picked_up', 'in_transit', 'delivered_to_recipient', 'delivered', 'completed', 'cancelled');
ALTER TABLE "parcels" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "parcels" ALTER COLUMN "status" TYPE "ParcelStatus_new" USING ("status"::text::"ParcelStatus_new");
ALTER TABLE "parcel_status_history" ALTER COLUMN "status" TYPE "ParcelStatus_new" USING ("status"::text::"ParcelStatus_new");
ALTER TYPE "ParcelStatus" RENAME TO "ParcelStatus_old";
ALTER TYPE "ParcelStatus_new" RENAME TO "ParcelStatus";
DROP TYPE "ParcelStatus_old";
ALTER TABLE "parcels" ALTER COLUMN "status" SET DEFAULT 'pending';
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "UserRole_new" AS ENUM ('CUSTOMER', 'DRIVER', 'ADMIN');
ALTER TABLE "users" ALTER COLUMN "role" DROP DEFAULT;
ALTER TABLE "users" ALTER COLUMN "role" TYPE "UserRole_new" USING ("role"::text::"UserRole_new");
ALTER TYPE "UserRole" RENAME TO "UserRole_old";
ALTER TYPE "UserRole_new" RENAME TO "UserRole";
DROP TYPE "UserRole_old";
ALTER TABLE "users" ALTER COLUMN "role" SET DEFAULT 'CUSTOMER';
COMMIT;

-- DropForeignKey
ALTER TABLE "parcel_locations" DROP CONSTRAINT "parcel_locations_parcelId_fkey";

-- DropForeignKey
ALTER TABLE "parcel_status_history" DROP CONSTRAINT "parcel_status_history_parcelId_fkey";

-- DropForeignKey
ALTER TABLE "parcels" DROP CONSTRAINT "parcels_receiverId_fkey";

-- DropForeignKey
ALTER TABLE "parcels" DROP CONSTRAINT "parcels_senderId_fkey";

-- DropIndex
DROP INDEX "parcels_trackingId_key";

-- AlterTable
ALTER TABLE "notifications" DROP COLUMN "sentAt",
DROP COLUMN "subject",
DROP COLUMN "updatedAt",
ADD COLUMN     "actionUrl" TEXT,
ADD COLUMN     "readAt" TIMESTAMP(3),
ADD COLUMN     "title" TEXT NOT NULL,
DROP COLUMN "type",
ADD COLUMN     "type" "NotificationType" NOT NULL;

-- AlterTable
ALTER TABLE "parcel_status_history" DROP COLUMN "createdAt",
DROP COLUMN "updatedAt",
ADD COLUMN     "imageUrl" TEXT,
ADD COLUMN     "latitude" DOUBLE PRECISION,
ADD COLUMN     "location" TEXT,
ADD COLUMN     "longitude" DOUBLE PRECISION,
ADD COLUMN     "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedBy" TEXT;

-- AlterTable
ALTER TABLE "parcels" DROP COLUMN "basePrice",
DROP COLUMN "category",
DROP COLUMN "deliveredAt",
DROP COLUMN "deliveryLatitude",
DROP COLUMN "deliveryLongitude",
DROP COLUMN "pickedUpAt",
DROP COLUMN "pickupLatitude",
DROP COLUMN "pickupLongitude",
DROP COLUMN "receiverId",
DROP COLUMN "totalPrice",
DROP COLUMN "trackingId",
ADD COLUMN     "actualDeliveryTime" TIMESTAMP(3),
ADD COLUMN     "actualPickupTime" TIMESTAMP(3),
ADD COLUMN     "assignedAt" TIMESTAMP(3),
ADD COLUMN     "completedAt" TIMESTAMP(3),
ADD COLUMN     "completedBy" TEXT,
ADD COLUMN     "currentLocation" TEXT,
ADD COLUMN     "customerNotes" TEXT,
ADD COLUMN     "customerSignature" TEXT,
ADD COLUMN     "deliveredToRecipient" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "deliveryAttempts" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "deliveryConfirmedAt" TIMESTAMP(3),
ADD COLUMN     "deliveryConfirmedBy" TEXT,
ADD COLUMN     "deliveryFee" DOUBLE PRECISION,
ADD COLUMN     "deliveryInstructions" TEXT,
ADD COLUMN     "estimatedDeliveryTime" TIMESTAMP(3),
ADD COLUMN     "estimatedPickupTime" TIMESTAMP(3),
ADD COLUMN     "latitude" DOUBLE PRECISION,
ADD COLUMN     "longitude" DOUBLE PRECISION,
ADD COLUMN     "notes" TEXT,
ADD COLUMN     "paymentStatus" "PaymentStatus" NOT NULL DEFAULT 'PENDING',
ADD COLUMN     "recipientEmail" TEXT NOT NULL,
ADD COLUMN     "recipientId" TEXT,
ADD COLUMN     "recipientName" TEXT NOT NULL,
ADD COLUMN     "recipientPhone" TEXT NOT NULL,
ADD COLUMN     "senderEmail" TEXT NOT NULL,
ADD COLUMN     "senderName" TEXT NOT NULL,
ADD COLUMN     "senderPhone" TEXT NOT NULL,
ADD COLUMN     "totalDeliveryTime" INTEGER,
ADD COLUMN     "trackingNumber" TEXT NOT NULL,
ADD COLUMN     "value" DOUBLE PRECISION,
ALTER COLUMN "senderId" DROP NOT NULL,
ALTER COLUMN "status" SET DEFAULT 'pending',
ALTER COLUMN "description" DROP NOT NULL;

-- AlterTable
ALTER TABLE "users" DROP COLUMN "firstLogin",
DROP COLUMN "firstName",
DROP COLUMN "lastName",
ADD COLUMN     "address" TEXT,
ADD COLUMN     "averageDeliveryTime" INTEGER,
ADD COLUMN     "averageRating" DOUBLE PRECISION DEFAULT 0,
ADD COLUMN     "cancelledDeliveries" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "completedDeliveries" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "currentLat" DOUBLE PRECISION,
ADD COLUMN     "currentLng" DOUBLE PRECISION,
ADD COLUMN     "driverApplicationDate" TIMESTAMP(3),
ADD COLUMN     "driverApplicationReason" TEXT,
ADD COLUMN     "driverApplicationStatus" "DriverApplicationStatus" DEFAULT 'NOT_APPLIED',
ADD COLUMN     "driverApprovalDate" TIMESTAMP(3),
ADD COLUMN     "driverApprovedBy" TEXT,
ADD COLUMN     "driverRejectionReason" TEXT,
ADD COLUMN     "isAvailable" BOOLEAN DEFAULT true,
ADD COLUMN     "lastActiveAt" TIMESTAMP(3),
ADD COLUMN     "licenseNumber" TEXT,
ADD COLUMN     "name" TEXT NOT NULL,
ADD COLUMN     "onTimeDeliveryRate" DOUBLE PRECISION DEFAULT 0,
ADD COLUMN     "preferredPaymentMethod" TEXT,
ADD COLUMN     "profilePicture" TEXT,
ADD COLUMN     "totalDeliveries" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "totalEarnings" DOUBLE PRECISION DEFAULT 0,
ADD COLUMN     "totalParcelsEverSent" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "totalParcelsReceived" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "totalRatings" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "vehicleNumber" TEXT,
ADD COLUMN     "vehicleType" "VehicleType",
ALTER COLUMN "role" SET DEFAULT 'CUSTOMER';

-- DropTable
DROP TABLE "parcel_locations";

-- DropTable
DROP TABLE "system_settings";

-- DropTable
DROP TABLE "weight_pricing";

-- DropEnum
DROP TYPE "WeightCategory";

-- CreateTable
CREATE TABLE "reviews" (
    "id" TEXT NOT NULL,
    "parcelId" TEXT NOT NULL,
    "reviewerId" TEXT NOT NULL,
    "revieweeId" TEXT,
    "rating" INTEGER NOT NULL,
    "comment" TEXT,
    "reviewType" "ReviewType" NOT NULL,
    "isPublic" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reviews_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "delivery_proofs" (
    "id" TEXT NOT NULL,
    "parcelId" TEXT NOT NULL,
    "customerSignature" TEXT,
    "recipientName" TEXT NOT NULL,
    "deliveredAt" TIMESTAMP(3) NOT NULL,
    "confirmedAt" TIMESTAMP(3) NOT NULL,
    "deliveredBy" TEXT NOT NULL,
    "confirmedBy" TEXT NOT NULL,
    "customerNotes" TEXT,
    "driverNotes" TEXT,

    CONSTRAINT "delivery_proofs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "password_reset_tokens" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "used" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "password_reset_tokens_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "delivery_proofs_parcelId_key" ON "delivery_proofs"("parcelId");

-- CreateIndex
CREATE UNIQUE INDEX "parcels_trackingNumber_key" ON "parcels"("trackingNumber");

-- CreateIndex
CREATE INDEX "parcels_senderName_idx" ON "parcels"("senderName");

-- CreateIndex
CREATE INDEX "parcels_senderEmail_idx" ON "parcels"("senderEmail");

-- CreateIndex
CREATE INDEX "parcels_recipientName_idx" ON "parcels"("recipientName");

-- CreateIndex
CREATE INDEX "parcels_recipientEmail_idx" ON "parcels"("recipientEmail");

-- CreateIndex
CREATE INDEX "parcels_senderId_idx" ON "parcels"("senderId");

-- CreateIndex
CREATE INDEX "parcels_recipientId_idx" ON "parcels"("recipientId");

-- CreateIndex
CREATE INDEX "parcels_driverId_idx" ON "parcels"("driverId");

-- CreateIndex
CREATE INDEX "parcels_status_idx" ON "parcels"("status");

-- CreateIndex
CREATE INDEX "parcels_createdAt_idx" ON "parcels"("createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "users_licenseNumber_key" ON "users"("licenseNumber");

-- CreateIndex
CREATE INDEX "users_name_idx" ON "users"("name");

-- CreateIndex
CREATE INDEX "users_email_idx" ON "users"("email");

-- CreateIndex
CREATE INDEX "users_phone_idx" ON "users"("phone");

-- CreateIndex
CREATE INDEX "users_role_idx" ON "users"("role");

-- CreateIndex
CREATE INDEX "users_isActive_idx" ON "users"("isActive");

-- CreateIndex
CREATE INDEX "users_createdAt_idx" ON "users"("createdAt");

-- AddForeignKey
ALTER TABLE "parcels" ADD CONSTRAINT "parcels_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "parcels" ADD CONSTRAINT "parcels_recipientId_fkey" FOREIGN KEY ("recipientId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_parcelId_fkey" FOREIGN KEY ("parcelId") REFERENCES "parcels"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_reviewerId_fkey" FOREIGN KEY ("reviewerId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_revieweeId_fkey" FOREIGN KEY ("revieweeId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "parcel_status_history" ADD CONSTRAINT "parcel_status_history_parcelId_fkey" FOREIGN KEY ("parcelId") REFERENCES "parcels"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "parcel_status_history" ADD CONSTRAINT "parcel_status_history_updatedBy_fkey" FOREIGN KEY ("updatedBy") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "delivery_proofs" ADD CONSTRAINT "delivery_proofs_parcelId_fkey" FOREIGN KEY ("parcelId") REFERENCES "parcels"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "delivery_proofs" ADD CONSTRAINT "delivery_proofs_deliveredBy_fkey" FOREIGN KEY ("deliveredBy") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "delivery_proofs" ADD CONSTRAINT "delivery_proofs_confirmedBy_fkey" FOREIGN KEY ("confirmedBy") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
