import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// -----------------------------
// ✅ Reusable shimmer text widget
// -----------------------------

class ShimmerText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color color;

  const ShimmerText({
    super.key,
    required this.text,
    required this.style,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: color,
      highlightColor: _adjustHighlight(color),
      child: Text(
        text,
        style: style.copyWith(color: color),
        textAlign: TextAlign.center,
      ),
    );
  }

  Color _adjustHighlight(Color color) {
    return color.withAlpha(128); // 50% alpha
  }
}
