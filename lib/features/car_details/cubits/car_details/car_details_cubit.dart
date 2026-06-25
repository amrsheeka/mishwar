import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mishwar/features/car_details/cubits/car_details/car_details_state.dart';
import 'package:mishwar/features/car_details/data/models/car_details_model.dart';
import 'package:mishwar/features/car_details/data/models/reviews_response_model.dart';
import 'package:mishwar/features/car_details/data/services/car_details_service.dart';

class CarDetailsCubit extends Cubit<CarDetailsState> {
	CarDetailsCubit() : super(CarDetailsIniteState());
	
  bool isCarLoading = false;
  bool isReviewsLoading = false;
	CarDetailsModel? carDetailsModel;
  void getCarDetails({required int id}) async {
   isCarLoading = true;
    try {
      carDetailsModel = await CarDetailsService.getCarById(id);
      if (carDetailsModel != null) {
        isCarLoading = false;
        emit(GetCarDetailsSuccessState());
      } else {
        isCarLoading = false;
        emit(GetCarDetailsErrorState('Failed to load car details'));
      }
    } catch (error) {
      isCarLoading = false;
      emit(GetCarDetailsErrorState('Failed to load car details'));
    }
  }

  ReviewsResponseModel? reviewsResponseModel;
  void getReviews({required int id}) async {
    isReviewsLoading = true;
    try {
      reviewsResponseModel = await CarDetailsService.getCarReviewsById(id);
      if (reviewsResponseModel != null) {
        isReviewsLoading = false;
        emit(GetReviewsSuccessState());
      } else {
        isReviewsLoading = false;
        emit(GetReviewsErrorState('Failed to load reviews details'));
      }
    } catch (error) {
      isReviewsLoading = false;
      emit(GetReviewsErrorState('Failed to load reviews details'));
    }
  }
}
