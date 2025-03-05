-- CreateEnum
CREATE TYPE "MaintenanceStatus" AS ENUM ('PENDING', 'IN_PROGRESS', 'COMPLETED');

-- CreateEnum
CREATE TYPE "ACUnitStatus" AS ENUM ('OUT_OF_SERVICE', 'NEEDS_MAINTENANCE', 'FUNCTIONAL');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(300) NOT NULL,
    "password" VARCHAR(100) NOT NULL,
    "isAdmin" BOOLEAN NOT NULL DEFAULT false,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Supplier" (
    "id" SERIAL NOT NULL,
    "nif" VARCHAR(14) NOT NULL,
    "name" VARCHAR(300) NOT NULL,
    "email" TEXT,
    "phone" TEXT,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Supplier_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Maintenance" (
    "id" SERIAL NOT NULL,
    "scheduledDate" TIMESTAMP(3) NOT NULL,
    "executedDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "supplierId" TEXT NOT NULL,
    "status" "MaintenanceStatus" NOT NULL DEFAULT 'PENDING',
    "details" VARCHAR(1000),
    "acUnitId" INTEGER NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Maintenance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Diagnosis" (
    "id" SERIAL NOT NULL,
    "type" VARCHAR(500) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Diagnosis_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Cause" (
    "id" SERIAL NOT NULL,
    "type" VARCHAR(500) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Cause_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Solution" (
    "id" SERIAL NOT NULL,
    "type" VARCHAR(500) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Solution_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Brand" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(500) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Brand_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AirConditioningUnit" (
    "id" SERIAL NOT NULL,
    "serialNumber" INTEGER NOT NULL,
    "brandId" INTEGER NOT NULL,
    "model" VARCHAR(500) NOT NULL,
    "btu" INTEGER NOT NULL,
    "status" "ACUnitStatus" NOT NULL DEFAULT 'FUNCTIONAL',
    "installationDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AirConditioningUnit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_MaintenanceToSolution" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_MaintenanceToSolution_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateTable
CREATE TABLE "_DiagnosisToMaintenance" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_DiagnosisToMaintenance_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateTable
CREATE TABLE "_CauseToMaintenance" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_CauseToMaintenance_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_id_key" ON "User"("id");

-- CreateIndex
CREATE UNIQUE INDEX "User_name_key" ON "User"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Supplier_id_key" ON "Supplier"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Supplier_nif_key" ON "Supplier"("nif");

-- CreateIndex
CREATE UNIQUE INDEX "Supplier_name_key" ON "Supplier"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Maintenance_id_key" ON "Maintenance"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Diagnosis_id_key" ON "Diagnosis"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Cause_id_key" ON "Cause"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Solution_id_key" ON "Solution"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Brand_id_key" ON "Brand"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Brand_name_key" ON "Brand"("name");

-- CreateIndex
CREATE UNIQUE INDEX "AirConditioningUnit_id_key" ON "AirConditioningUnit"("id");

-- CreateIndex
CREATE UNIQUE INDEX "AirConditioningUnit_serialNumber_key" ON "AirConditioningUnit"("serialNumber");

-- CreateIndex
CREATE INDEX "_MaintenanceToSolution_B_index" ON "_MaintenanceToSolution"("B");

-- CreateIndex
CREATE INDEX "_DiagnosisToMaintenance_B_index" ON "_DiagnosisToMaintenance"("B");

-- CreateIndex
CREATE INDEX "_CauseToMaintenance_B_index" ON "_CauseToMaintenance"("B");

-- AddForeignKey
ALTER TABLE "Maintenance" ADD CONSTRAINT "Maintenance_acUnitId_fkey" FOREIGN KEY ("acUnitId") REFERENCES "AirConditioningUnit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Maintenance" ADD CONSTRAINT "Maintenance_supplierId_fkey" FOREIGN KEY ("supplierId") REFERENCES "Supplier"("nif") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AirConditioningUnit" ADD CONSTRAINT "AirConditioningUnit_brandId_fkey" FOREIGN KEY ("brandId") REFERENCES "Brand"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_MaintenanceToSolution" ADD CONSTRAINT "_MaintenanceToSolution_A_fkey" FOREIGN KEY ("A") REFERENCES "Maintenance"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_MaintenanceToSolution" ADD CONSTRAINT "_MaintenanceToSolution_B_fkey" FOREIGN KEY ("B") REFERENCES "Solution"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_DiagnosisToMaintenance" ADD CONSTRAINT "_DiagnosisToMaintenance_A_fkey" FOREIGN KEY ("A") REFERENCES "Diagnosis"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_DiagnosisToMaintenance" ADD CONSTRAINT "_DiagnosisToMaintenance_B_fkey" FOREIGN KEY ("B") REFERENCES "Maintenance"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CauseToMaintenance" ADD CONSTRAINT "_CauseToMaintenance_A_fkey" FOREIGN KEY ("A") REFERENCES "Cause"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CauseToMaintenance" ADD CONSTRAINT "_CauseToMaintenance_B_fkey" FOREIGN KEY ("B") REFERENCES "Maintenance"("id") ON DELETE CASCADE ON UPDATE CASCADE;
