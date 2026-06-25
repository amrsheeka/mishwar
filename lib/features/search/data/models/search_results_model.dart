import 'package:mishwar/features/home/data/models/featured_cars_model.dart';

class SearchResultsModel {
  SearchResultsModel({
    required this.success,
    required this.message,
    required this.cars,
  });
  late bool success;
  late String message;
  late Cars cars;
  
  SearchResultsModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    cars = Cars.fromJson(json['cars']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['cars'] = cars.toJson();
    return _data;
  }
}

class Cars {
  Cars({
    required this.data,
    required this.path,
    required this.perPage,
    required this.nextCursor,
    required this.nextPageUrl,
     this.prevCursor,
     this.prevPageUrl,
  });
  late List<Data> data;
  late String? path;
  late int? perPage;
  late String? nextCursor;
  late String? nextPageUrl;
  late String? prevCursor;
  late String? prevPageUrl;
  
  Cars.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    path = json['path'];
    perPage = json['per_page'];
    nextCursor = json['next_cursor'];
    nextPageUrl = json['next_page_url'];
    prevCursor = json['prev_cursor'];
    prevPageUrl = json['prev_page_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['path'] = path;
    _data['per_page'] = perPage;
    _data['next_cursor'] = nextCursor;
    _data['next_page_url'] = nextPageUrl;
    _data['prev_cursor'] = prevCursor;
    _data['prev_page_url'] = prevPageUrl;
    return _data;
  }
}

