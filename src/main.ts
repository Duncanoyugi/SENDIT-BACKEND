import { NestFactory } from '@nestjs/core';
import { Logger, ValidationPipe } from '@nestjs/common';
import { AppModule } from './app.module';

async function bootstrap() {
  const isProd = process.env.APP_ENV === 'production';

  const logger = new Logger('Bootstrap');

  try {
    const app = await NestFactory.create(AppModule, {
      logger: isProd
        ? ['error', 'warn', 'log']
        : ['error', 'warn', 'log', 'debug', 'verbose'],
    });

    // Enable CORS
    app.enableCors({
      origin: [ 'http://localhost:4200',
        'https://sendit-frontend-pied.vercel.app',
      ],
      credentials: true,
      methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS'],
      allowedHeaders: ['*'],
    });

    // Global validation (lighter in production)
    app.useGlobalPipes(
      new ValidationPipe({
        whitelist: true,
        forbidNonWhitelisted: true,
        transform: !isProd, // avoid heavy class-transformer in prod
      }),
    );

    // Global API prefix
    app.setGlobalPrefix('api');

    const port = Number(process.env.PORT) || 3000;

    // REQUIRED for Render
    await app.listen(port, '0.0.0.0');

    logger.log(`Application running on port ${port}`);
  } catch (error) {
    logger.error(
      'Failed to start application',
      error instanceof Error ? error.stack : error,
    );
    process.exit(1);
  }
}

void bootstrap();
