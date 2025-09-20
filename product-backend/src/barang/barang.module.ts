import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { BarangController } from './barang.controller';
import { BarangService } from '../barang/barang.service';
import { Barang } from '../barang/barang.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Barang])],
  controllers: [BarangController],
  providers: [BarangService],
  exports: [BarangService],
})
export class BarangModule {}
