import { NestFactory } from '@nestjs/core';
import { Logger, ValidationPipe } from '@nestjs/common';
import { AppModule } from './app.module';

async function bootstrap() {
  const logger = new Logger('Bootstrap');

  const isProd =
    process.env.NODE_ENV === 'production' ||
    process.env.APP_ENV === 'production';

  const app = await NestFactory.create(AppModule, {
    logger: isProd
      ? ['error', 'warn', 'log']
      : ['error', 'warn', 'log', 'debug', 'verbose'],
  });

  /**
   * CORS CONFIGURATION
   */
  app.enableCors({
    origin: [
      'http://localhost:4200',
      'http://localhost:5173',
      'https://sendit-frontend-pied.vercel.app',
    ],
    credentials: true,
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS',

  });

  /**
   * GLOBAL VALIDATION
   */
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
      transform: true,
    }),
  );

  /**
   * GLOBAL API PREFIX
   */
  app.setGlobalPrefix('api');

  /**
   * PORT — Render injects this
   */
  const port = Number(process.env.PORT) || 3000;

  await app.listen(port, '0.0.0.0');

  logger.log(`🚀 Backend running on port ${port}`);
}

bootstrap().catch((err) => {
  console.error('❌ Application failed to start', err);
  process.exit(1);
});
