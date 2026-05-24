import 'package:flutter/material.dart';

enum PageTransitionType { fade, slide, scale, rotation }

Route _route(Widget page, PageTransitionType type) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (type) {
        case PageTransitionType.fade:
          return FadeTransition(opacity: animation, child: child);

        case PageTransitionType.scale:
          return ScaleTransition(scale: animation, child: child);

        case PageTransitionType.rotation:
          return RotationTransition(turns: animation, child: child);

        case PageTransitionType.slide:
        default:
          const begin = Offset(1, 0);
          const end = Offset.zero;

          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: Curves.easeInOut));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
      }
    },
  );
}

void navigateTo({
  required BuildContext context,
  required Widget page,
  PageTransitionType type = PageTransitionType.slide,
}) {
  Navigator.push(context, _route(page, type));
}

void navigateAndFinish({
  required BuildContext context,
  required Widget page,
  PageTransitionType type = PageTransitionType.slide,
}) {
  Navigator.pushAndRemoveUntil(context, _route(page, type), (route) => false);
}
