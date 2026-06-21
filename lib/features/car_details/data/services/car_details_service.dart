import 'package:mishwar/core/utils/dio_helper.dart';
import 'package:mishwar/features/car_details/data/models/car_details_model.dart';

class CarDetailsService {
  static Future<CarDetailsModel?> getCarById(int id) async {
    try {
      final response = await DioHelper.getData(url: 'cars/$id');

      if (response.statusCode == 200) {
        return CarDetailsModel.fromJson(response.data);
      }

      return null;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
