/*
  Warnings:

  - The values [DOCTORE] on the enum `Role` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `Address` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `DateOfBirth` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `FirstName` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `LastName` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `Phone` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `CreatedAt` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `PasswordHash` on the `User` table. All the data in the column will be lost.
  - Added the required column `dateOfBirth` to the `Patient` table without a default value. This is not possible if the table is not empty.
  - Added the required column `firstName` to the `Patient` table without a default value. This is not possible if the table is not empty.
  - Added the required column `lastName` to the `Patient` table without a default value. This is not possible if the table is not empty.
  - Added the required column `passwordHash` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "Role_new" AS ENUM ('DOCTOR', 'RECEPTIONIST', 'ADMIN');
ALTER TABLE "User" ALTER COLUMN "role" TYPE "Role_new" USING ("role"::text::"Role_new");
ALTER TYPE "Role" RENAME TO "Role_old";
ALTER TYPE "Role_new" RENAME TO "Role";
DROP TYPE "public"."Role_old";
COMMIT;

-- AlterTable
ALTER TABLE "Patient" DROP COLUMN "Address",
DROP COLUMN "DateOfBirth",
DROP COLUMN "FirstName",
DROP COLUMN "LastName",
DROP COLUMN "Phone",
ADD COLUMN     "address" TEXT,
ADD COLUMN     "dateOfBirth" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "firstName" TEXT NOT NULL,
ADD COLUMN     "lastName" TEXT NOT NULL,
ADD COLUMN     "phone" TEXT;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "CreatedAt",
DROP COLUMN "PasswordHash",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "passwordHash" TEXT NOT NULL;
