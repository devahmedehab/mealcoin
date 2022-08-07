import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/models/responses/recent_view_product_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/recent_view_store_response.dart';
import 'package:chefsandmeals_customer/src/repositories/local_user_info_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/recent_viewproduct_repository.dart';

class RecentViewController extends GetxController {
  final recentViewProductResult = RecentViewedProductResponse().obs;
  final recentStoreVisitResult = RecentViewedStoreResponse().obs;
  final recentStoreList = <RecentStoreResult>[].obs;
  final recentProductList = <RecentViewProdutItem>[].obs;
  final RecentViewRepository _recentViewRepository =
      Get.put(RecentViewRepository());
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());

  Future<RecentViewedProductResponse> getRecentViewProduct() async {
    int contactid = await _userInfoRepository.getContactId();
    final result = await _recentViewRepository.getRecentViewProduct(contactid);
    recentViewProductResult.value = result;
    recentProductList.assignAll(result.result!);
    return result;
  }

  Future<RecentViewedStoreResponse> getRecentViewStore() async {
    int contactid = await _userInfoRepository.getContactId();
    final result = await _recentViewRepository.getRecentViewStore(contactid);
    recentStoreVisitResult.value = result;
    recentStoreList.assignAll(result.result!);
    return result;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getRecentViewProduct();
    await getRecentViewStore();
  }
}
