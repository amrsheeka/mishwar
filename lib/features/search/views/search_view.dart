import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/utils/navigation.dart';
import 'package:mishwar/core/widgets/default_button.dart';
import 'package:mishwar/core/widgets/default_text_field.dart';
import 'package:mishwar/core/widgets/responsive_content.dart';
import 'package:mishwar/features/search/cubits/search/search_cubit.dart';
import 'package:mishwar/features/search/cubits/search/search_state.dart';
import 'package:mishwar/features/search/data/models/car_search_params.dart';
import 'package:mishwar/features/search/views/search_results_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final searchController = TextEditingController();

  double minPrice = 0;
  double maxPrice = 1000;

  int? selectedBrand;
  String? selectedColor;
  String? selectedTransmission;
  String? selectedFuelType;
  int? selectedSeats;
  int? selectedYear;
  bool featured = false;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor = isDark
        ? AppColors.backgroundDark
        : AppColors.background;
    final Color surfaceColor = isDark
        ? AppColors.surfaceDark
        : AppColors.surface;

    return BlocProvider(
      create: (context) => SearchCubit()..getBrands(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(title: const Text('Search Cars')),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            SearchCubit cubit = context.read<SearchCubit>();
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ResponsiveContent(
                maxWidth: 760,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Discover cars',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Filter by model, brand, features, and budget.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 22),
                    DefaultTextField(
                      controller: searchController,
                      hintText: 'Search by model',
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppColors.grey,
                      ),
                    ),

                    const SizedBox(height: 16),

                    LayoutBuilder(
                      builder: (context, constraints) {
                        final bool twoColumns = constraints.maxWidth >= 640;
                        final double itemWidth = twoColumns
                            ? (constraints.maxWidth - 12) / 2
                            : constraints.maxWidth;

                        return Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            SizedBox(
                              width: itemWidth,
                              child: DropdownButtonFormField<int>(
                                initialValue: selectedBrand,
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  labelText: 'Brand',
                                  prefixIcon: Icon(
                                    Icons.directions_car_outlined,
                                    color: AppColors.grey,
                                  ),
                                ),
                                items: cubit.brandsModel?.brands.map((brand) {
                                  return DropdownMenuItem<int>(
                                    value: brand.id,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: brand.logo,
                                          width: 24,
                                          height: 24,
                                          fit: BoxFit.contain,
                                        ),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: Text(
                                            brand.name,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedBrand = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: itemWidth,
                              child: DropdownButtonFormField<String>(
                                initialValue: selectedTransmission,
                                decoration: const InputDecoration(
                                  labelText: 'Transmission',
                                  prefixIcon: Icon(
                                    Icons.settings_outlined,
                                    color: AppColors.grey,
                                  ),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'automatic',
                                    child: Text('Automatic'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'manual',
                                    child: Text('Manual'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    selectedTransmission = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: itemWidth,
                              child: DropdownButtonFormField<String>(
                                initialValue: selectedFuelType,
                                decoration: const InputDecoration(
                                  labelText: 'Fuel Type',
                                  prefixIcon: Icon(
                                    Icons.local_gas_station_outlined,
                                    color: AppColors.grey,
                                  ),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'petrol',
                                    child: Text('Petrol'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'diesel',
                                    child: Text('Diesel'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'electric',
                                    child: Text('Electric'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    selectedFuelType = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 22),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: surfaceColor,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: AppColors.primary.withValues(
                            alpha: isDark ? 0.18 : 0.10,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Price Range',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              Text(
                                '\$${minPrice.toInt()} - \$${maxPrice.toInt()}',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                            ],
                          ),
                          RangeSlider(
                            values: RangeValues(minPrice, maxPrice),
                            min: 0,
                            max: 1000,
                            divisions: 20,
                            labels: RangeLabels(
                              '\$${minPrice.toInt()}',
                              '\$${maxPrice.toInt()}',
                            ),
                            onChanged: (value) {
                              setState(() {
                                minPrice = value.start;
                                maxPrice = value.end;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      decoration: BoxDecoration(
                        color: surfaceColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: SwitchListTile(
                        title: const Text('Featured Only'),
                        value: featured,
                        activeColor: AppColors.primary,
                        onChanged: (value) {
                          setState(() {
                            featured = value;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    DefaultButton(
                      text: 'Search',
                      onPressed: () {
                        search();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void search() {
    final params = CarSearchParams(
      query: searchController.text.trim(),
      brandId: selectedBrand,
      transmission: selectedTransmission,
      fuelType: selectedFuelType,
      featured: featured ? true : null,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
    navigateTo(
      context: context,
      page: BlocProvider(
        create: (context) => SearchCubit()..search(params),
        child: SearchResultsView(params: params),
      ),
    );
  }
}
