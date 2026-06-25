class FeaturedCarsModel {
  FeaturedCarsModel({
    required this.success,
    required this.message,
    required this.cars,
  });
  late bool success;
  late String message;
  late Cars cars;
  
  FeaturedCarsModel.fromJson(Map<String, dynamic> json){
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

class Data {
  Data({
    required this.id,
    required this.branchId,
    required this.brandId,
    required this.model,
    required this.year,
    required this.color,
    required this.transmission,
    required this.fuelType,
    required this.seats,
    required this.pricePerDay,
    required this.description,
    required this.status,
    required this.featured,
    required this.createdAt,
    required this.updatedAt,
    required this.branch,
    required this.primaryImage,
    required this.brand,
    required this.reviewsAvgRating,
    required this.reviewsCount
  });
  late final int id;
  late final int branchId;
  late final int brandId;
  late final String model;
  late final String year;
  late final String color;
  late final String transmission;
  late final String fuelType;
  late final int seats;
  late final double pricePerDay;
  late final String description;
  late final String status;
  late final int featured;
  late final String createdAt;
  late final String updatedAt;
  late final Branch branch;
  late final PrimaryImage primaryImage;
  late final Brand brand;
  late final int reviewsCount;
  late final double reviewsAvgRating;

  
  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    branchId = json['branch_id'];
    brandId = json['brand_id'];
    model = json['model'];
    year = json['year'];
    color = json['color'];
    transmission = json['transmission'];
    fuelType = json['fuel_type'];
    seats = json['seats'];
    pricePerDay = double.parse(json['price_per_day']);
    description = json['description'];
    status = json['status'];
    featured = json['featured'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    branch = Branch.fromJson(json['branch']);
    primaryImage = PrimaryImage.fromJson(json['primary_image']);
    brand = Brand.fromJson(json['brand']);
    reviewsCount = json['revewis_count']??0;
    reviewsAvgRating = double.parse(json['reviews_avg_rating']??'0');
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['branch_id'] = branchId;
    _data['brand_id'] = brandId;
    _data['model'] = model;
    _data['year'] = year;
    _data['color'] = color;
    _data['transmission'] = transmission;
    _data['fuel_type'] = fuelType;
    _data['seats'] = seats;
    _data['price_per_day'] = pricePerDay;
    _data['description'] = description;
    _data['status'] = status;
    _data['featured'] = featured;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['branch'] = branch.toJson();
    _data['primary_image'] = primaryImage.toJson();
    _data['brand'] = brand.toJson();
    return _data;
  }
}

class Branch {
  Branch({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String name;
  late final String city;
  late final String address;
  late final double latitude;
  late final double longitude;
  late final String createdAt;
  late final String updatedAt;
  
  Branch.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    city = json['city'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['city'] = city;
    _data['address'] = address;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class PrimaryImage {
  PrimaryImage({
    required this.id,
    required this.carId,
    required this.isMain,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
  });
  late final int id;
  late final int carId;
  late final int isMain;
  late final String createdAt;
  late final String updatedAt;
  late final String imageUrl;
  
  PrimaryImage.fromJson(Map<String, dynamic> json){
    id = json['id'];
    carId = json['car_id'];
    isMain = json['is_main'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['car_id'] = carId;
    _data['is_main'] = isMain;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['image_url'] = imageUrl;
    return _data;
  }
}

class Brand {
  Brand({
    required this.id,
    required this.name,
     this.createdAt,
     this.updatedAt,
    required this.logoUrl,
  });
  late final int id;
  late final String name;
  late final Null createdAt;
  late final Null updatedAt;
  late final String logoUrl;
  
  Brand.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    createdAt = null;
    updatedAt = null;
    logoUrl = json['logo_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['logo_url'] = logoUrl;
    return _data;
  }
}