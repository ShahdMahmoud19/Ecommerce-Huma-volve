
import 'package:ecommerce_app_huma_volve/features/home/cubit/home_state.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/home_sevice.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeService homeService;
  HomeCubit(this.homeService) : super(HomeInitial());
  Future<void> loadHomeData() async {
    emit(CategoryLoading());
    try {
      final categories = await homeService.getCateories();
      emit(CategorySuccess(categories));
      final products = await homeService.getProducts(categories[0].id);
      emit(ProductSuccess(products));
    } catch (e) {
      emit(CategoryFailure(e.toString()));
    }
  }

  Future<void> getProductsByCategoryId(int id) async {
    emit(ProductLoading());
    try {
      final products = await homeService.getProducts(id);
      emit(ProductSuccess(products));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }
}
