import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:chefsandmeals_customer/src/models/requests/add_single_contrct_request.dart';
import 'package:chefsandmeals_customer/src/models/requests/all_contract_store_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/add_contact_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_all_sync_contact_response.dart';
import 'package:chefsandmeals_customer/src/repositories/contact_repository.dart';
import 'package:chefsandmeals_customer/src/repositories/local_user_info_repository.dart';

class ReferalController extends GetxController {
  final iOSLocalizedLabels = false;
  final initialDialCode = "+1".obs;
  final initialIsoCode = "US".obs;
  final firstName = "".obs;
  final lastName = "".obs;
  final email = "".obs;
  final phone = "".obs;

  final ContactRepository _contactRepository = Get.put(ContactRepository());
  final LocalUserInfoRepository _userInfoRepository =
      Get.put(LocalUserInfoRepository());
  final contractList = <SingleContact>[].obs;
  final syncontractList = <SnycContactResult>[].obs;

  Future<bool> sendContractList() async {
    final contractID = await _userInfoRepository.getContactId();
    final status = await _contactRepository.sendContractList(
        ContractRequest(syncedByContactId: contractID, contacts: contractList));
    if (status) {
      await getAllContract();
    }
    print("SCR : $status");
    return status;
  }

  getAllContract() async {
    final contractID = await _userInfoRepository.getContactId();
    final contact = await _contactRepository.getAllSyncContact(contractID);
    syncontractList.assignAll(contact.result!);
  }

  Future<bool> referAll() async {
    final contractID = await _userInfoRepository.getContactId();
    final result = await _contactRepository.refferalAllContract(contractID);
    await getAllContract();
    return result;
  }

  referSingleContract(int referredByContactId) async {
    final contractID = await _userInfoRepository.getContactId();
    final result = await _contactRepository.referSingleContract(
        referredByContactId, contractID);
    print("Rffer${result}");
    await getAllContract();
  }

  Future<AddContactResponse> addNewContract() async {
    final contractID = await _userInfoRepository.getContactId();
    final result = await _contactRepository.addNewContract(
        SingleContractRequest(
            contactId: contractID,
            firstName: firstName.value,
            lastName: lastName.value,
            mobile: phone.value,
            email: email.value));
    return result;
  }

  Future<bool> deleteContact(int id) async {
    final result = await _contactRepository.deleteContract(id);
    await getAllContract();
    return result;
  }

  refreshContacts() async {
    var contacts = (await ContactsService.getContacts(
        withThumbnails: false, iOSLocalizedLabels: iOSLocalizedLabels));
    for (final contact in contacts) {
      String? email;
      String? phone;

      for (var p in contact.phones!) {
        phone = p.value;
      }

      for (var e in contact.emails!) {
        email = e.value;
      }

      print("Mobile Number ${phone}");

      final s_contact = SingleContact(
          firstName: contact.displayName,
          lastName: contact.givenName,
          email: email,
          mobile: phone);
      contractList.add(s_contact);
      ContactsService.getAvatar(contact).then((avatar) {
        if (avatar == null) return; // Don't redraw if no change.
        // setState(() => contact.avatar = avatar);
      });
    }
    await sendContractList();
  }

  askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      refreshContacts();
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      Get.snackbar("Permission", "Access to contact data denied");
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      Get.snackbar("Permission", "Contact data not available on device");
    }
  }

  @override
  void onInit() async {
    await askPermissions();
    super.onInit();
  }
}
