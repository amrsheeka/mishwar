class BrandsModel {
  BrandsModel({
    required this.success,
    required this.message,
    required this.brands,
  });
  late final bool success;
  late final String message;
  late final List<Brands> brands;
  
  BrandsModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    brands = List.from(json['brands']).map((e)=>Brands.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['brands'] = brands.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Brands {
  Brands({
    required this.id,
    required this.name,
    required this.logo,
  });
  late final int id;
  late final String name;
  late final String logo;
  
  Brands.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['logo'] = logo;
    return _data;
  }
}