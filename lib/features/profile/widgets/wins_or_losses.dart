import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ozare/translations/locale_keys.g.dart';

import 'stat_box.dart';

class WinOrLosses extends StatelessWidget {
  const WinOrLosses({
    super.key,
    required this.wins,
    required this.losses,
  });

  final int wins;
  final int losses;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StatBox(
          label: LocaleKeys.wins.tr(),
          value: wins,
        ),
        const SizedBox(width: 16),
        StatBox(
          label: LocaleKeys.loss.tr(),
          value: losses,
        ),
      ],
    );
  }
}
