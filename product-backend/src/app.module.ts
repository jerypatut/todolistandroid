// src/app.module.ts
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { BarangModule } from './barang/barang.module';
import { KategoriModule } from './kategori/kategori.module';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: 'localhost',
      port: 3306,
      username: 'root', // sesuaikan
      password: '', // sesuaikan
      database: 'product_db',
      entities: [__dirname + '/**/*.entity{.ts,.js}'],
      synchronize: true, // development only
    }),
    BarangModule,
    KategoriModule,
  ],
})
export class AppModule {}
