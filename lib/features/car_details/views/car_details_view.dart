import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mishwar/core/models/car.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/styles/icon_broken.dart';
import 'package:mishwar/features/car_details/cubits/car_details/car_details_cubit.dart';
import 'package:mishwar/features/car_details/cubits/car_details/car_details_state.dart';
import 'package:mishwar/features/car_details/data/models/car_details_model.dart';
import 'package:mishwar/features/car_details/views/widgets/car_preview.dart';
import 'package:mishwar/features/car_details/views/widgets/description_card.dart';
import 'package:mishwar/features/car_details/views/widgets/quick_info_card.dart';
import 'package:mishwar/features/car_details/views/widgets/specification_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CarDetailsView extends StatefulWidget {
  final int id;
  const CarDetailsView({super.key, required this.id});

  @override
  State<CarDetailsView> createState() => _CarDetailsViewState();
}

class _CarDetailsViewState extends State<CarDetailsView> {
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => CarDetailsCubit()..getCarDetails(id: widget.id),
      child: BlocBuilder<CarDetailsCubit, CarDetailsState>(
        builder: (context, state) {
          CarDetailsCubit cubit = context.read<CarDetailsCubit>();
          Car? car = cubit.carDetailsModel?.car;
          bool isLoading = state is GetCarDetailsLoadingState;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: Skeletonizer(
                enabled: isLoading,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Center(child: Icon(IconBroken.Arrow___Left)),
                ),
              ),
              actions: [
                //todo
                Skeletonizer(
                  enabled: isLoading,
                  child: IconButton(
                    onPressed: () {},
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:isDark? AppColors.surfaceDark:AppColors.surface,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Icon(
                          IconBroken.Heart,
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              title: Skeletonizer(
                enabled: isLoading,
                child: Text('${car?.brand.name} ${car?.model} ${car?.year}'),
              ),
            ),
            body: Skeletonizer(
              enabled: isLoading,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarPreview(car: car),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          quickInfoCard(car:car),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              'Specification',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),

                          LayoutBuilder(
                            builder: (context, constraints) {
                              int crossAxisCount = constraints.maxWidth < 600
                                  ? 2
                                  : 4;

                              return GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 2.3,
                                children: [
                                  SpecificationItem(
                                    title: 'Number of seats',
                                    icon: Icons.chair_sharp,
                                    value: '${car?.seats}',
                                  ),
                                  SpecificationItem(
                                    title: 'Common fuel inj.',
                                    icon: Icons.propane_tank_sharp,
                                    value: '${car?.fuelType}',
                                  ),
                                  SpecificationItem(
                                    title: 'Skin color',
                                    icon: Icons.color_lens_rounded,
                                    value: '${car?.color}',
                                  ),
                                  SpecificationItem(
                                    title: 'Drive transmission',
                                    icon: Icons.drive_eta_sharp,
                                    value: '${car?.transmission}',
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          descriptionCard(context,car?.description ?? ''),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
