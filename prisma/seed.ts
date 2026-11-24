// prisma/seed.ts
// Creates test accounts. Run with: npx prisma db seed
import "dotenv/config";
import bcrypt from "bcryptjs";
import { prisma } from "../lib/prisma";

async function main() {
  const passwordHash = await bcrypt.hash("test1234", 10);

  await prisma.user.upsert({
    where: { email: "reception@test.ma" },
    update: {},
    create: {
      name: "Réception Test",
      email: "reception@test.ma",
      passwordHash,
      role: "RECEPTIONIST",
    },
  });

  await prisma.user.upsert({
    where: { email: "doctor@test.ma" },
    update: {},
    create: {
      name: "Dr Test",
      email: "doctor@test.ma",
      passwordHash,
      role: "DOCTOR",
    },
  });

  console.log("Test users created");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());
