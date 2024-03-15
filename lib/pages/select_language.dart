import 'package:chat_application/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

const List<Map<String, String>> _languages = [
  {"label": 'e n g l i s h', "value": "en"},
  {"label": 'р у с с к и й', "value": "ru"},
  {"label": 'հ ա յ ե ր ե ն', "value": "hy"},
];

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({
    super.key,
  });

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  String? _selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(LocaleKeys.Change_Language.tr()),
      ),
      body: ListView.builder(
        itemCount: _languages.length,
        itemBuilder: (context, index) {
          final language = _languages[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedLanguage = language["value"];
                });
                switch (language["value"]) {
                  case "en":
                    context.setLocale(const Locale('en'));
                    break;
                  case "ru":
                    context.setLocale(const Locale('ru'));
                    break;
                  case "hy":
                    context.setLocale(const Locale('hy'));
                    break;
                  default:
                    context.setLocale(const Locale('en'));
                    break;
                }
              },
              child: Column(
                children: [
                  const Gap(15),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.transparent,
                    ),
                    child: Row(
                      children: [
                        Text(
                          language["label"]!.toUpperCase(),
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                          ),
                        ),
                        if (_selectedLanguage == language["value"]) ...[
                          const Spacer(),
                          const Icon(Icons.check, color: Colors.green),
                        ],
                      ],
                    ),
                  ),
                  if (index < _languages.length - 1) ...[
                    const Gap(15),
                    const Divider(),
                    const Gap(15),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
