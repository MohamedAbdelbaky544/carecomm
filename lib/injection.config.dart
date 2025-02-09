// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:carecomm/core/data/utils/configuration.dart' as _i318;
import 'package:carecomm/core/presentation/utils/generated/configuration.dart'
    as _i815;
import 'package:carecomm/injectable_module.dart' as _i712;
import 'package:carecomm/product/data/data_sources/local/wish_list_local_data_base.dart'
    as _i12;
import 'package:carecomm/product/data/data_sources/remote/product_remote_data_source.dart'
    as _i509;
import 'package:carecomm/product/data/repositories/product_repository_impl.dart'
    as _i255;
import 'package:carecomm/product/domain/repositories/product_repository.dart'
    as _i856;
import 'package:carecomm/product/domain/use_cases/add_product_to_wishlist_use_case.dart'
    as _i836;
import 'package:carecomm/product/domain/use_cases/delete_product_from_wish_list_use_case.dart'
    as _i823;
import 'package:carecomm/product/domain/use_cases/get_all_product_in_wish_list_use_case.dart'
    as _i807;
import 'package:carecomm/product/domain/use_cases/get_categories_use_case.dart'
    as _i391;
import 'package:carecomm/product/domain/use_cases/get_product_by_id_use_case.dart'
    as _i895;
import 'package:carecomm/product/domain/use_cases/get_product_use_case.dart'
    as _i776;
import 'package:carecomm/product/presentations/cubits/add_product_to_wishlist_cubit.dart'
    as _i819;
import 'package:carecomm/product/presentations/cubits/app_cubit.dart' as _i265;
import 'package:carecomm/product/presentations/cubits/delete_product_from_wish_list_cubit.dart'
    as _i419;
import 'package:carecomm/product/presentations/cubits/get_all_product_in_wish_list_cubit.dart'
    as _i321;
import 'package:carecomm/product/presentations/cubits/get_categories_cubit.dart'
    as _i382;
import 'package:carecomm/product/presentations/cubits/get_product_by_id_cubit.dart'
    as _i897;
import 'package:carecomm/product/presentations/cubits/get_product_cubit.dart'
    as _i472;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

const String _dev = 'dev';
const String _staging = 'staging';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModule = _$InjectableModule();
    gh.lazySingleton<_i361.Dio>(() => injectableModule.dioInstance);
    gh.lazySingleton<_i974.Logger>(() => injectableModule.logger);
    gh.lazySingleton<_i265.AppCubit>(() => _i265.AppCubit());
    gh.lazySingleton<_i815.Configuration>(
      () => _i318.DevConfiguration(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i815.Configuration>(
      () => _i318.StagingConfiguration(),
      registerFor: {_staging},
    );
    gh.lazySingleton<_i12.WishListLocalDataBase>(
        () => _i12.WishListLocalDataBaseImpl());
    gh.lazySingleton<_i509.ProductRemoteDataSource>(
        () => _i509.ProductRemoteDataSourceImpl(
              gh<_i361.Dio>(),
              gh<_i815.Configuration>(),
            ));
    gh.lazySingleton<_i856.ProductRepository>(() => _i255.ProductRepositoryImpl(
          gh<_i509.ProductRemoteDataSource>(),
          gh<_i12.WishListLocalDataBase>(),
          gh<_i974.Logger>(),
        ));
    gh.lazySingleton<_i815.Configuration>(
      () => _i318.ProdConfiguration(),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i391.GetCategoriesUseCase>(
        () => _i391.GetCategoriesUseCase(repo: gh<_i856.ProductRepository>()));
    gh.lazySingleton<_i895.GetProductByIdUseCase>(
        () => _i895.GetProductByIdUseCase(repo: gh<_i856.ProductRepository>()));
    gh.lazySingleton<_i776.GetProductUseCase>(
        () => _i776.GetProductUseCase(repo: gh<_i856.ProductRepository>()));
    gh.factory<_i472.GetProductCubit>(
        () => _i472.GetProductCubit(gh<_i776.GetProductUseCase>()));
    gh.lazySingleton<_i836.AddProductToWishlistUseCase>(() =>
        _i836.AddProductToWishlistUseCase(
            repository: gh<_i856.ProductRepository>()));
    gh.lazySingleton<_i823.DeleteProductFromWishListUseCase>(() =>
        _i823.DeleteProductFromWishListUseCase(
            repository: gh<_i856.ProductRepository>()));
    gh.lazySingleton<_i807.GetAllProductInWishListUseCase>(() =>
        _i807.GetAllProductInWishListUseCase(
            repository: gh<_i856.ProductRepository>()));
    gh.factory<_i382.GetCategoriesCubit>(
        () => _i382.GetCategoriesCubit(gh<_i391.GetCategoriesUseCase>()));
    gh.factory<_i897.GetProductByIdCubit>(
        () => _i897.GetProductByIdCubit(gh<_i895.GetProductByIdUseCase>()));
    gh.factory<_i819.AddProductToWishlistCubit>(() =>
        _i819.AddProductToWishlistCubit(
            gh<_i836.AddProductToWishlistUseCase>()));
    gh.lazySingleton<_i321.GetAllProductInWishListCubit>(() =>
        _i321.GetAllProductInWishListCubit(
            gh<_i807.GetAllProductInWishListUseCase>()));
    gh.lazySingleton<_i419.DeleteProductFromWishListCubit>(() =>
        _i419.DeleteProductFromWishListCubit(
            gh<_i823.DeleteProductFromWishListUseCase>()));
    return this;
  }
}

class _$InjectableModule extends _i712.InjectableModule {}
