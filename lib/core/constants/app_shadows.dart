import 'package:flutter/material.dart';

abstract final class AppShadows {
  static const List<BoxShadow> small = [
    BoxShadow(
      blurRadius: 6,
      offset: Offset(0, 2),
      color: Colors.black12,
    ),
  ];

  static const List<BoxShadow> medium = [
    BoxShadow(
      blurRadius: 12,
      offset: Offset(0, 4),
      color: Colors.black12,
    ),
  ];

  static const List<BoxShadow> large = [
    BoxShadow(
      blurRadius: 20,
      offset: Offset(0, 8),
      color: Colors.black26,
    ),
  ];
}