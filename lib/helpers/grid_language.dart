import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/language/language_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../middleware/middleware.dart';

class GridLanguage extends StatelessWidget {
  final isSmallScreen;

  final Middleware<bool, bool>? middleware;

  GridLanguage({
    required this.isSmallScreen,
    this.middleware,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(LanguageScreen(
          fromGrid: true,
        ));
      },
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: MyTheme.app_accent_color,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Center(
                child: Image.asset(
              'assets/icon/icon_white_lang.png',
              width: 16,
              height: 16,
            )
                // child: icon,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 90,
            child: Text('Language',
                style: isSmallScreen
                    ? Styles.regular_arsenic_11.copyWith()
                    : Styles.regular_arsenic_12,
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
