
import 'package:ecommerce_app_huma_volve/core/constants/api_endpioints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/product_model.dart';

class HomeService {
 final  ApiClient apiClient;
  HomeService( this.apiClient);
  Future<List<CategoryModel>> getCateories() async {
    final response = await apiClient.dio.get(ApiEndpioints.categoriesEndpoint);
    final List jsonData = response.data;
    final List<CategoryModel> categories = jsonData
        .map((e) => CategoryModel.fromJson(e))
        .toList();
    return categories;
  }

  Future<List<ProductModel>> getProducts(int? categoryId) async {
    final response = await apiClient.dio.get(
      '${ApiEndpioints.categoriesEndpoint}/$categoryId/${ApiEndpioints.productsEndpoint}',
    );
    final List jsonData = response.data;
    final List<ProductModel> products = jsonData
        .map((e) => ProductModel.fromJson(e))
        .toList();
    return products;
  }
}
