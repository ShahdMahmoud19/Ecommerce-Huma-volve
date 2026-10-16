import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class CategoryLoading extends HomeState {}

class CategorySuccess extends HomeState {
  final List<HomeCategoryEntity> categories;

  CategorySuccess(this.categories);
}

class CategoryFailure extends HomeState {
  final String error;

  CategoryFailure(this.error);
}

class ProductLoading extends HomeState {}

class ProductSuccess extends HomeState {
  final List<HomeProductEntity> products;

  ProductSuccess(this.products);
}

class ProductFailure extends HomeState {
  final String error;

  ProductFailure(this.error);
}
class ProductsLoadingMore extends HomeState {}
class ProductsLoadingError extends HomeState {
    final String error;
ProductsLoadingError(this.error);
}