import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'tractor_button.dart';
import 'tractor_text.dart';

class RetryWidget extends StatelessWidget {
  final VoidCallback onRetry;

  RetryWidget({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TractorText(
            text: 'Failed to load profile.',
            fontSize: 16.sp,
          ),
          TractorButton(
            onTap: onRetry,
            height: 30.h,
            width: 40.w,
            text: 'Retry',
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
