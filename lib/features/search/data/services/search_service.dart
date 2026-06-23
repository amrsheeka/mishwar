import 'package:mishwar/core/utils/dio_helper.dart';
import 'package:mishwar/features/home/data/models/brands_model.dart';
import 'package:mishwar/features/search/data/models/car_search_params.dart';
import 'package:mishwar/features/search/data/models/search_results_model.dart';

class SearchService {
  static Future<BrandsModel?> getBrands() async {
    final response = await DioHelper.getData(url: 'brands');
    if (response.statusCode == 200) {
      return BrandsModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  static Future<SearchResultsModel?> search(CarSearchParams params) async {
    final response = await DioHelper.postData(url: 'cars/search',query: {'query':params.query??''},data: params.toJson());
    if (response.statusCode == 200) {
      return SearchResultsModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  static Future<SearchResultsModel?> getMore(
    String? nextPageUrl,
  ) async {
    try {

      if (nextPageUrl != null) {
        final response = await DioHelper.postData(url: nextPageUrl);

        if (response.statusCode == 200) {
          return SearchResultsModel.fromJson(response.data);
        }
      }

      return null;
    } catch (e, s) {
      rethrow;
    }
  }
}