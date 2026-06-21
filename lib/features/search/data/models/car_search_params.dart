class CarSearchParams {
  final String? query;
  final int? brandId;
  final String? color;
  final String? transmission;
  final int? year;
  final String? fuelType;
  final int? seats;
  final bool? featured;
  final double? minPrice;
  final double? maxPrice;

  const CarSearchParams({
    this.query,
    this.brandId,
    this.color,
    this.transmission,
    this.year,
    this.fuelType,
    this.seats,
    this.featured,
    this.minPrice,
    this.maxPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      if (brandId != null) 'brand_id': brandId,
      if (color != null) 'color': color,
      if (transmission != null) 'transmission': transmission,
      if (year != null) 'year': year,
      if (fuelType != null) 'fuel_type': fuelType,
      if (seats != null) 'seats': seats,
      if (featured != null) 'featured': featured,
      if (minPrice != null) 'min_price': minPrice,
      if (maxPrice != null) 'max_price': maxPrice,
    };
  }
}