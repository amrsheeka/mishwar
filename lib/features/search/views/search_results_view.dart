import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/widgets/default_car_card.dart';
import 'package:mishwar/features/home/data/models/featured_cars_model.dart';
import 'package:mishwar/features/search/cubits/search/search_cubit.dart';
import 'package:mishwar/features/search/cubits/search/search_state.dart';
import 'package:mishwar/features/search/data/models/car_search_params.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchResultsView extends StatefulWidget {
  final CarSearchParams params;

  const SearchResultsView({super.key, required this.params});

  @override
  State<SearchResultsView> createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<SearchResultsView> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController()
      ..addListener(() {
        if (_controller.position.pixels >=
            _controller.position.maxScrollExtent - 300) {
          context.read<SearchCubit>().loadMoreResults();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        SearchCubit cubit = context.read<SearchCubit>();
        List<Data> cars = cubit.searchResultsModel?.cars.data ?? [];
        final isInitialLoading = state is SearchLoadingState;

        final isLoadingMore = state is GetMoreLoadingState;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Search Results'),
            centerTitle: true,
          ),
          body: cars.isEmpty && !isInitialLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/NoResults.png'),
                      Text(
                        'No Results Found...',
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(color: AppColors.grey),
                      ),
                    ],
                  ),
                )
              : Skeletonizer(
                  enabled: isInitialLoading,
                  child: ListView.builder(
                    controller: _controller,
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: isInitialLoading
                        ? 5
                        : cars.length + (isLoadingMore ? 1 : 0),
                    itemBuilder: (_, index) {
                      if (isLoadingMore && index == cars.length) {
                        return Skeletonizer(
                          enabled: true,
                          child: const DefaultCarCard(
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
                            reviewsAvgRating: 0,
                          ),
                        );
                      }

                      final car = isInitialLoading ? null : cars[index];

                      return DefaultCarCard(
                        id: car?.id ?? 0,
                        index: index,
                        imageUrl: car?.primaryImage.imageUrl ?? '',
                        brandName: car?.brand.name ?? 'Brand',
                        model: car?.model ?? 'Model',
                        year: car?.year ?? '2026',
                        seats: car?.seats ?? 4,
                        fuelType: car?.fuelType ?? 'Fuel',
                        transmission: car?.transmission ?? 'Auto',
                        pricePerDay: car?.pricePerDay ?? 0,
                        reviewsAvgRating: car?.reviewsAvgRating??0,
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
