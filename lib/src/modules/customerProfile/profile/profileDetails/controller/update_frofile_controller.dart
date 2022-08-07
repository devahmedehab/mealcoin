import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/models/requests/edit_user_info_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_all_country_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/user_info_for_edit.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/profileDetails/controller/my_profile_controller.dart';
import 'package:chefsandmeals_customer/src/repositories/local_user_info_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/user_management_repository.dart';

class UpdateProfileController extends GetxController {
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());
  final UserManagementRepository _userManagementRepository =
      Get.put(UserManagementRepository());

  final userToken = ''.obs;
  final userId = 0.obs;
  final contactId = 0.obs;
  final user = EditUserInfo().obs;
  final countries = <CountryResult>[].obs;
  final states = <CountryResult>[].obs;
  final initialDialCode = "+1".obs;
  final initialIsoCode = "US".obs;

  final selectedCountry = CountryResult().obs;
  final selectedState = CountryResult().obs;
  final firstName = ''.obs;
  final lastName = ''.obs;
  final email = ''.obs;
  final phone = ''.obs;
  final address = ''.obs;
  final zipCode = ''.obs;
  final city = ''.obs;
  final dateOfBirth = ''.obs;
  final picture = ''.obs;
  final countryId = 0.obs;
  final stateId = 0.obs;

  getToken() async {
    final token = await _userInfoRepository.getToken();
    if (token != null) {
      userToken.value = token;
    }
  }

  getUserId() async {
    final userid = await _userInfoRepository.getId();
    userId.value = userid;
  }

  getContactId() async {
    final c_Id = await _userInfoRepository.getContactId();
    contactId.value = c_Id;
  }

  getCurrentUserInfo() async {
    final result =
        await _userManagementRepository.getUserInfoForEdit(userId.value);
    if (result.success) {
      user.value = result.result!;
    }
  }

  getAllCountry() async {
    final result = await _userManagementRepository.getAllCountry();
    print(result);
    if (result.success) {
      countries.assignAll(result.result!);
    }
  }

  getAllState() async {
    final result =
        await _userManagementRepository.getAllState(selectedCountry.value.id!);
    if (result.success) {
      states.assignAll(result.result!);
    }
  }

  getArguments() {
    user.value = Get.arguments['user'];
  }

  editUserInfo() async {
    EditUserInfoRequest request = EditUserInfoRequest(
        address: address.value,
        picture: picture.value,
        phone: phone.value,
        city: city.value,
        contactId: contactId.value,
        dateOfBirth: dateOfBirth.value,
        email: email.value,
        firstName: firstName.value,
        lastName: lastName.value,
        stateId: selectedState.value.id,
        countryId: selectedCountry.value.id,
        userId: userId.value,
        zipCode: zipCode.value);
    final result = await _userManagementRepository.editProfile(request);
    if (result) {
      final profileController = Get.put(MyProfileController());
      profileController.getCurrentUserInfo();
      Get.back();
      Get.back();
    }
  }

  @override
  void onInit() async {
    getArguments();
    await getToken();
    await getUserId();
    await getContactId();
    await getAllCountry();
    super.onInit();
  }
}
