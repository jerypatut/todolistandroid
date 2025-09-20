import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/barang_controller.dart';
import 'add_edit_page.dart';
import 'detail_bottomsheet.dart';

class ListPage extends StatelessWidget {
  // Pastikan controller didaftarkan
  final BarangController controller = Get.put(BarangController());

  ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Barang',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 2,
        actions: [
          Obx(() => IconButton(
                icon: const Icon(Icons.delete, color: Colors.white),
                onPressed: controller.selectedIds.isNotEmpty
                    ? () {
                        Get.defaultDialog(
                          title: 'Hapus Bulk',
                          middleText: 'Apakah Anda yakin ingin menghapus barang terpilih?',
                          textCancel: 'Batal',
                          textConfirm: 'Hapus',
                          confirmTextColor: Colors.white,
                          onConfirm: () {
                            controller.bulkRemove();
                            Get.back();
                          },
                        );
                      }
                    : null,
              )),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.barangList.isEmpty) {
          return const Center(
            child: Text(
              'Belum ada data barang',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.barangList.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final barang = controller.barangList[index];
            final isSelected = controller.selectedIds.contains(barang.id);

            return Card(
              elevation: 3,
              shadowColor: Colors.indigo.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                leading: Checkbox(
                  value: isSelected,
                  activeColor: Colors.indigo,
                  onChanged: (val) {
                    if (val == true) {
                      controller.selectedIds.add(barang.id!);
                    } else {
                      controller.selectedIds.remove(barang.id!);
                    }
                  },
                ),
                title: Text(
                  barang.namaBarang,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.indigo[900],
                  ),
                ),
                subtitle: Text(
                  'Stok: ${barang.stok}  |  Harga: ${controller.formatRupiah(barang.harga)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[500]),
                onTap: () => Get.bottomSheet(
                  DetailBottomSheet(barang: barang),
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, size: 28, color: Colors.white),
        onPressed: () => Get.to(() => const AddEditPage()),
      ),
      backgroundColor: Colors.grey[50], // background lembut agar putih nyaman di mata
    );
  }
}
