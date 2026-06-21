import 'package:mishwar/core/models/car.dart';

class CarDetailsModel {
  CarDetailsModel({
    required this.success,
    required this.message,
    required this.car,
  });
  late final bool success;
  late final String message;
  late final Car car;
  
  CarDetailsModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    car = Car.fromJson(json['car']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['car'] = car.toJson();
    return _data;
  }
}

