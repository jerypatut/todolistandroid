import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Kategori } from './kategori.entity';

@Injectable()
export class KategoriService {
  constructor(
    @InjectRepository(Kategori)
    private kategoriRepo: Repository<Kategori>,
  ) {}

  findAll() {
    return this.kategoriRepo.find();
  }
}
