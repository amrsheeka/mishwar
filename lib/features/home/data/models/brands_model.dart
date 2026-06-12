class BrandsModel {
  BrandsModel({
    required this.success,
    required this.message,
    required this.brands,
  });
  late final bool success;
  late final String message;
  late final Brands brands;
  
  BrandsModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    brands = Brands.fromJson(json['brands']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['brands'] = brands.toJson();
    return _data;
  }
}

class Brands {
  Brands({
    required this.data,
    required this.path,
    required this.perPage,
     this.nextCursor,
     this.nextPageUrl,
     this.prevCursor,
     this.prevPageUrl,
  });
  late final List<Data> data;
  late final String path;
  late final int perPage;
  late final Null nextCursor;
  late final Null nextPageUrl;
  late final Null prevCursor;
  late final Null prevPageUrl;
  
  Brands.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    path = json['path'];
    perPage = json['per_page'];
    nextCursor = null;
    nextPageUrl = null;
    prevCursor = null;
    prevPageUrl = null;
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

class Data {
  Data({
    required this.id,
    required this.name,
    required this.logo,
  });
  late final int id;
  late final String name;
  late final String logo;
  
  Data.fromJson(Map<String, dynamic> json){
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