import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { KategoriController } from './kategori.controller';
import { KategoriService } from './kategori.service';
import { Kategori } from './kategori.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Kategori])],
  controllers: [KategoriController],
  providers: [KategoriService],
  exports: [KategoriService],
})
export class KategoriModule {}
