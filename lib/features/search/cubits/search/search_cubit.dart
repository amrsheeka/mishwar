import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mishwar/features/home/data/models/brands_model.dart';
import 'package:mishwar/features/search/cubits/search/search_state.dart';
import 'package:mishwar/features/search/data/models/car_search_params.dart';
import 'package:mishwar/features/search/data/models/search_results_model.dart';
import 'package:mishwar/features/search/data/services/search_service.dart';

class SearchCubit extends Cubit<SearchState> {
	SearchCubit() : super(SearchInitState());

  SearchResultsModel? searchResultsModel;
  void search(CarSearchParams params) async {
    emit(SearchLoadingState());
    try {
      searchResultsModel = await SearchService.search(params);

      if (searchResultsModel != null) {
        emit(SearchSuccessState());
      } else {
        emit(SearchErrorState('Failed to load featured cars'));
      }
    } catch (error) {
      emit(SearchErrorState('Failed to load featured cars'));
    }
  }

  bool isLoadingMore = false;

  Future<void> loadMoreResults() async {
    
  if (isLoadingMore) return;

  final nextPageUrl = searchResultsModel?.cars.nextPageUrl;

  if (nextPageUrl == null) return;

  isLoadingMore = true;

  emit(GetMoreLoadingState());
  try {
    final more = await SearchService.getMore(nextPageUrl);
    
    if (searchResultsModel==null || more==null) {
      return;
    }
    
    searchResultsModel!.cars.data.addAll(more.cars.data);
    searchResultsModel!.cars.nextPageUrl =
        more.cars.nextPageUrl;

    emit(SearchSuccessState());
  } catch (e) {
    emit(SearchErrorState(
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
      brandsModel = await SearchService.getBrands();
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
