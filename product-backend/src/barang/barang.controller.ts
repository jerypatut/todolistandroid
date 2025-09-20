import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Param,
  Body,
} from '@nestjs/common';
import { BarangService } from './barang.service';
import { Barang } from './barang.entity';

@Controller('barang')
export class BarangController {
  constructor(private readonly barangService: BarangService) {}

  @Get()
  getAll() {
    return this.barangService.findAll();
  }

  @Get(':id')
  getOne(@Param('id') id: number) {
    return this.barangService.findOne(id);
  }

  @Post()
  create(@Body() barang: Barang) {
    return this.barangService.create(barang);
  }

  @Put(':id')
  update(@Param('id') id: number, @Body() barang: Barang) {
    return this.barangService.update(id, barang);
  }

  @Delete(':id')
  remove(@Param('id') id: number) {
    return this.barangService.remove(id);
  }
}
