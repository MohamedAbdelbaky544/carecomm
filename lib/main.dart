import 'package:carecomm/app.dart';
import 'package:carecomm/core/data/utils/app_environment.dart';
import 'package:carecomm/core/data/utils/constants/constants.dart';
import 'package:carecomm/injection.dart';
import 'package:carecomm/product/data/models/product_model/product_model.dart';
import 'package:carecomm/product/data/models/rating_model/rating_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(RatingModelAdapter());
  await Hive.openBox<ProductModel>(HiveKeys.wishList);
  await configureInjection(AppEnvironment.dev);

  runApp(const App());
}
