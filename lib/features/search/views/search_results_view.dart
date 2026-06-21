import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mishwar/core/widgets/default_car_card.dart';
import 'package:mishwar/features/search/cubits/search/search_cubit.dart';
import 'package:mishwar/features/search/cubits/search/search_state.dart';
import 'package:mishwar/features/search/data/models/car_search_params.dart';
import 'package:mishwar/features/search/data/models/search_results_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchResultsView extends StatelessWidget {
  final CarSearchParams params;

  const SearchResultsView({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit()..search(params),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          SearchCubit cubit = context.read<SearchCubit>();
          List<Data> cars = cubit.searchResultsModel?.cars.data ?? [];
          bool isLoading = state is SearchLoadingState;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Search Results'),
              centerTitle: true,
            ),
            body: cars.isEmpty && !isLoading
                ? const Center(child: Text('No results found'))
                : Skeletonizer(
                    enabled: isLoading,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: isLoading ? 5 : cars.length,
                      itemBuilder: (_, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: isLoading
                            ? const DefaultCarCard(
                                id: 0,
                                index: -1,
                                imageUrl: '',
                                brandName: 'Brand',
                                model: 'Model',
                                year: '2026',
                                seats: 4,
                                fuelType: 'Fuel',
                                transmission: 'Auto',
                                pricePerDay: 0,
                              )
                            : DefaultCarCard(
                                brandName: cars[index].brand.name,
                                id: cars[index].id,
                                fuelType: cars[index].fuelType,
                                imageUrl: cars[index].primaryImage.imageUrl,
                                index: index,
                                model: cars[index].model,
                                pricePerDay: cars[index].pricePerDay,
                                year: cars[index].year,
                                seats: cars[index].seats,
                                transmission: cars[index].transmission,
                              ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
