import 'package:get/get.dart';
import '../pages/list_page.dart';
import '../pages/add_edit_page.dart';

class AppRoutes {
  static const list = '/';
  static const addEdit = '/add_edit';
}

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.list,
      page: () => ListPage(),
    ),
  GetPage(
  name: AppRoutes.addEdit,
  page: () => AddEditPage(barang: Get.arguments),
)
  ];
}
