import 'package:flutter/material.dart';

import '../constants/app_radius.dart';
import '../constants/app_shadows.dart';
import '../constants/app_spacing.dart';

class AppCard extends StatelessWidget {
  final Widget child;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  final Color? color;

  final BorderRadius? borderRadius;

  final Border? border;

  final List<BoxShadow>? shadows;

  final double? width;
  final double? height;

  final VoidCallback? onTap;

  final Clip clipBehavior;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius,
    this.border,
    this.shadows,
    this.width,
    this.height,
    this.onTap,
    this.clipBehavior = Clip.antiAlias,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? AppRadius.lg;

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardColor,
        borderRadius: radius,
        border: border,
        boxShadow: shadows ?? AppShadows.small,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        clipBehavior: clipBehavior,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(
            padding: padding ?? AppSpacing.cardPadding,
            child: child,
          ),
        ),
      ),
    );
  }
}