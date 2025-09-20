import 'package:get/get.dart';
import '../models/barang_model.dart';
import '../models/kategori_model.dart';
import '../services/api_service.dart';
import 'package:intl/intl.dart';

class BarangController extends GetxController {
  final ApiService api = ApiService();
  var barangList = <Barang>[].obs;
  var kategoriList = <Kategori>[].obs;
  var selectedIds = <int>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchAll();
    super.onInit();
  }

  void fetchAll() async {
    try {
      isLoading(true);
      kategoriList.value = await api.getKategoris();
      barangList.value = await api.getBarangs();
    } finally {
      isLoading(false);
    }
  }

  Future addBarang(Barang b) async {
    await api.createBarang(b);
    fetchAll();
  }

  Future editBarang(int id, Barang b) async {
    await api.updateBarang(id, b);
    fetchAll();
  }

  Future removeBarang(int id) async {
    await api.deleteBarang(id);
    fetchAll();
  }

  Future bulkRemove() async {
    await api.bulkDelete(selectedIds);
    selectedIds.clear();
    fetchAll();
  }

  String formatRupiah(int amount) {
    final f = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return f.format(amount);
  }
}
