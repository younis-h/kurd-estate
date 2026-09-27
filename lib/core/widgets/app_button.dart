import 'package:flutter/material.dart';

enum AppButtonType {
  filled,
  outlined,
  text,
}

enum AppButtonSize {
  small,
  medium,
  large,
}

class AppButton extends StatelessWidget {
  final String? text;
  final Widget? child;

  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  const AppButton({
    super.key,
    this.text,
    this.child,
    required this.onPressed,
    this.type = AppButtonType.filled,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = true,
    this.leadingIcon,
    this.trailingIcon,
  }) : assert(
          text != null || child != null,
          'Either text or child must be provided.',
        );

  double get _height {
    switch (size) {
      case AppButtonSize.small:
        return 40;
      case AppButtonSize.medium:
        return 52;
      case AppButtonSize.large:
        return 60;
    }
  }

  Widget _buildContent() {
    if (isLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }

    if (child != null) {
      return child!;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leadingIcon != null) ...[
          Icon(
            leadingIcon,
            size: 20,
          ),
          const SizedBox(width: 8),
        ],
        Text(text!),
        if (trailingIcon != null) ...[
          const SizedBox(width: 8),
          Icon(
            trailingIcon,
            size: 20,
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);
    final content = _buildContent();

    Widget button;

    switch (type) {
      case AppButtonType.filled:
        button = FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            minimumSize: Size(
              isFullWidth ? double.infinity : 0,
              _height,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
          ),
          child: content,
        );
        break;

      case AppButtonType.outlined:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            minimumSize: Size(
              isFullWidth ? double.infinity : 0,
              _height,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
          ),
          child: content,
        );
        break;

      case AppButtonType.text:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            minimumSize: Size(
              isFullWidth ? double.infinity : 0,
              _height,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
          ),
          child: content,
        );
        break;
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: button,
    );
  }
}