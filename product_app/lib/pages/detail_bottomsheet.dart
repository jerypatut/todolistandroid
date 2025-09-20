import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/barang_controller.dart';
import '../models/barang_model.dart';
import 'add_edit_page.dart';

class DetailBottomSheet extends StatelessWidget {
final Barang barang; 
final BarangController 
controller = Get.find(); DetailBottomSheet({super.key, required this.barang});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey[100], // background terang modern
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header drag indicator
          Center(
            child: Container(
              width: 50,
              height: 5,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          // Nama Barang
          Text(
            barang.namaBarang,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          // Info Barang
          _buildInfoRow('Stok', barang.stok.toString()),
          _buildInfoRow('Harga', controller.formatRupiah(barang.harga)),
          _buildInfoRow('Kelompok', barang.kelompokBarang ?? '-'),
          const SizedBox(height: 24),

          // Tombol aksi
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.edit, size: 20, color: Colors.white),
                  label: const Text('Edit', style: TextStyle(fontSize: 16, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo, // kontras dengan background
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    Get.back();
                    Get.to(() => AddEditPage(barang: barang));
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.delete, size: 20, color: Colors.white),
                  label: const Text('Hapus', style: TextStyle(fontSize: 16, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent, // kontras
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Konfirmasi',
                      middleText: 'Hapus barang ini?',
                      textCancel: 'Batal',
                      textConfirm: 'Hapus',
                      confirmTextColor: Colors.white,
                      onConfirm: () {
                        controller.removeBarang(barang.id!);
                        Get.back();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black87, // kontras jelas
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54, // lebih lembut tapi terbaca
              ),
            ),
          ),
        ],
      ),
    );
  }
}
