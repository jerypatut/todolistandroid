import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/barang_controller.dart';
import '../models/barang_model.dart';

class AddEditPage extends StatefulWidget {
  final Barang? barang;
  const AddEditPage({super.key, this.barang});

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final BarangController controller = Get.find();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController stokController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  int? kategoriId;
  String? kelompokBarang;

  final List<String> kelompokList = ['A', 'B', 'C'];

  @override
  void initState() {
    super.initState();
    if (widget.barang != null) {
      namaController.text = widget.barang!.namaBarang;
      stokController.text = widget.barang!.stok.toString();
      hargaController.text = widget.barang!.harga.toString();

      if (controller.kategoriList.any((k) => k.id == widget.barang!.kategoriId)) {
        kategoriId = widget.barang!.kategoriId;
      }
      if (kelompokList.contains(widget.barang!.kelompokBarang)) {
        kelompokBarang = widget.barang!.kelompokBarang;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    title: Text(
  widget.barang == null ? 'Tambah Barang' : 'Edit Barang',
  style: const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
  ),
),
centerTitle: true,
backgroundColor: Colors.indigo,
elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: namaController,
                label: 'Nama Barang',
                validator: (val) => val == null || val.isEmpty ? 'Nama wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              _buildDropdown<int>(
                value: kategoriId,
                hint: 'Pilih Kategori',
                items: controller.kategoriList
                    .map((k) => DropdownMenuItem<int>(
                          value: k.id,
                          child: Text(k.namaKategori, style: const TextStyle(color: Colors.black87)),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => kategoriId = val),
                validator: (val) => val == null ? 'Kategori wajib dipilih' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: stokController,
                label: 'Stok',
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Stok wajib diisi';
                  if (int.tryParse(val) == null) return 'Stok harus angka';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildDropdown<String>(
                value: kelompokBarang,
                hint: 'Kelompok Barang',
                items: kelompokList
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e, style: const TextStyle(color: Colors.black87)),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => kelompokBarang = val),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: hargaController,
                label: 'Harga',
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Harga wajib diisi';
                  if (int.tryParse(val) == null) return 'Harga harus angka';
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white, // teks tombol putih
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                child: Text(
                  widget.barang == null ? 'Tambah Barang' : 'Update Barang',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newBarang = Barang(
                      id: widget.barang?.id,
                      namaBarang: namaController.text,
                      kategoriId: kategoriId!,
                      stok: int.parse(stokController.text),
                      kelompokBarang: kelompokBarang,
                      harga: int.parse(hargaController.text),
                    );
                    if (widget.barang == null) {
                      controller.addBarang(newBarang);
                    } else {
                      controller.editBarang(widget.barang!.id!, newBarang);
                    }
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) =>
      TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.black87, fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.indigo),
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.indigo[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: validator,
      );

  Widget _buildDropdown<T>({
    required T? value,
    required String hint,
    required List<DropdownMenuItem<T>> items,
    required Function(T?) onChanged,
    String? Function(T?)? validator,
  }) =>
      DropdownButtonFormField<T>(
        initialValue: value,
        hint: Text(hint, style: const TextStyle(color: Colors.grey)),
        style: const TextStyle(color: Colors.black87, fontSize: 16),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.indigo[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        items: items,
        onChanged: (val) => onChanged(val),
        validator: validator,
      );
}
