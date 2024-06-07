
import 'package:flutter/material.dart';
import 'package:random_quote_generator/ui/utils/font_weights.dart';

import 'app_colors.dart';

abstract class AppTheme {
static TextStyle font18WhiteRegular = const TextStyle(
  fontSize: 18,
  color: AppColors.white,
  fontWeight: FontWeights.regular
);

static TextStyle font18BlackRegular = const TextStyle(
    fontSize: 18,
    color: AppColors.black,
    fontWeight: FontWeights.regular
);

static TextStyle font20WhiteBold = const TextStyle(
    fontSize: 20,
    color: AppColors.white,
    fontWeight: FontWeights.bold
);

static TextStyle font17WhiteBold = const TextStyle(
    fontSize: 17,
    color: Colors.white54,
    fontWeight: FontWeights.bold
);
}