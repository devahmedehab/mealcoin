import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/models/responses/get_all_order_by_contact_response.dart';
import 'package:chefsandmeals_customer/src/repositories/local_user_info_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/order_repository.dart';

class OrderController extends GetxController {
  final OrderRepository _orderRepository = Get.put(OrderRepository());
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());

  final ordersByContactResponse = GetAllOrdersByContactResponse().obs;

  getAllOrderByContact() async {
    final contractID = await _userInfoRepository.getContactId();
    GetAllOrdersByContactResponse response =
        await _orderRepository.getAllOrderByContact(contractID, 0, 20);

    ordersByContactResponse.value = response;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllOrderByContact();
  }
}
