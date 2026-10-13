import 'package:ecommerce_app_huma_volve/features/home/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/product_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}
class CategoryLoading extends HomeState {}
class CategorySuccess extends HomeState {
  final List<CategoryModel> categories;

  CategorySuccess(this.categories);
}
class CategoryFailure extends HomeState {
  final String error;

  CategoryFailure(this.error);
}
class ProductLoading extends HomeState {}
class ProductSuccess extends HomeState {
  final List<ProductModel> products;

  ProductSuccess(this.products);
}
class ProductFailure extends HomeState {
  final String error;

  ProductFailure(this.error);
}
