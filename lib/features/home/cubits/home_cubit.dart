import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mishwar/features/home/cubits/home_state.dart';
import 'package:mishwar/features/home/data/models/brands_model.dart';
import 'package:mishwar/features/home/data/models/featured_cars_model.dart';
import 'package:mishwar/features/home/data/services/home_services.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  List<String> slider = [
    'https://cnn-arabic-images.cnn.io/cloudinary/image/upload/w_1920,h_1080,c_fill,q_auto,g_center/cnnarabic/2023/06/29/images/244073.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSV7Zzidr-SrferucmsbI17YGfO9uJA0FDjaUaKX4jtEEJGnJfnxNZ2S00&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS--RvSjtDlTIbFOtf2W5pYGSmmHVhGLtcOUeBeLtAWjpeKZEOyjl281E8&s',
  ];
  int sliderIndex = 0;
  void changeSliderIndex(int index) {
    sliderIndex = index;
    emit(ChangeSliderIndexState());
  }

  FeaturedCarsModel? featuredCarsModel;
  void getFeaturedCars() async {
    emit(GetFeaturedCarsLoadingState());
    try {
      featuredCarsModel = await HomeServices.getFeaturedCars();

      if (featuredCarsModel != null) {
        emit(GetFeaturedCarsSuccessState());
      } else {
        emit(GetFeaturedCarsErrorState('Failed to load featured cars'));
      }
    } catch (error) {
      emit(GetFeaturedCarsErrorState('Failed to load featured cars'));
    }
  }

  bool isLoadingMore = false;

  Future<void> loadMoreFeaturedCars() async {
    
  if (isLoadingMore) return;

  final nextPageUrl = featuredCarsModel?.cars.nextPageUrl;

  if (nextPageUrl == null) return;

  isLoadingMore = true;

  emit(GetMoreFeaturedCarsLoadingState());
  try {
    final more = await HomeServices.getMoreFeaturedCars(nextPageUrl);
    
    if (featuredCarsModel==null || more==null) {
      return;
    }
    
    featuredCarsModel!.cars.data.addAll(more.cars.data);
    featuredCarsModel!.cars.nextPageUrl =
        more.cars.nextPageUrl;

    emit(GetMoreFeaturedCarsSuccessState());
  } catch (e) {
    emit(GetMoreFeaturedCarsErrorState(
      'Failed to load more featured cars',
    ));
  } finally {
    isLoadingMore = false;
  }
}

  BrandsModel? brandsModel;
  void getBrands() async {
    emit(GetBrandsLoadingState());
    try {
      brandsModel = await HomeServices.getBrands();
      if (brandsModel != null) {
        emit(GetBrandsSuccessState());
      } else {
        emit(GetBrandsErrorState('Failed to load brands'));
      }
    } catch (error) {
      emit(GetBrandsErrorState('Failed to load brands'));
    }
  }
}
