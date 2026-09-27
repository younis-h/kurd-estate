import 'package:flutter/widgets.dart';

abstract final class AppRadius {
  static const BorderRadius xs =
      BorderRadius.all(Radius.circular(4));

  static const BorderRadius sm =
      BorderRadius.all(Radius.circular(8));

  static const BorderRadius md =
      BorderRadius.all(Radius.circular(12));

  static const BorderRadius lg =
      BorderRadius.all(Radius.circular(16));

  static const BorderRadius xl =
      BorderRadius.all(Radius.circular(24));

  static const BorderRadius pill =
      BorderRadius.all(Radius.circular(999));
}