import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/core/models/car.dart';
import 'package:mishwar/core/styles/app_colors.dart';
import 'package:mishwar/core/styles/icon_broken.dart';
import 'package:mishwar/core/utils/contants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarPreview extends StatefulWidget {
  final Car? car;
  const CarPreview({super.key,this.car});

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
    return Stack(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            itemCount:  widget.car?.images.length ?? 1,
            controller: pageController,
            physics: BouncingScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            itemBuilder: (context, index) => SizedBox(
              height: 200,
              width: double.maxFinite,
              child: widget.car == null
                  ? Image.asset(defaultImage)
                  : CachedNetworkImage(imageUrl: widget.car!.images[index].imageUrl),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Center(
            child: AnimatedSmoothIndicator(
              effect: ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: AppColors.primary,
              ),
              onDotClicked: (index) {
                pageController.jumpToPage(index);
              },
              activeIndex: pageIndex,
              count: widget.car?.images.length ?? 1,
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          child: IconButton(
            onPressed: () {
              pageController.previousPage(
                duration: Duration(milliseconds: 200),
                curve: Curves.linear,
              );
            },
            icon: Icon(IconBroken.Arrow___Left_2),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          child: IconButton(
            onPressed: () {
              pageController.nextPage(
                duration: Duration(milliseconds: 200),
                curve: Curves.linear,
              );
            },
            icon: Icon(IconBroken.Arrow___Right_2),
          ),
        ),
      ],
    );
  }
}
