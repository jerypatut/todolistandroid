import { Controller, Get } from '@nestjs/common';
import { KategoriService } from './kategori.service';

@Controller('kategori')
export class KategoriController {
  constructor(private readonly kategoriService: KategoriService) {}

  @Get()
  getAll() {
    return this.kategoriService.findAll();
  }
}
