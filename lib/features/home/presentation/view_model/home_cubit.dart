import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_cateories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCateoriesUseCase getCateoriesUseCase;
  final GetProductsUseCase getProductsUseCase;
  int limit = 10;
  int offset = 0;
  bool hasMore = true;
  bool isLoadingMore = false;
  int? selectedCategory;
  final List<HomeProductEntity> _products = [];
  HomeCubit(this.getCateoriesUseCase, this.getProductsUseCase)
    : super(HomeInitial());
  Future<void> loadHomeData() async {
    emit(CategoryLoading());
    final categoriesResult = await getCateoriesUseCase.invoke();
    int id = 0;
    categoriesResult.fold(
      (failure) {
        emit(CategoryFailure(failure.failureMessage));
      },
      (categoriesResult) {
        id = categoriesResult.first.id;
        emit(CategorySuccess(categoriesResult));
      },
    );
    await getProductsByCategoryId(id);
  }

  Future<void> getProductsByCategoryId(int id) async {
    _products.clear();
    hasMore = true;
    emit(ProductLoading());
    final products = await getProductsUseCase.invoke(
      id,
      limit: limit,
      offset: offset,
    );
    products.fold(
      (failure) {
        emit(ProductFailure(failure.failureMessage));
      },
      (products) {
        _products.addAll(products);
        offset = products.length;
        if (products.length < limit) {
          hasMore = false;
        }
        selectedCategory = id;
        emit(ProductSuccess(List.from(_products)));
      },
    );
  }

  Future<void> loadMoreproducts() async {
    if (isLoadingMore || !hasMore) return;
    isLoadingMore = true;
    emit(ProductsLoadingMore());
    final result = await getProductsUseCase.invoke(
      selectedCategory,
      limit: limit,
      offset: offset,
    );
    result.fold(
      (failure) {
        emit(ProductsLoadingError(failure.failureMessage));
      },
      (newProducts) {
        _products.addAll(newProducts);
        offset += newProducts.length;
        if (newProducts.length < limit) {
          hasMore = false;
        }
        emit(ProductSuccess(_products));
      },
    );
  }
}
