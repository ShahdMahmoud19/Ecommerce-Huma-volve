import 'package:ecommerce_app_huma_volve/core/constants/api_endpioints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';

class HomeRemoteDataSourceImp extends HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSourceImp(this.apiClient);

  @override
  Future<List<HomeCategoryModel>> getCateories() async {
    final response = await apiClient.dio.get(ApiEndpioints.categoriesEndpoint);
    final List jsonData = response.data;
    final List<HomeCategoryModel> categories = jsonData
        .map((e) => HomeCategoryModel.fromJson(e))
        .toList();
    return categories;
  }

  @override
  Future<List<HomeProductModel>> getProducts(int? categoryId, { required int limit,
    required int offset,}) async {
    final response = await apiClient.dio.get(
      '${ApiEndpioints.categoriesEndpoint}/$categoryId/${ApiEndpioints.productsEndpoint}',
      queryParameters: {
        "limit":limit,
        "offset":offset,
      }
    );
    final List jsonData = response.data;
    final List<HomeProductModel> products = jsonData
        .map((e) => HomeProductModel.fromJson(e))
        .toList();
    return products;
  }
}
