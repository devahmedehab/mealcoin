import 'package:hive/hive.dart';

import 'package:chefsandmeals_customer/src/models/responses/product_category_response.dart';

abstract class ISnackPassRepository {
  Future<ProductCategoryResult> getSnackPass();

  Future<void> setSnackPass(ProductCategoryResult snackPass);

  Future<void> clearSnackPass();
}

class SnackPassRepository implements ISnackPassRepository {
  final String _boxKey = 'snackPassBox';
  final String _snackPassKey = 'snackPass';

  @override
  Future<void> clearSnackPass() async {
    final snackPassBox = await Hive.openBox(_boxKey);
    await snackPassBox.clear();
  }

  @override
  Future<ProductCategoryResult> getSnackPass() async {
    final snackPassBox = await Hive.openBox(_boxKey);
    final snackPassStr = await snackPassBox.get(_snackPassKey);
    return ProductCategoryResult.fromJson(snackPassStr);
  }

  @override
  Future<void> setSnackPass(ProductCategoryResult snackPass) async {
    final snackPassBox = await Hive.openBox(_boxKey);
    await snackPassBox.put(_snackPassKey, snackPass.toJson());
  }
}
