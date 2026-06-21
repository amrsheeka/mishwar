import 'package:flutter/material.dart';

extension Responsive on BuildContext {
  bool get isMobile => MediaQuery.sizeOf(this).width < 600;
  bool get isTablet =>
      MediaQuery.sizeOf(this).width >= 600 &&
      MediaQuery.sizeOf(this).width < 1024;
  bool get isDesktop => MediaQuery.sizeOf(this).width >= 1024;
}