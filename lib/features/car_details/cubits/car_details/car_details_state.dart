sealed class CarDetailsState {}

class CarDetailsIniteState extends CarDetailsState{}

//class GetCarDetailsLoadingState extends CarDetailsState{}
class GetCarDetailsSuccessState extends CarDetailsState{}
class GetCarDetailsErrorState extends CarDetailsState {
  String message;
  GetCarDetailsErrorState(this.message);
}
//class GetReviewsLoadingState extends CarDetailsState{}
class GetReviewsSuccessState extends CarDetailsState{}
class GetReviewsErrorState extends CarDetailsState {
  String message;
  GetReviewsErrorState(this.message);
}