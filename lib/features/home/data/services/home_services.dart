import 'package:mishwar/core/utils/dio_helper.dart';
import 'package:mishwar/features/home/data/models/featured_cars_model.dart';
import 'package:mishwar/features/home/data/models/brands_model.dart';

class HomeServices {
  static Future<FeaturedCarsModel?> getFeaturedCars() async {
    try{
      final response = await DioHelper.getData(url: 'cars');
    if (response.statusCode == 200) {
      return FeaturedCarsModel.fromJson(response.data);
    } else {
      return null;
    }
    }catch(e){
      rethrow;
    }
    
  }

  static Future<FeaturedCarsModel?> getMoreFeaturedCars(
    String? nextPageUrl,
  ) async {
    try {

      if (nextPageUrl != null) {
        final response = await DioHelper.getData(url: nextPageUrl);

        if (response.statusCode == 200) {
          return FeaturedCarsModel.fromJson(response.data);
        }
      }

      return null;
    } catch (e, s) {
      
      rethrow;
    }
  }

  static Future<BrandsModel?> getBrands() async {
    final response = await DioHelper.getData(url: 'brands');
    if (response.statusCode == 200) {
      return BrandsModel.fromJson(response.data);
    } else {
      return null;
    }
  }
  
}
