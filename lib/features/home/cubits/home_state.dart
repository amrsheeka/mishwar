sealed class HomeState {}
class HomeInitialState extends HomeState {}
class ChangeSliderIndexState extends HomeState {}
class GetFeaturedCarsLoadingState extends HomeState {}
class GetFeaturedCarsSuccessState extends HomeState {}
class GetFeaturedCarsErrorState extends HomeState {
  String message;
  GetFeaturedCarsErrorState(this.message);
}
class GetBrandsLoadingState extends HomeState {}
class GetBrandsSuccessState extends HomeState {}
class GetBrandsErrorState extends HomeState {
  String message;
  GetBrandsErrorState(this.message);
}
class GetMoreFeaturedCarsLoadingState extends HomeState {}

class GetMoreFeaturedCarsSuccessState extends HomeState {}

class GetMoreFeaturedCarsErrorState extends HomeState {
  final String error;

  GetMoreFeaturedCarsErrorState(this.error);
}