import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ScanningAnimation extends StatelessWidget {
  const ScanningAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.document_scanner_rounded,
                  size: 50,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(
                duration: 1500.ms,
                color: Theme.of(context).colorScheme.secondary,
              )
              .scaleXY(
                begin: 1.0,
                end: 1.1,
                duration: 1000.ms,
                curve: Curves.easeInOut,
              )
              .then()
              .scaleXY(
                begin: 1.1,
                end: 1.0,
                duration: 1000.ms,
                curve: Curves.easeInOut,
              ),
          const SizedBox(height: 20),
          Text(
                'جاري تحليل الروشتة...',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .fadeIn(duration: 800.ms)
              .then(delay: 800.ms)
              .fadeOut(duration: 800.ms),
        ],
      ),
    );
  }
}
