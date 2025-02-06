import 'translations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class TranslationsEn extends Translations {
  TranslationsEn([String locale = 'en']) : super(locale);

  @override
  String get products => 'Products';

  @override
  String get wishList => 'wishList';

  @override
  String get home => 'Home';

  @override
  String get retry => 'Retry';

  @override
  String get errorMessage => 'OOPS! Something went wrong';

  @override
  String get noInternetConnectionMessage => 'No internet connection';

  @override
  String get accessDeniedMessage => 'Access Denied, You have insufficient privileges';

  @override
  String get noInternetConnection => 'No internet connection';

  @override
  String get connectionTimeOut => 'Connection Time Out!';

  @override
  String get price => 'Price';

  @override
  String get unauthenticatedMessage => 'Session is Expired!';

  @override
  String get productDetails => 'Product Details';

  @override
  String get category => 'Category';
}
