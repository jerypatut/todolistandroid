import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  ManyToOne,
  JoinColumn,
} from 'typeorm';
import { Kategori } from '../kategori/kategori.entity';

@Entity()
export class Barang {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  nama_barang: string;

  @Column()
  kategori_id: number;

  @ManyToOne(() => Kategori, (k) => k.barang)
  @JoinColumn({ name: 'kategori_id' })
  kategori: Kategori;

  @Column('int')
  stok: number;

  @Column({ nullable: true })
  kelompok_barang: string;

  @Column('int')
  harga: number;
}
