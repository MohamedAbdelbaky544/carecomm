import 'package:carecomm/core/data/utils/constants/constants.dart';
import 'package:carecomm/product/data/models/product_model/product_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

abstract class WishListLocalDataBase {
  List<ProductModel>? getAllProductInWishList();
  Future<void> addProductToWishList({
    required ProductModel newTask,
  });

  void deleteFromWhishList({required int index});
}

@LazySingleton(as: WishListLocalDataBase)
class WishListLocalDataBaseImpl implements WishListLocalDataBase {
  var hive = Hive.box<ProductModel>(HiveKeys.wishList);

  @override
  List<ProductModel>? getAllProductInWishList() {
    return hive.values.toSet().toList();
  }

  @override
  Future<void> addProductToWishList({required ProductModel newTask}) async {
    return await hive.put(newTask.id, newTask);
  }

  @override
  void deleteFromWhishList({required int index}) {
    hive.delete(index);
  }
}
