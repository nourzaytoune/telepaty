import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism/general/provider.dart';
import 'package:tourism/generated/l10n.dart';

class LanguageSettingsScreen extends StatefulWidget {
  @override
  _LanguageSettingsScreenState createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  String _selectedLanguage = 'English';
  final List<String> _languages = ['English', 'Español', '中文', 'Français', 'Deutsch'];
  final Map<String, Locale> _localeMap = {
    'English': Locale('en'),
    'Español': Locale('es'),
    '中文': Locale('zh'),
    'Français': Locale('fr'),
    'Deutsch': Locale('de'),
  };

  @override
  Widget build(BuildContext context) {
    final localeNotifier = Provider.of<LocaleNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).language_settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).select_language,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _languages.length,
                itemBuilder: (context, index) {
                  final language = _languages[index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedLanguage = language;
                        S.load(_localeMap[language]!);
                        localeNotifier.setLocale(_localeMap[language]!);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(language),
                          if (_selectedLanguage == language)
                            Icon(
                              Icons.check,
                              color: Theme.of(context).primaryColor,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

