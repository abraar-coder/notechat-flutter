import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:note_chat/core/theme/app_spacing.dart';

// -----------------------------
// ✅ Reusable shimmer icon widget
// -----------------------------

class ShimmerIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;

  const ShimmerIcon({
    super.key,
    required this.icon,
    this.size = 70,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: color,
      highlightColor: _adjustHighlight(color),
      child: Container(
        padding: AppSpacing.screen,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withAlpha(25),
        ),
        child: Icon(
          icon,
          size: size,
          color: color,
        ),
      ),
    );
  }

  Color _adjustHighlight(Color color) {
    return color.withAlpha(128); // 50% alpha
  }
}
