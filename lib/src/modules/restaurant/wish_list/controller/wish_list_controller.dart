import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/models/responses/get_all_wishlist_item_response.dart';
import 'package:chefsandmeals_customer/src/repositories/local_user_info_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/wishlist_repository.dart';

class WishListController extends GetxController {
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());
  final WishListRepository _wishListRepository = Get.put(WishListRepository());

  final wishList = WishListResult().obs;
  final contactId = 0.obs;
  final skipCount = 0.obs;
  final wishListLength = 0.obs;
  final isLoading = true.obs;

  getContactId() async {
    final c_Id = await _userInfoRepository.getContactId();
    contactId.value = c_Id;
  }

  getAllWishList() async {
    final response = await _wishListRepository.getAllItem(
        contactId.value, skipCount.value, 20);
    wishList.value = response.result!;
    isLoading.value = false;
  }

  Future<bool> deleteWishListItem(int id) async {
    final result = await _wishListRepository.deleteWishListItem(id);
    getAllWishList();
    return result;
  }

  @override
  void onInit() async {
    await getContactId();
    await getAllWishList();
    super.onInit();
  }
}
