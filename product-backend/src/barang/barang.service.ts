import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Barang } from './barang.entity';

@Injectable()
export class BarangService {
  constructor(
    @InjectRepository(Barang)
    private barangRepo: Repository<Barang>,
  ) {}

  findAll() {
    return this.barangRepo.find();
  }

  findOne(id: number) {
    return this.barangRepo.findOneBy({ id });
  }

  create(barang: Partial<Barang>) {
    return this.barangRepo.save(barang);
  }

  update(id: number, barang: Partial<Barang>) {
    return this.barangRepo.update(id, barang);
  }

  remove(id: number) {
    return this.barangRepo.delete(id);
  }
}
