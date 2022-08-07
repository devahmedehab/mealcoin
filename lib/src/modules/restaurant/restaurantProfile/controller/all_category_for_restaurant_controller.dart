import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/base_controller.dart';
import 'package:chefsandmeals_customer/src/common/sharedPreference.dart';
import 'package:chefsandmeals_customer/src/models/requests/all_categories_by_store_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/populor_store_response.dart';
import 'package:chefsandmeals_customer/src/repositories/single_store_repository.dart';

import '../../../../common/strings.dart';
import '../../../../models/responses/product_category_response.dart';

class AllCategoryForRestaurantController extends BaseController {
  final SharedPref sharedPref = Get.put(SharedPref());
  final SingleStoreRepository _singleStoreRepository =
      Get.put(SingleStoreRepository());

  final hubId = 0.obs;
  final StoreResult store;

  final categories = <ProductCategoryResult>[].obs;

  final skipCount = 0.obs;

  AllCategoryForRestaurantController(this.store);

  @override
  void onInit() async {
    super.onInit();
    hubId.value = int.parse(
        await sharedPref.getUserAppData(SharedPrefStrings.hubId) ?? "0");
    await getCategories();
  }

  getCategories() async {
    // try {
    setLoading(true);
    final response = await _singleStoreRepository.getAllCategoriesByStore(
        AllCategoriesByStoreRequest(
            storeId: store.id!, maxCount: 20, skipCount: skipCount.value));
    categories.assignAll(response);
    // } catch (e) {
    //   print(e);
    // } finally {
    setLoading(false);
    // }
  }
}
