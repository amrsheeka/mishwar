import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mishwar/core/utils/navigation.dart';
import 'package:mishwar/core/widgets/default_button.dart';
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
    return BlocProvider(
      create: (context) => SearchCubit()..getBrands(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Search Cars')),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            SearchCubit cubit = context.read<SearchCubit>();
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by model',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  DropdownButtonFormField<int>(
                    initialValue: selectedBrand,

                    decoration: const InputDecoration(labelText: 'Brand'),
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

                  const SizedBox(height: 12),

                  DropdownButtonFormField<String>(
                    initialValue: selectedTransmission,
                    decoration: const InputDecoration(
                      labelText: 'Transmission',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'automatic',
                        child: Text('Automatic'),
                      ),
                      DropdownMenuItem(value: 'manual', child: Text('Manual')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedTransmission = value;
                      });
                    },
                  ),

                  const SizedBox(height: 12),

                  DropdownButtonFormField<String>(
                    initialValue: selectedFuelType,
                    decoration: const InputDecoration(labelText: 'Fuel Type'),
                    items: const [
                      DropdownMenuItem(value: 'petrol', child: Text('Petrol')),
                      DropdownMenuItem(value: 'diesel', child: Text('Diesel')),
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

                  const SizedBox(height: 20),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Price Range',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
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

                  SwitchListTile(
                    title: const Text('Featured Only'),
                    value: featured,
                    onChanged: (value) {
                      setState(() {
                        featured = value;
                      });
                    },
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: DefaultButton(text: 'Search', onPressed: (){
                      search();
                    }),
                  ),
                ],
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
    navigateTo(context: context, page: SearchResultsView(params: params));
  }
}
