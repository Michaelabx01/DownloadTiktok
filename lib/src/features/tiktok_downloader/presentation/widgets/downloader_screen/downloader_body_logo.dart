import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';

class DownloaderBodyLogo extends StatelessWidget {
  const DownloaderBodyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(.1),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Lottie.asset(
        AppAssets.tikTokLogo,
        width: 300,
        height: 300,
      ),
    );
  }
}