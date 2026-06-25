import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/core/models/car.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/styles/icon_broken.dart';
import 'package:mishwar/core/utils/contants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarPreview extends StatefulWidget {
  final Car? car;
  const CarPreview({super.key, this.car});

  @override
  State<CarPreview> createState() => _CarPreviewState();
}

class _CarPreviewState extends State<CarPreview> {
  late final PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          height: 300,
          child: Stack(
            children: [
              Positioned.fill(
                child: PageView.builder(
                  itemCount: widget.car?.images.length ?? 1,
                  controller: pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => SizedBox(
                    width: double.maxFinite,
                    child: widget.car == null
                        ? Image.asset(defaultImage, fit: BoxFit.cover)
                        : CachedNetworkImage(
                            imageUrl: widget.car!.images[index].imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: AppColors.surface,
                            ),
                            errorWidget: (context, url, error) =>
                                Image.asset(defaultImage, fit: BoxFit.cover),
                          ),
                  ),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.backgroundDark.withValues(alpha: 0),
                        AppColors.backgroundDark.withValues(alpha: 0.28),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 18,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundDark.withValues(alpha: 0.38),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AnimatedSmoothIndicator(
                      effect: const ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: AppColors.primary,
                        dotColor: AppColors.surface,
                      ),
                      onDotClicked: (index) {
                        pageController.jumpToPage(index);
                      },
                      activeIndex: pageIndex,
                      count: widget.car?.images.length ?? 1,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 0,
                bottom: 0,
                child: Center(
                  child: _PreviewArrowButton(
                    icon: IconBroken.Arrow___Left_2,
                    onPressed: () {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear,
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 12,
                child: Center(
                  child: _PreviewArrowButton(
                    icon: IconBroken.Arrow___Right_2,
                    onPressed: () {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreviewArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _PreviewArrowButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.backgroundDark.withValues(alpha: 0.38),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: AppColors.background,
        ),
      ),
    );
  }
}
