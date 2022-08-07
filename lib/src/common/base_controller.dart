import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final isLoading = false.obs;

  void setLoading(bool loading) {
    isLoading.value = loading;
  }
}
