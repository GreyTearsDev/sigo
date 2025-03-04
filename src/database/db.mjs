import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient({ errorFormat: "pretty" });

const brand = {
  // CRUD operations for the "brand" model
  create: async (name) => {
    console.log("hello");
    try {
      return await prisma.brand.create({ data: { name } });
    } catch (e) {
      throw new Error(`Failed to create brand: ${e.message}`);
    }
  },
  getById: async (id) => {
    try {
      return await prisma.brand.findUnique({ where: { id } });
    } catch (e) {
      throw new Error(`Failed to get brand: ${e.message}`);
    }
  },
  getByName: async (name) => {
    try {
      return await prisma.brand.findUnique({ where: { name } });
    } catch (e) {
      throw new Error(`Failed to get brand: ${e.message}`);
    }
  },
  update: async (brand, newName) => {
    const id = brand.id;
    try {
      return await prisma.brand.update({
        where: { id },
        data: { name: newName },
      });
    } catch (e) {
      throw new Error(`Failed to update brand: ${e.message}`);
    }
  },
  remove: async (brand) => {
    const id = brand.id;
    try {
      await prisma.brand.delete({ where: { id } });
    } catch (e) {
      throw new Error(`Failed to delete brand: ${e.message}`);
    }
  },
};

export const db = { brand };
