import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/sharedPreference.dart';
import 'package:chefsandmeals_customer/src/common/strings.dart';
import 'package:chefsandmeals_customer/src/models/requests/populor_store_request.dart';
import 'package:chefsandmeals_customer/src/models/requests/update_product_recommendation_score_request.dart';
import 'package:chefsandmeals_customer/src/models/requests/update_store_recommendation_score_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/populor_store_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/product_category_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/product_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/user_email_and_phone_verification_status.dart';
import 'package:chefsandmeals_customer/src/repositories/cart_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/category_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/local_user_info_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/product_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/recommendation_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/snack_pass_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/store_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/user_management_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/wishlist_repository.dart';

class LandingPageController extends GetxController {
  final _storeRepository = Get.put(StoreRepository());
  final _categoryRepository = Get.put(ProductCategoryRepository());
  final _productRepository = Get.put(ProductRepository());
  final CartRepository _cartRepository = Get.put(CartRepository());
  final WishListRepository _wishListRepository = Get.put(WishListRepository());
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());
  final UserManagementRepository _userManagementRepository =
      Get.put(UserManagementRepository());
  final RecommendationRepository _recommendationRepository =
      Get.put(RecommendationRepository());

  final ISnackPassRepository _snackPassRepository =
      Get.put(SnackPassRepository());

  final populorStore = <StoreResult>[].obs;
  final topCategory = <ProductCategoryResult>[].obs;
  final trendingProduct = <ProductResult>[].obs;
  SharedPref pref = SharedPref();
  final hubid = 0.obs;
  final contactId = 0.obs;
  final userId = 0.obs;
  final restaurantId = 0.obs;
  final storeLoading = true.obs;
  final categoryLoading = true.obs;
  final productLoading = true.obs;
  final emailAndPhoneStatus = VerificationResult().obs;
  final verifyCode = ''.obs;

  getPopulorRestorent() async {
    final value = await pref.getUserAppData(SharedPrefStrings.hubId);
    hubid.value = int.parse(value!);
    PopularStoreResponse result = await _storeRepository
        .getPopularStore(PopulorStoreRequest(hubid: hubid.value));
    populorStore.assignAll(result.result!);
    Future.delayed(Duration(seconds: 1), () {
      storeLoading.value = false;
    });
  }

  getTopProductCategory() async {
    final value = await pref.getUserAppData(SharedPrefStrings.hubId);
    hubid.value = int.parse(value!);
    ProductCategoryResponse result =
        await _categoryRepository.getTopProductCategory(hubid.value);
    topCategory.assignAll(result.result!);
    final snackPass = topCategory
        .firstWhereOrNull((element) => element.name!.contains("SnackPass"));

    if (snackPass != null) {
      await _snackPassRepository.setSnackPass(snackPass);
    }
    Future.delayed(Duration(seconds: 1), () {
      categoryLoading.value = false;
    });
  }

  getTrendingProduct() async {
    final id = await pref.getUserAppData(SharedPrefStrings.hubId);
    hubid.value = int.parse(id!);
    ProductResponse result =
        await _productRepository.getTrendingProduct(hubid.value);
    trendingProduct.assignAll(result.result!);
    Future.delayed(Duration(seconds: 1), () {
      productLoading.value = false;
    });
  }

  Future<bool> addProductToCart(int productId, int storeId) async {
    var success = false;
    final result = await _cartRepository.addProductToCart(
        productId, storeId, contactId.value, 1);
    if (result) {
      success = true;
    }
    return success;
  }

  Future<bool> addProductToWishList(int productId) async {
    final result = await _wishListRepository.addProductToWishList(
        productId, contactId.value);
    return result.result!;
  }

  getContactId() async {
    final c_Id = await _userInfoRepository.getContactId();
    contactId.value = c_Id;
    final u_id = await _userInfoRepository.getId();
    userId.value = u_id;
  }

  getRestaurantId() async {
    final r_Id = await _userInfoRepository.getRestaurantId();
    restaurantId.value = r_Id;
  }

  Future<bool> setRestaurantId(int id) async {
    return await _userInfoRepository.setRestaurantId(id);
  }

  getEmailAndPhoneStatus() async {
    if (userId.value > 0) {
      final response = await _userManagementRepository
          .userEmailAndPhoneVerificationStatus(userId.value);
      emailAndPhoneStatus.value = response.result!;
    }
  }

  getVerificationPrompt() {
    if (emailAndPhoneStatus.value.phoneNumber != null &&
        !emailAndPhoneStatus.value.isEmailConfirmed!) {
      if (!emailAndPhoneStatus.value.isPhoneNumberConfirmed! ||
          !emailAndPhoneStatus.value.isPhoneNumberConfirmed!) {
        Get.defaultDialog(
            radius: 4,
            titlePadding: EdgeInsets.all(10),
            title: "Confirm Your Mobile & Email",
            content: Container(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    emailAndPhoneStatus.value.phoneNumber != null &&
                            !emailAndPhoneStatus.value.isPhoneNumberConfirmed!
                        ? Padding(
                            padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                            child: Text("Phone number"),
                          )
                        : Container(),
                    emailAndPhoneStatus.value.phoneNumber != null &&
                            !emailAndPhoneStatus.value.isPhoneNumberConfirmed!
                        ? Row(
                            children: [
                              Container(
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: Colors.grey)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                        "${emailAndPhoneStatus.value.phoneNumber}"),
                                  ),
                                ),
                              ),
                              emailAndPhoneStatus.value.isPhoneNumberConfirmed!
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Center(
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: InkWell(
                                        onTap: () async {
                                          final response =
                                              await _userManagementRepository
                                                  .sendVerificationOTPToPhone(
                                                      emailAndPhoneStatus
                                                          .value.phoneNumber!
                                                          .toString());
                                          Get.back();
                                          if (response) {
                                            verifyOTP(
                                                "phone",
                                                emailAndPhoneStatus
                                                    .value.phoneNumber!
                                                    .toString());
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Can not send OTP");
                                          }
                                        },
                                        child: Container(
                                          width: 80,
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                "Verify",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                            ],
                          )
                        : Container(),
                    emailAndPhoneStatus.value.email != null &&
                            !emailAndPhoneStatus.value.isEmailConfirmed!
                        ? Padding(
                            padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                            child: Text("Email Address"),
                          )
                        : Container(),
                    emailAndPhoneStatus.value.email != null &&
                            !emailAndPhoneStatus.value.isEmailConfirmed!
                        ? Row(
                            children: [
                              Container(
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: Colors.grey)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                        "${emailAndPhoneStatus.value.email}"),
                                  ),
                                ),
                              ),
                              emailAndPhoneStatus.value.isEmailConfirmed!
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Center(
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: InkWell(
                                        onTap: () async {
                                          final response =
                                              await _userManagementRepository
                                                  .sendVerificationOTPToEmail(
                                                      emailAndPhoneStatus
                                                          .value.email!
                                                          .toString());
                                          Get.back();
                                          if (response) {
                                            verifyOTP(
                                                "email",
                                                emailAndPhoneStatus.value.email!
                                                    .toString());
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Can not send OTP");
                                          }
                                        },
                                        child: Container(
                                          width: 80,
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                "Verify",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("CLOSE")),
            ]);
      }
    }
  }

  addRecentStoreView(int storeId) async {
    UpdateStoreRecommendationScoreRequest request =
        UpdateStoreRecommendationScoreRequest(
            storeId: storeId, contactId: contactId.value, isClicked: true);
    await _recommendationRepository.updateStoreRecommendationScore(request);
  }

  addRecentProductView(int productId) async {
    UpdateProductRecommendationScoreRequest request =
        UpdateProductRecommendationScoreRequest(
            productId: productId, contactId: contactId.value, isClicked: true);
    await _recommendationRepository.updateProductRecommendationScore(request);
  }

  @override
  void onInit() async {
    await getContactId();
    await getPopulorRestorent();
    await getTopProductCategory();
    await getEmailAndPhoneStatus();
    await getTrendingProduct();
    getVerificationPrompt();
    super.onInit();
  }

  verifyOTP(String type, String phoneOrEmail) {
    Get.defaultDialog(
        barrierDismissible: false,
        title: "INPUT OTP",
        content: Container(
          height: 45,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextFormField(
            onChanged: (value) {
              verifyCode.value = value;
            },
          ),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                if (type == "phone") {
                  final response =
                      await _userManagementRepository.verifyOTPToPhone(
                          phone: phoneOrEmail, code: verifyCode.value);
                  Get.back();
                  if (response) {
                    Fluttertoast.showToast(
                        msg: "Phone verification successful");
                  } else {
                    Fluttertoast.showToast(msg: "Can not verify");
                  }
                } else {
                  final response =
                      await _userManagementRepository.verifyOTPToEmail(
                          email: phoneOrEmail,
                          code: verifyCode.value,
                          userId: userId.value);
                  Get.back();
                  if (response) {
                    Fluttertoast.showToast(
                        msg: "Email verification successful");
                  } else {
                    Fluttertoast.showToast(msg: "Can not verify");
                  }
                }
              },
              child: Text("VERIFY")),
        ]);
  }
}
