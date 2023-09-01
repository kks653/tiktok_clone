import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FlashModeButton extends StatelessWidget {
  const FlashModeButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.isSelected,
    required this.flashMode,
  });

  final bool isSelected;
  final FlashMode flashMode;

  final VoidCallback? onPressed;

  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: isSelected ? Colors.amber.shade100 : Colors.white,
      onPressed: onPressed,
      icon: icon,
    );
  }
}
