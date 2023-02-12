import 'package:easy_localization/easy_localization.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:ozare/consts.dart';
import 'package:ozare/translations/locale_keys.g.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  Locale get selectedLocale => context.locale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Select Language',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Phoenix.rebirth(context);
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(children: [
          LanguageTile(
            label: LocaleKeys.english.tr(),
            code: FlagsCode.US,
            isActive: selectedLocale.languageCode == 'en',
            onTap: () {
              context.setLocale(const Locale('en'));
            },
          ),
          LanguageTile(
            label: LocaleKeys.russian.tr(),
            code: FlagsCode.RU,
            isActive: selectedLocale.languageCode == 'ru',
            onTap: () {
              context.setLocale(const Locale('ru'));
            },
          ),
          LanguageTile(
            label: LocaleKeys.hindi.tr(),
            code: FlagsCode.IN,
            isActive: selectedLocale.languageCode == 'hi',
            onTap: () {
              context.setLocale(const Locale('hi'));
            },
          ),
          LanguageTile(
            label: LocaleKeys.german.tr(),
            code: FlagsCode.DE,
            isActive: selectedLocale.languageCode == 'de',
            onTap: () {
              context.setLocale(const Locale('de'));
            },
          ),
          LanguageTile(
            label: LocaleKeys.portuguese.tr(),
            code: FlagsCode.BR,
            isActive: selectedLocale.languageCode == 'pt',
            onTap: () {
              context.setLocale(const Locale('pt'));
            },
          ),
          LanguageTile(
            label: LocaleKeys.indonesian.tr(),
            code: FlagsCode.ID,
            isActive: selectedLocale.languageCode == 'id',
            onTap: () {
              context.setLocale(const Locale('id'));
            },
          ),
        ]),
      ),
    );
  }
}

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    super.key,
    required this.onTap,
    required this.label,
    required this.code,
    required this.isActive,
  });

  final VoidCallback onTap;
  final String label;
  final FlagsCode code;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: isActive ? 12 : 6),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isActive ? Colors.grey[200] : null,
        ),
        child: Row(children: [
          Flag.fromCode(code, height: 24, width: 24),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
          const Spacer(),
          if (isActive)
            const Icon(
              Icons.check,
              size: 18,
              color: primary2Color,
            ),
        ]),
      ),
    );
  }
}
