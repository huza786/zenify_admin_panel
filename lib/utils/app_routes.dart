import 'package:zenify_admin_panel/view/dashboard/admin_vendor/admin_screen.dart';
import 'package:zenify_admin_panel/view/dashboard/admin_vendor/components/modifyProduct.dart';
import 'package:zenify_admin_panel/view/dashboard/admin_vendor/edit_product.dart';

class AppRoutes {
  static const initialRoute = '/';
  static const editScreen = 'editscreen';
  static const modifyProduct = 'modifyproduct';
}

var routes = {
  AppRoutes.initialRoute: (context) => const AdminScreen(),
  AppRoutes.editScreen: (context) => const EditProductPage(),
  AppRoutes.modifyProduct: (context) => const ModifyProducts(),
};
