
sealed class SearchState {}
abstract class ErrorState extends SearchState{
  final String message;
  ErrorState(this.message);
}

class SearchInitState extends SearchState{}
class GetBrandsLoadingState extends SearchState {}
class GetBrandsSuccessState extends SearchState {}
class GetBrandsErrorState extends ErrorState {
  GetBrandsErrorState(super.message);
}

class SearchLoadingState extends SearchState {}
class SearchSuccessState extends SearchState {}
class SearchErrorState extends ErrorState {
  SearchErrorState(super.message);
}
class GetMoreLoadingState extends SearchState {}
