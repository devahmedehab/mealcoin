import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';

import 'package:chefsandmeals_customer/src/models/requests/create_order_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/delvery_and_service_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_all_address_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_all_cart_item_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_all_delivery_type_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_all_payment_type_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_tax_rate_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/product_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/user_info_response.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/myOrders/view/myOrdersScreen.dart';
import 'package:chefsandmeals_customer/src/repositories/address_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/cart_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/local_user_info_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/user_management_repository.dart';

class CartController extends GetxController {
  final CartRepository _cartRepository = Get.put(CartRepository());
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());

  final UserManagementRepository _userManagementRepository =
      Get.put(UserManagementRepository());

  final AddressRepository _addressRepository = Get.put(AddressRepository());
  var f = new NumberFormat("###.##", "en_US");

  final cart = CartResult().obs;
  final userInfo = UserInfoResult().obs;
  final storeSetting = StoreSettingResult().obs;
  final cartList = <CartItem>[].obs;
  final fastCheckOutList = <CartItem>[].obs;
  final paymentType = <PaymentTypeResult>[].obs;
  final addressList = <AddressList>[].obs;
  final contactId = 0.obs;
  final cartLength = 0.obs;
  final squareAppId = ''.obs;
  final selectedPaymentType = 0.obs;
  final selectedDeliveryType = 0.obs;
  final selectedAddress = 0.obs;
  final zipCode = ''.obs;
  final stateId = 0.obs;
  final taxRate = TaxRateResult().obs;
  final deliveryTypeList = <DeliveryTypeResult>[].obs;
  final restaurantId = 0.obs;
  final customerName = ''.obs;
  final orderItem = <OrderItem>[].obs;
  final userId = 0.obs;
  final deliveryTypeId = 0.obs;

  final saleTax = 0.0.obs;
  final deliveryCharge = 0.0.obs;
  final totalAmount = 0.0.obs;
  final deliveryAddress = "".obs;
  final gratuityAmount = 0.0.obs;
  final gratuityPercent = 0.0.obs;
  final nonce = ''.obs;

  final fastCheckout = false.obs;

  getContactId() async {
    final c_Id = await _userInfoRepository.getContactId();
    final u_id = await _userInfoRepository.getId();
    contactId.value = c_Id;
    userId.value = u_id;
  }

  getAllCart() async {
    final result = await _cartRepository.getAllItem(contactId.value);
    if (result.success) {
      cart.value = result.result!;
      cartList.assignAll(cart.value.cartItems!);
      cartLength.value = cart.value.cartItems!.length;
      if (fastCheckout.value) {
        fastCheckOutList.forEach((element) {
          OrderItem Item = OrderItem(
              productId: element.productId,
              quantity: element.quantity,
              storeId: element.storeId,
              unitPrice: element.unitPrice);
          orderItem.add(Item);
        });
      } else {
        cartList.forEach((element) {
          OrderItem Item = OrderItem(
              productId: element.productId,
              quantity: element.quantity,
              storeId: element.storeId,
              unitPrice: element.unitPrice);
          orderItem.add(Item);
        });
      }
    }
  }

  updateCartItem(CartItem cartItem) async {
    final result =
        await _cartRepository.updateCart(cartItem.id!, cartItem.quantity!);
    if (result) {
      await getAllCart();
    }
  }

  incrementCartItem(CartItem cartItem, int index) {
    cartList.removeAt(index);
    var quantity = cartItem.quantity! + 1;
    CartItem item = CartItem(
      id: cartItem.id,
      productId: cartItem.productId,
      productName: cartItem.productName,
      productPicture: cartItem.productPicture,
      quantity: quantity,
      unitPrice: cartItem.unitPrice,
      unitTotalAmount: cartItem.unitPrice! * quantity,
    );
    cartList.insert(index, item);
  }

  decrementCartItem(CartItem cartItem, int index) {
    if (cartItem.quantity! > 1) {
      cartList.removeAt(index);
      var quantity = cartItem.quantity! - 1;
      CartItem item = CartItem(
        id: cartItem.id,
        productId: cartItem.productId,
        productName: cartItem.productName,
        productPicture: cartItem.productPicture,
        quantity: quantity,
        unitPrice: cartItem.unitPrice,
        unitTotalAmount: cartItem.unitPrice! * quantity,
      );
      cartList.insert(index, item);
    }
  }

  deleteItem(int cartId) async {
    var result;
    if (cartList.length == 1) {
      await _userInfoRepository.setRestaurantId(0);
      result = await _cartRepository.deleteCartItem(cartId);
    } else {
      result = await _cartRepository.deleteCartItem(cartId);
    }
    if (result) {
      await getAllCart();
    }
  }

  Future<bool> makePayment() async {
    var result = false;
    final response = await _cartRepository.getPaymentSdkDetails();
    if (response.result!.applicationId != null) {
      squareAppId.value = response.result!.applicationId!;
      result = true;
      _payment();
    }
    return result;
  }

  _payment() async {
    await InAppPayments.setSquareApplicationId('${squareAppId.value}');
    await InAppPayments.startCardEntryFlow(
        onCardNonceRequestSuccess: (CardDetails result) {
      try {
        InAppPayments.completeCardEntry(onCardEntryComplete: () {
          nonce.value = result.nonce;
        });
      } catch (ex) {
        InAppPayments.showCardNonceProcessingError("SomeThing Went Wrong");
      }
    }, onCardEntryCancel: () {
      selectedPaymentType.value = 0;
    });
  }

  getAllPaymentType() async {
    final response = await _cartRepository.getAllPaymentType();
    if (response.result!.isNotEmpty) {
      paymentType.assignAll(response.result!);
    }
  }

  getAllAdressReponse() async {
    int contactid = await _userInfoRepository.getContactId();
    final result = await _addressRepository.getAllAdressReponse(contactid);
    if (result.success) {
      addressList.assignAll(result.result!.items!);
    }
  }

  Future<bool> getTaxRate() async {
    bool state = false;
    var result = await _cartRepository.getTaxRate(zipCode.value, stateId.value);
    if (result.result != null) {
      taxRate.value = result.result!;
      state = true;
    }
    return state;
  }

  getRestaurantId() async {
    final r_Id = await _userInfoRepository.getRestaurantId();
    restaurantId.value = r_Id;
  }

  getDeliveryChargeAndServices() async {
    if (cart.value.cartItems!.isNotEmpty) {
      var response = await _cartRepository
          .getDeliveryChargeAndServices(cart.value.cartItems!.first.storeId!);
      if (response.success) {
        storeSetting.value = response.result!;
      }
    }
  }

  calculateSaleTax() {
    saleTax.value =
        (cart.value.subTotal! * taxRate.value.combinedRate! * 100) / 100;
  }

  calculateDeliveryCharge() {
    deliveryCharge.value = storeSetting.value.storeSetting!.deliveryCharge!;
  }

  getTotalAmount() {
    totalAmount.value = (cart.value.subTotal! +
        (cart.value.subTotal! * taxRate.value.combinedRate! * 100) / 100 +
        storeSetting.value.storeSetting!.deliveryCharge! +
        gratuityAmount.value);
  }

  getCurrentUserInfo() async {
    final response =
        await _userManagementRepository.getCurrentUserInfo(userId.value);
    userInfo.value = response.result!;
  }

  createOrder() async {
    CreateOrderRequest request = CreateOrderRequest(
        isDeliveryOrPickup: selectedDeliveryType.value == 1 ? true : false,
        fullName: customerName.value,
        orderItems: orderItem,
        zipCode: zipCode.value,
        totalAmount: totalAmount.value,
        deliveryFee: storeSetting.value.storeSetting!.deliveryCharge,
        serviceCharge: storeSetting.value.storeSetting!.serviceCharge,
        email: userInfo.value.emailAddress,
        phone: userInfo.value.phone,
        contactId: contactId.value,
        deliveryCharge: storeSetting.value.storeSetting!.deliveryCharge,
        contactAddressId: selectedAddress.value,
        paymentTypeId: selectedPaymentType.value,
        totalTaxAmount: saleTax.value,
        subTotalExcludedTax: cart.value.subTotal,
        gratuityAmount: gratuityAmount.value,
        deliveryAddress: deliveryAddress.value,
        paymentId: "${selectedPaymentType.value}",
        gratuityPercentage: gratuityPercent.value,
        currencyId: 1,
        taxRateId: taxRate.value.id,
        isAsap: true,
        isPaymentCompleted: true,
        totalDiscountAmount: 0.0,
        storeId: cartList.first.storeId,
        deliveryTypeId: deliveryTypeId.value);
    final response = await _cartRepository.createOrder(request);
    if (response.result != null &&
        selectedPaymentType.value == 1 &&
        nonce.value.isNotEmpty) {
      final pay = await _cartRepository.createOrderInSquare(nonce.value,
          totalAmount.value, int.parse(response.result!.toString()));
      if (pay) {
        await clearCart();
        Get.off(() => MyOrderScreen());
      }
    } else if (response.success) {
      await clearCart();
      Get.off(() => MyOrderScreen());
    }
  }

  checkPaymentType() {
    if (selectedPaymentType.value == 1) {
      makePayment();
    } else {}
  }

  makeFastCheckout(ProductResult product) {
    var price = product.salesPrice ?? product.regularPrice;
    CartItem item = CartItem(
        storeId: product.storeId,
        unitPrice: price,
        quantity: product.stockQuantity,
        productId: product.storeId,
        productName: product.productName,
        productPicture: product.picture,
        unitTotalAmount: product.stockQuantity! * price!);
    fastCheckOutList.add(item);
  }

  getAllDeliveryType({int? storeId}) async {
    final response = await _cartRepository.getAllDeliveryType(storeId!);
    if (response.success) {
      deliveryTypeList.assignAll(response.result!);
      if (deliveryTypeList.length == 1) {
        deliveryTypeId.value = deliveryTypeList.first.id!;
      }
    }
  }

  clearCart() async {
    final response = await _cartRepository.clearCart(contactId.value);
    if (response) {
      cartList.assignAll([]);
    }
  }

  @override
  void onInit() async {
    await getContactId();
    await getCurrentUserInfo();
    await getRestaurantId();
    await getAllCart();
    await getAllAdressReponse();
    await getAllPaymentType();
    await getDeliveryChargeAndServices();
    super.onInit();
  }
}
