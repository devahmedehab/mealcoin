import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/models/requests/create_new_address_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_all_address_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_all_country_response.dart';
import 'package:chefsandmeals_customer/src/repositories/address_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/local_user_info_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/user_management_repository.dart';

class AddressController extends GetxController {
  final AddressRepository _addressRepository = Get.put(AddressRepository());
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());
  final UserManagementRepository _userManagementRepository =
      Get.put(UserManagementRepository());

  final id = 0.obs;
  final title = "".obs;
  final fullAddress = "".obs;
  final address = "".obs;
  final zipCode = "".obs;
  final latitude = 0.obs;
  final longitude = 0.obs;
  final isActive = false.obs;
  final city = "".obs;
  final noteForDelivery = "".obs;
  final stateId = 0.obs;
  final countryId = 0.obs;
  final initialDialCode = "+1".obs;
  final initialIsoCode = "US".obs;

  final addressList = <AddressList>[].obs;
  final countries = <CountryResult>[].obs;
  final states = <CountryResult>[].obs;

  final selectedCountry = CountryResult().obs;
  final selectedState = CountryResult().obs;
  final editMode = false.obs;
  final dropDownValue = "".obs;
  final stateValue = "".obs;

  Future<bool> createNewAddress() async {
    int contactid = await _userInfoRepository.getContactId();
    final result = await _addressRepository.createNewAddress(
        CreateNewAddressRequest(
            title: title.value,
            fullAddress: fullAddress.value,
            address: address.value,
            zipCode: zipCode.value,
            latitude: latitude.value,
            longitude: longitude.value,
            isActive: isActive.value,
            city: city.value,
            noteForDelivery: noteForDelivery.value,
            stateId: stateId.value,
            countryId: countryId.value,
            contactId: contactid,
            id: editMode.value == true ? id.value : null));

    await getAllAdressReponse();
    return result;
  }

  getAllAdressReponse() async {
    int contactid = await _userInfoRepository.getContactId();
    final result = await _addressRepository.getAllAdressReponse(contactid);
    if (result.success) {
      addressList.assignAll(result.result!.items!);
    }
  }

  Future<bool> deleteAddress(int conactID) async {
    final result = await _addressRepository.deleteAddress(conactID);
    getAllAdressReponse();
    return result;
  }

  getAllCountry() async {
    print("calling");
    final result = await _userManagementRepository.getAllCountry();
    print(result);
    if (result.success) {
      countries.assignAll(result.result!);
    }
  }

  getAllState() async {
    final result =
        await _userManagementRepository.getAllState(selectedCountry.value.id!);
    print("countiry ID${selectedCountry.value.id}");
    if (result.success) {
      states.assignAll(result.result!);
    }
  }

  @override
  void onInit() {
    getAllCountry();
    getAllAdressReponse();

    super.onInit();
  }
}
