import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/sharedPreference.dart';
import 'package:chefsandmeals_customer/src/common/strings.dart';
import 'package:chefsandmeals_customer/src/models/requests/populor_store_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/populor_store_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/product_category_response.dart';
import 'package:chefsandmeals_customer/src/repositories/category_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/store_repository.dart';

import '../../../../repositories/local_user_info_repository.dart';
import '../../../../repositories/recommendation_repository.dart';

class CategoryPageController extends GetxController {
  final _categoryRepository = Get.put(ProductCategoryRepository());

  final category = <ProductCategoryResult>[].obs;
  SharedPref pref = SharedPref();
  final hubid = 0.obs;
  final skip = 0.obs;
  final isLoading = true.obs;

  getTopProductCategory() async {
    pref.getUserAppData(SharedPrefStrings.hubId).then((value) async {
      hubid.value = int.parse(value!);
      ProductCategoryResponse result = await _categoryRepository
          .getAllProductCategory(hubid.value, skip.value);
      category.addAll(result.result!);
      Future.delayed(Duration(seconds: 2), () {
        isLoading.value = false;
      });
    });
  }

  @override
  void onInit() async {
    super.onInit();
    await getTopProductCategory();
  }
}
