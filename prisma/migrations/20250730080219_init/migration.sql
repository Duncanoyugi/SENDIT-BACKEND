/*
  Warnings:

  - The values [pending,picked_up,in_transit,delivered,cancelled,assigned,delivered_to_recipient,completed] on the enum `ParcelStatus` will be removed. If these variants are still used in the database, this will fail.
  - The values [CUSTOMER] on the enum `UserRole` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `actionUrl` on the `notifications` table. All the data in the column will be lost.
  - You are about to drop the column `readAt` on the `notifications` table. All the data in the column will be lost.
  - You are about to drop the column `title` on the `notifications` table. All the data in the column will be lost.
  - You are about to drop the column `imageUrl` on the `parcel_status_history` table. All the data in the column will be lost.
  - You are about to drop the column `latitude` on the `parcel_status_history` table. All the data in the column will be lost.
  - You are about to drop the column `location` on the `parcel_status_history` table. All the data in the column will be lost.
  - You are about to drop the column `longitude` on the `parcel_status_history` table. All the data in the column will be lost.
  - You are about to drop the column `timestamp` on the `parcel_status_history` table. All the data in the column will be lost.
  - You are about to drop the column `updatedBy` on the `parcel_status_history` table. All the data in the column will be lost.
  - You are about to drop the column `actualDeliveryTime` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `actualPickupTime` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `assignedAt` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `completedAt` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `completedBy` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `currentLocation` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `customerNotes` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `customerSignature` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `deliveredToRecipient` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `deliveryAttempts` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `deliveryConfirmedAt` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `deliveryConfirmedBy` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `deliveryFee` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `deliveryInstructions` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `estimatedDeliveryTime` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `estimatedPickupTime` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `latitude` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `longitude` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `notes` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `paymentStatus` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `recipientEmail` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `recipientId` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `recipientName` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `recipientPhone` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `senderEmail` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `senderName` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `senderPhone` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `totalDeliveryTime` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `trackingNumber` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `value` on the `parcels` table. All the data in the column will be lost.
  - You are about to drop the column `address` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `averageDeliveryTime` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `averageRating` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `cancelledDeliveries` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `completedDeliveries` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `currentLat` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `currentLng` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `driverApplicationDate` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `driverApplicationReason` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `driverApplicationStatus` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `driverApprovalDate` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `driverApprovedBy` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `driverRejectionReason` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `isAvailable` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `lastActiveAt` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `licenseNumber` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `onTimeDeliveryRate` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `preferredPaymentMethod` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `profilePicture` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `totalDeliveries` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `totalEarnings` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `totalParcelsEverSent` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `totalParcelsReceived` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `totalRatings` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `vehicleNumber` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `vehicleType` on the `users` table. All the data in the column will be lost.
  - You are about to drop the `delivery_proofs` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `password_reset_tokens` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `reviews` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[trackingId]` on the table `parcels` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `updatedAt` to the `notifications` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `type` on the `notifications` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `updatedAt` to the `parcel_status_history` table without a default value. This is not possible if the table is not empty.
  - Added the required column `basePrice` to the `parcels` table without a default value. This is not possible if the table is not empty.
  - Added the required column `category` to the `parcels` table without a default value. This is not possible if the table is not empty.
  - Added the required column `receiverId` to the `parcels` table without a default value. This is not possible if the table is not empty.
  - Added the required column `totalPrice` to the `parcels` table without a default value. This is not possible if the table is not empty.
  - The required column `trackingId` was added to the `parcels` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - Made the column `senderId` on table `parcels` required. This step will fail if there are existing NULL values in that column.
  - Made the column `description` on table `parcels` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `firstName` to the `users` table without a default value. This is not possible if the table is not empty.
  - Added the required column `lastName` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "WeightCategory" AS ENUM ('LIGHT', 'MEDIUM', 'HEAVY', 'EXTRA_HEAVY');

-- AlterEnum
BEGIN;
CREATE TYPE "ParcelStatus_new" AS ENUM ('PENDING', 'PICKED_UP', 'IN_TRANSIT', 'DELIVERED', 'CANCELLED');
ALTER TABLE "parcels" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "parcels" ALTER COLUMN "status" TYPE "ParcelStatus_new" USING ("status"::text::"ParcelStatus_new");
ALTER TABLE "parcel_status_history" ALTER COLUMN "status" TYPE "ParcelStatus_new" USING ("status"::text::"ParcelStatus_new");
ALTER TYPE "ParcelStatus" RENAME TO "ParcelStatus_old";
ALTER TYPE "ParcelStatus_new" RENAME TO "ParcelStatus";
DROP TYPE "ParcelStatus_old";
ALTER TABLE "parcels" ALTER COLUMN "status" SET DEFAULT 'PENDING';
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "UserRole_new" AS ENUM ('ADMIN', 'USER', 'DRIVER');
ALTER TABLE "users" ALTER COLUMN "role" DROP DEFAULT;
ALTER TABLE "users" ALTER COLUMN "role" TYPE "UserRole_new" USING ("role"::text::"UserRole_new");
ALTER TYPE "UserRole" RENAME TO "UserRole_old";
ALTER TYPE "UserRole_new" RENAME TO "UserRole";
DROP TYPE "UserRole_old";
ALTER TABLE "users" ALTER COLUMN "role" SET DEFAULT 'USER';
COMMIT;

-- DropForeignKey
ALTER TABLE "delivery_proofs" DROP CONSTRAINT "delivery_proofs_confirmedBy_fkey";

-- DropForeignKey
ALTER TABLE "delivery_proofs" DROP CONSTRAINT "delivery_proofs_deliveredBy_fkey";

-- DropForeignKey
ALTER TABLE "delivery_proofs" DROP CONSTRAINT "delivery_proofs_parcelId_fkey";

-- DropForeignKey
ALTER TABLE "parcel_status_history" DROP CONSTRAINT "parcel_status_history_parcelId_fkey";

-- DropForeignKey
ALTER TABLE "parcel_status_history" DROP CONSTRAINT "parcel_status_history_updatedBy_fkey";

-- DropForeignKey
ALTER TABLE "parcels" DROP CONSTRAINT "parcels_recipientId_fkey";

-- DropForeignKey
ALTER TABLE "parcels" DROP CONSTRAINT "parcels_senderId_fkey";

-- DropForeignKey
ALTER TABLE "reviews" DROP CONSTRAINT "reviews_parcelId_fkey";

-- DropForeignKey
ALTER TABLE "reviews" DROP CONSTRAINT "reviews_revieweeId_fkey";

-- DropForeignKey
ALTER TABLE "reviews" DROP CONSTRAINT "reviews_reviewerId_fkey";

-- DropIndex
DROP INDEX "parcels_createdAt_idx";

-- DropIndex
DROP INDEX "parcels_driverId_idx";

-- DropIndex
DROP INDEX "parcels_recipientEmail_idx";

-- DropIndex
DROP INDEX "parcels_recipientId_idx";

-- DropIndex
DROP INDEX "parcels_recipientName_idx";

-- DropIndex
DROP INDEX "parcels_senderEmail_idx";

-- DropIndex
DROP INDEX "parcels_senderId_idx";

-- DropIndex
DROP INDEX "parcels_senderName_idx";

-- DropIndex
DROP INDEX "parcels_status_idx";

-- DropIndex
DROP INDEX "parcels_trackingNumber_key";

-- DropIndex
DROP INDEX "users_createdAt_idx";

-- DropIndex
DROP INDEX "users_email_idx";

-- DropIndex
DROP INDEX "users_isActive_idx";

-- DropIndex
DROP INDEX "users_licenseNumber_key";

-- DropIndex
DROP INDEX "users_name_idx";

-- DropIndex
DROP INDEX "users_phone_idx";

-- DropIndex
DROP INDEX "users_role_idx";

-- AlterTable
ALTER TABLE "notifications" DROP COLUMN "actionUrl",
DROP COLUMN "readAt",
DROP COLUMN "title",
ADD COLUMN     "sentAt" TIMESTAMP(3),
ADD COLUMN     "subject" TEXT,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
DROP COLUMN "type",
ADD COLUMN     "type" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "parcel_status_history" DROP COLUMN "imageUrl",
DROP COLUMN "latitude",
DROP COLUMN "location",
DROP COLUMN "longitude",
DROP COLUMN "timestamp",
DROP COLUMN "updatedBy",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "parcels" DROP COLUMN "actualDeliveryTime",
DROP COLUMN "actualPickupTime",
DROP COLUMN "assignedAt",
DROP COLUMN "completedAt",
DROP COLUMN "completedBy",
DROP COLUMN "currentLocation",
DROP COLUMN "customerNotes",
DROP COLUMN "customerSignature",
DROP COLUMN "deliveredToRecipient",
DROP COLUMN "deliveryAttempts",
DROP COLUMN "deliveryConfirmedAt",
DROP COLUMN "deliveryConfirmedBy",
DROP COLUMN "deliveryFee",
DROP COLUMN "deliveryInstructions",
DROP COLUMN "estimatedDeliveryTime",
DROP COLUMN "estimatedPickupTime",
DROP COLUMN "latitude",
DROP COLUMN "longitude",
DROP COLUMN "notes",
DROP COLUMN "paymentStatus",
DROP COLUMN "recipientEmail",
DROP COLUMN "recipientId",
DROP COLUMN "recipientName",
DROP COLUMN "recipientPhone",
DROP COLUMN "senderEmail",
DROP COLUMN "senderName",
DROP COLUMN "senderPhone",
DROP COLUMN "totalDeliveryTime",
DROP COLUMN "trackingNumber",
DROP COLUMN "value",
ADD COLUMN     "basePrice" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "category" "WeightCategory" NOT NULL,
ADD COLUMN     "deliveredAt" TIMESTAMP(3),
ADD COLUMN     "deliveryLatitude" DOUBLE PRECISION,
ADD COLUMN     "deliveryLongitude" DOUBLE PRECISION,
ADD COLUMN     "pickedUpAt" TIMESTAMP(3),
ADD COLUMN     "pickupLatitude" DOUBLE PRECISION,
ADD COLUMN     "pickupLongitude" DOUBLE PRECISION,
ADD COLUMN     "receiverId" TEXT NOT NULL,
ADD COLUMN     "totalPrice" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "trackingId" TEXT NOT NULL,
ALTER COLUMN "senderId" SET NOT NULL,
ALTER COLUMN "status" SET DEFAULT 'PENDING',
ALTER COLUMN "description" SET NOT NULL;

-- AlterTable
ALTER TABLE "users" DROP COLUMN "address",
DROP COLUMN "averageDeliveryTime",
DROP COLUMN "averageRating",
DROP COLUMN "cancelledDeliveries",
DROP COLUMN "completedDeliveries",
DROP COLUMN "currentLat",
DROP COLUMN "currentLng",
DROP COLUMN "driverApplicationDate",
DROP COLUMN "driverApplicationReason",
DROP COLUMN "driverApplicationStatus",
DROP COLUMN "driverApprovalDate",
DROP COLUMN "driverApprovedBy",
DROP COLUMN "driverRejectionReason",
DROP COLUMN "isAvailable",
DROP COLUMN "lastActiveAt",
DROP COLUMN "licenseNumber",
DROP COLUMN "name",
DROP COLUMN "onTimeDeliveryRate",
DROP COLUMN "preferredPaymentMethod",
DROP COLUMN "profilePicture",
DROP COLUMN "totalDeliveries",
DROP COLUMN "totalEarnings",
DROP COLUMN "totalParcelsEverSent",
DROP COLUMN "totalParcelsReceived",
DROP COLUMN "totalRatings",
DROP COLUMN "vehicleNumber",
DROP COLUMN "vehicleType",
ADD COLUMN     "firstLogin" BOOLEAN NOT NULL DEFAULT true,
ADD COLUMN     "firstName" TEXT NOT NULL,
ADD COLUMN     "lastName" TEXT NOT NULL,
ALTER COLUMN "role" SET DEFAULT 'USER';

-- DropTable
DROP TABLE "delivery_proofs";

-- DropTable
DROP TABLE "password_reset_tokens";

-- DropTable
DROP TABLE "reviews";

-- DropEnum
DROP TYPE "DriverApplicationStatus";

-- DropEnum
DROP TYPE "NotificationType";

-- DropEnum
DROP TYPE "PaymentStatus";

-- DropEnum
DROP TYPE "ReviewType";

-- DropEnum
DROP TYPE "VehicleType";

-- CreateTable
CREATE TABLE "parcel_locations" (
    "id" TEXT NOT NULL,
    "parcelId" TEXT NOT NULL,
    "latitude" DOUBLE PRECISION NOT NULL,
    "longitude" DOUBLE PRECISION NOT NULL,
    "recordedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "parcel_locations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "weight_pricing" (
    "id" TEXT NOT NULL,
    "category" "WeightCategory" NOT NULL,
    "minWeight" DOUBLE PRECISION NOT NULL,
    "maxWeight" DOUBLE PRECISION,
    "pricePerKg" DOUBLE PRECISION NOT NULL,
    "basePrice" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "weight_pricing_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "system_settings" (
    "id" TEXT NOT NULL,
    "key" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "system_settings_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "parcel_locations_parcelId_recordedAt_idx" ON "parcel_locations"("parcelId", "recordedAt");

-- CreateIndex
CREATE UNIQUE INDEX "weight_pricing_category_key" ON "weight_pricing"("category");

-- CreateIndex
CREATE UNIQUE INDEX "system_settings_key_key" ON "system_settings"("key");

-- CreateIndex
CREATE UNIQUE INDEX "parcels_trackingId_key" ON "parcels"("trackingId");

-- AddForeignKey
ALTER TABLE "parcels" ADD CONSTRAINT "parcels_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "parcels" ADD CONSTRAINT "parcels_receiverId_fkey" FOREIGN KEY ("receiverId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "parcel_locations" ADD CONSTRAINT "parcel_locations_parcelId_fkey" FOREIGN KEY ("parcelId") REFERENCES "parcels"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "parcel_status_history" ADD CONSTRAINT "parcel_status_history_parcelId_fkey" FOREIGN KEY ("parcelId") REFERENCES "parcels"("id") ON DELETE CASCADE ON UPDATE CASCADE;
