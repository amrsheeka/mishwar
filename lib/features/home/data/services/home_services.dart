import 'package:mishwar/core/utils/dio_helper.dart';
import 'package:mishwar/features/home/data/models/featured_cars_model.dart';
import 'package:mishwar/features/home/data/models/brands_model.dart';
class HomeServices {
  static Future<FeaturedCarsModel?> getFeaturedCars() async {
    final response = await DioHelper.getData(url: 'cars');
    if (response.statusCode == 200) {
      return FeaturedCarsModel.fromJson(response.data);
    } else {
      return null;
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
