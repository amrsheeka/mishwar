class ReviewsResponseModel {
  final bool success;
  final String message;
  final Reviews reviews;

  ReviewsResponseModel({
    required this.success,
    required this.message,
    required this.reviews,
  });

  factory ReviewsResponseModel.fromJson(Map<String, dynamic> json) {
    return ReviewsResponseModel(
      success: json['success'],
      message: json['message'],
      reviews: Reviews.fromJson(json['reviews']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'reviews': reviews.toJson(),
    };
  }
}

class Reviews {
  final List<Review> data;
  final String path;
  final int perPage;
  final String? nextCursor;
  final String? nextPageUrl;
  final String? prevCursor;
  final String? prevPageUrl;
  final int reviewsCount;
  final double averageRating;

  Reviews({
    required this.data,
    required this.path,
    required this.perPage,
    this.nextCursor,
    this.nextPageUrl,
    this.prevCursor,
    this.prevPageUrl,
    required this.reviewsCount,
    required this.averageRating,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      data: (json['data'] as List)
          .map((e) => Review.fromJson(e))
          .toList(),
      path: json['path'],
      perPage: json['per_page'],
      nextCursor: json['next_cursor'],
      nextPageUrl: json['next_page_url'],
      prevCursor: json['prev_cursor'],
      prevPageUrl: json['prev_page_url'],
      reviewsCount: json['reviews_count'],
      averageRating: (json['average_rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'path': path,
      'per_page': perPage,
      'next_cursor': nextCursor,
      'next_page_url': nextPageUrl,
      'prev_cursor': prevCursor,
      'prev_page_url': prevPageUrl,
      'reviews_count': reviewsCount,
      'average_rating': averageRating,
    };
  }
}

class Review {
  final int id;
  final int userId;
  final int carId;
  final int rating;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ReviewUser user;

  Review({
    required this.id,
    required this.userId,
    required this.carId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      userId: json['user_id'],
      carId: json['car_id'],
      rating: json['rating'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: ReviewUser.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'car_id': carId,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'user': user.toJson(),
    };
  }
}

class ReviewUser {
  final int id;
  final String name;

  ReviewUser({
    required this.id,
    required this.name,
  });

  factory ReviewUser.fromJson(Map<String, dynamic> json) {
    return ReviewUser(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}