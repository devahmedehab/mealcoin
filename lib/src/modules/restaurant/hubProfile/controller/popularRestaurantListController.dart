import 'package:get/state_manager.dart';

import 'package:chefsandmeals_customer/src/models/responses/popularRestaurantListModel.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/service/popularRestaurantService.dart';

class HubProfileController extends GetxController {
  PopularRestaurantService popularRestaurantService =
      PopularRestaurantService();
  final _popularRestaurantListModel = PopularRestaurantListModel().obs;

  PopularRestaurantListModel get popularRestaurantList =>
      _popularRestaurantListModel.value;

  @override
  void onInit() {
    ever(_popularRestaurantListModel, (_) => _getShortPopularRestaurantList());
    super.onInit();
  }

  Future<void> _getShortPopularRestaurantList() async {
    final popularRestaurantData =
        await popularRestaurantService.getPopularRestaurantShortList();
    if (popularRestaurantData.success == true) {
      _popularRestaurantListModel.value = popularRestaurantData;
    }
  }
}
