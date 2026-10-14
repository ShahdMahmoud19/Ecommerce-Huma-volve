import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error/erorr_handling.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImp extends HomeRepository {
  HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImp(this.homeRemoteDataSource);
  @override
  Future<Either<Failure, List<HomeCategoryEntity>>> getCateories() async {
    try {
      final category = await homeRemoteDataSource.getCateories();
      return Right(category as List<HomeCategoryEntity>);
    } catch (e) {
      return Left((ErrorHandler.handle(e)));
    }
  }

  @override
  Future<Either<Failure, List<HomeProductEntity>>> getProducts(
    int? categoryId,
  ) async {
    try {
      final product = await homeRemoteDataSource.getProducts(categoryId);
      return Right(product as List<HomeProductEntity>);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
