import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcrypt';

const prisma = new PrismaClient();

async function main() {
  const adminEmail = 'admin@sendit.com';

  const existingAdmin = await prisma.user.findUnique({
    where: { email: adminEmail },
  });

  if (!existingAdmin) {
    const password = await bcrypt.hash('admin123', 12);

    await prisma.user.create({
      data: {
        email: adminEmail,
        password,
        name: 'Admin',
        role: 'ADMIN',
        isActive: true,
        phone: null,
        address: null,
        // Set default values for metrics
        averageRating: 0,
        totalRatings: 0,
        totalDeliveries: 0,
        completedDeliveries: 0,
        cancelledDeliveries: 0,
        onTimeDeliveryRate: 0,
        totalEarnings: 0,
        totalParcelsEverSent: 0,
        totalParcelsReceived: 0,
        isAvailable: true,
      },
    });

    console.log('✅ Admin user created');
  } else {
    // Update existing admin with correct password hash
    const password = await bcrypt.hash('admin123', 12);
    await prisma.user.update({
      where: { email: adminEmail },
      data: { password },
    });
    console.log('✅ Admin password updated');
  }
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });