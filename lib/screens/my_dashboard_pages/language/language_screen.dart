import 'package:active_matrimonial_flutter_app/components/lang_holder.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/screens/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/common_app_bar.dart';
import '../../../const/const.dart';
import '../../../main.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key, required this.fromGrid});

  final bool fromGrid;

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  Locale _selectedLocale = const Locale('ta', ''); // Default to Tamil

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage(); // Load the saved language
  }

  // Load saved language from SharedPreferences
  Future<void> _loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('selectedLanguageCode');
    if (languageCode != null) {
      setState(() {
        _selectedLocale = Locale(languageCode);
      });
    }
  }

  // Change language, store the selected language in SharedPreferences,
  // refresh the UI, and go back to the previous screen
  Future<void> _changeLanguage() async {
    // Update the app locale
    MyApp.of(context)?.setLocale(_selectedLocale);

    // Store selected language in SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedLanguageCode', _selectedLocale.languageCode);

    // Navigate back to the previous screen
    Navigator.pop(context, true); // Pass `true` to signal a refresh
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        text: AppLocalizations.of(context)!.public_profile_Lang,
      ).build(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Const.kPaddingHorizontal, vertical: 10),
          child: Column(
            children: [
              // Tamil Button
              LangHolder(
                ontap: () {
                  setState(() {
                    _selectedLocale = const Locale('ta', '');
                  });
                },
                label: 'Tamil (IN)',
                image: 'assets/images/indian_flag.png',
                isSelected: _selectedLocale.languageCode == 'ta',
              ),
              const SizedBox(height: 20),
              // English Button
              LangHolder(
                ontap: () {
                  setState(() {
                    _selectedLocale = const Locale('en', '');
                  });
                },
                label: 'English (US)',
                image: 'assets/images/us_flag.jpeg',
                isSelected: _selectedLocale.languageCode == 'en',
              ),
              const Spacer(),
              // Confirm Button
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    await _changeLanguage();
                    if (widget.fromGrid) {
                      // Navigator.of(context).pop();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => AppNavigation(),
                      //   ),
                      // );
                    } else {
                      // Otherwise, navigate to AppNavigation screen
                      // SharedPreferences prefs =
                      //     await SharedPreferences.getInstance();
                      // await prefs.setBool('isFirstTime', false);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppNavigation(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    backgroundColor: app_accent_color,
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.change_language,
                      style: Styles.bold_white_16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
