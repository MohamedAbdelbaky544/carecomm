import 'package:carecomm/core/data/utils/app_environment.dart';
import 'package:carecomm/core/presentation/utils/generated/configuration.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: Configuration, env: [AppEnvironment.dev])
class DevConfiguration implements Configuration {
  @override
  String get getBaseUrl => 'https://fakestoreapi.com';

  @override
  String get getApiUrl => '$getBaseUrl/';

  @override
  String get name => 'development';
}

@LazySingleton(as: Configuration, env: [AppEnvironment.staging])
class StagingConfiguration implements Configuration {
  @override
  String get getBaseUrl => 'https://fakestoreapi.com';

  @override
  String get getApiUrl => '$getBaseUrl/';

  @override
  String get name => 'staging';
}

@LazySingleton(as: Configuration, env: [AppEnvironment.prod])
class ProdConfiguration implements Configuration {
  @override
  String get getBaseUrl => 'https://fakestoreapi.com';

  @override
  String get getApiUrl => '$getBaseUrl/';

  @override
  String get name => 'production';
}
