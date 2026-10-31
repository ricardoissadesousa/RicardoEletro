import 'package:flutter/material.dart';

import '../../core/app_theme.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: compact ? 34 : 42,
          height: compact ? 34 : 42,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.orange, Color(0xFFFF9A3D)],
            ),
            borderRadius: BorderRadius.circular(compact ? 10 : 13),
          ),
          child: Icon(
            Icons.bolt_rounded,
            color: Colors.white,
            size: compact ? 23 : 29,
          ),
        ),
        const SizedBox(width: 9),
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: AppColors.navy,
              fontSize: compact ? 20 : 25,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.8,
            ),
            children: const [
              TextSpan(text: 'Ricardo'),
              TextSpan(
                text: 'ELetro',
                style: TextStyle(color: AppColors.orange),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
