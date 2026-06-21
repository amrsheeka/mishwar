import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mishwar/features/car_details/cubits/car_details/car_details_state.dart';
import 'package:mishwar/features/car_details/data/models/car_details_model.dart';
import 'package:mishwar/features/car_details/data/services/car_details_service.dart';

class CarDetailsCubit extends Cubit<CarDetailsState> {
	CarDetailsCubit() : super(CarDetailsIniteState());
	
	CarDetailsModel? carDetailsModel;
  void getCarDetails({required int id}) async {
    emit(GetCarDetailsLoadingState());
    try {
      carDetailsModel = await CarDetailsService.getCarById(id);
      if (carDetailsModel != null) {
        emit(GetCarDetailsSuccessState());
      } else {
        emit(GetCarDetailsErrorState('Failed to load car details'));
      }
    } catch (error) {
      emit(GetCarDetailsErrorState('Failed to load car details'));
    }
  }
}
