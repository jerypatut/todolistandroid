import 'package:get/get.dart';

import '../models/barang_model.dart';
import '../models/kategori_model.dart';

class ApiService extends GetConnect {
  @override
  final String baseUrl = 'http://localhost:3004'; // ✅ web pakai localhost

  @override
  void onInit() {
    httpClient.baseUrl = baseUrl;
  }

  Future<List<Barang>> getBarangs() async {
    final resp = await get('/barang');
    if (resp.status.hasError) {
      throw resp.statusText ?? 'Unknown error';
    }
    print('Response barang: ${resp.body}'); // 🔎 debug
    return (resp.body as List).map((e) => Barang.fromJson(e)).toList();
  }

  Future<List<Kategori>> getKategoris() async {
    final resp = await get('/kategori');
    if (resp.status.hasError) {
      throw resp.statusText ?? 'Unknown error';
    }
    print('Response kategori: ${resp.body}'); // 🔎 debug
    return (resp.body as List).map((e) => Kategori.fromJson(e)).toList();
  }

  Future createBarang(Barang b) => post('/barang', b.toJson());
  Future updateBarang(int id, Barang b) => put('/barang/$id', b.toJson());
  Future deleteBarang(int id) => delete('/barang/$id');
  Future bulkDelete(List<int> ids) => post('/barang/bulk-delete', {'ids': ids});
}
