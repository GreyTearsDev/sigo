import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient({ errorFormat: "pretty" });

export const alert = {
  create: async (title, message) => {
    try {
      return await prisma.alert.create({
        data: {
          title,
          message,
        },
      });
    } catch (e) {
      throw new Error(`Failed to create alert: ${e.message}`);
    }
  },
  getById: async (id) => {
    try {
      return await prisma.alert.findUnique({ where: { id } });
    } catch (e) {
      throw new Error(`Failed to get alert: ${e.message}`);
    }
  },
  getByTitle: async (title) => {
    try {
      return await prisma.alert.findUnique({ where: { title } });
    } catch (e) {
      throw new Error(`Failed to get alert: ${e.message}`);
    }
  },
};
