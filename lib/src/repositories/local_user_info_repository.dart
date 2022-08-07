import 'package:hive/hive.dart';

import 'package:chefsandmeals_customer/src/models/responses/index.dart';

abstract class ILocalUserinfoRepository {
  Future<LoginWithEmailResult> insertUser(LoginWithEmailResult loginResult);
  Future<LoginWithEmailResult> getUser();
  Future<bool> clearUserInfo();
  Future<bool> setToken(String token);
  Future<String?> getToken();
  Future<bool> setId(int id);
  Future<int> getId();
  Future<bool> setRout(int rout);
  Future<int> getRout();
  Future<bool> setContactId(int rout);
  Future<int> getContactId();
  Future<bool> setRestaurantId(int id);
  Future<int> getRestaurantId();
}

class LocalUserInfoRepository implements ILocalUserinfoRepository {
  final String boxKey = 'userBox';
  final String userKey = 'cartKey';
  final String tokenKey = 'tokenKey';
  final String idKey = 'idKey';
  final String routKey = 'routKey';
  final String contactKey = 'contactKey';
  final String restaurantKey = 'restaurantKey';

  @override
  Future<bool> clearUserInfo() async {
    bool result = false;
    final userBox = await Hive.openBox(boxKey);
    userBox.clear().then((value) {
      result = true;
    });
    return result;
  }

  @override
  Future<LoginWithEmailResult> getUser() async {
    final userBox = await Hive.openBox(boxKey);
    final cartStr = await userBox.get(userKey);
    return LoginWithEmailResult.fromJson(cartStr);
  }

  @override
  Future<LoginWithEmailResult> insertUser(
      LoginWithEmailResult loginResult) async {
    final userBox = await Hive.openBox(boxKey);
    userBox.put(userKey, loginResult.toJson());
    setToken(loginResult.accessToken!);
    final user = await getUser();
    return await user;
  }

  @override
  Future<bool> setToken(String token) async {
    bool result = false;
    final userBox = await Hive.openBox(boxKey);
    userBox.put(tokenKey, token).then((value) {
      result = true;
    });
    return result;
  }

  @override
  Future<String?> getToken() async {
    final userBox = await Hive.openBox(boxKey);
    final token = await userBox.get(tokenKey);
    return token;
  }

  @override
  Future<int> getId() async {
    final userBox = await Hive.openBox(boxKey);
    final id = await userBox.get(idKey);
    return id ?? 0;
  }

  @override
  Future<bool> setId(int id) async {
    bool result = false;
    final userBox = await Hive.openBox(boxKey);
    userBox.put(idKey, id).then((value) {
      result = true;
    });
    return result;
  }

  @override
  Future<int> getRout() async {
    final userBox = await Hive.openBox(boxKey);
    final id = await userBox.get(routKey);
    return id == null ? 0 : id;
  }

  @override
  Future<bool> setRout(int rout) async {
    bool result = false;
    final userBox = await Hive.openBox(boxKey);
    userBox.put(routKey, rout).then((value) {
      result = true;
    });
    return result;
  }

  @override
  Future<int> getContactId() async {
    final userBox = await Hive.openBox(boxKey);
    final id = await userBox.get(contactKey);
    return id == null ? 0 : id;
  }

  @override
  Future<bool> setContactId(int rout) async {
    bool result = false;
    final userBox = await Hive.openBox(boxKey);
    userBox.put(contactKey, rout).then((value) {
      result = true;
    });
    return result;
  }

  @override
  Future<int> getRestaurantId() async {
    final userBox = await Hive.openBox(boxKey);
    final id = await userBox.get(restaurantKey);
    return id == null ? 0 : id;
  }

  @override
  Future<bool> setRestaurantId(int id) async {
    bool result = false;
    final userBox = await Hive.openBox(boxKey);
    userBox.put(restaurantKey, id).then((value) {
      result = true;
    });
    return result;
  }
}
