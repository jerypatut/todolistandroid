import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // ✅ Aktifkan CORS
  app.enableCors({
    origin: '*', // bisa juga diganti ke 'http://localhost:xxxx' biar lebih aman
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    credentials: true,
  });

  await app.listen(process.env.PORT ?? 3004);
}
bootstrap();
