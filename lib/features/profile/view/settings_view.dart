import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ozare/common/widgets/widgets.dart';
import 'package:ozare/features/profile/widgets/widgets.dart';
import 'package:ozare/translations/locale_keys.g.dart';

import 'language_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Heading(heading: LocaleKeys.personal_info.tr()),
          const SizedBox(height: 8),
          OptionsBox(children: [
            ProfileTile(
              label: LocaleKeys.wallet.tr(),
              icon: Icons.account_balance_wallet_outlined,
              onTap: () {},
            ),
            ProfileTile(
              label: LocaleKeys.statistics.tr(),
              icon: Icons.bar_chart_outlined,
              onTap: () {},
            ),
          ]),
          const SizedBox(height: 24),
          Heading(heading: LocaleKeys.settings.tr()),
          const SizedBox(height: 8),
          OptionsBox(children: [
            ProfileTile(
              label: LocaleKeys.notifications.tr(),
              icon: Icons.notifications_active_outlined,
              onTap: () {},
            ),
            ProfileTile(
              label: LocaleKeys.preferences.tr(),
              icon: Icons.settings_outlined,
              onTap: () {},
            ),
            ProfileTile(
              label: LocaleKeys.languages.tr(),
              icon: Icons.language_outlined,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LanguageView()));
              },
            ),
            ProfileTile(
              label: LocaleKeys.log_out.tr(),
              icon: Icons.logout_outlined,
              onTap: () {},
            ),
          ]),
          const SizedBox(height: 24),
          Heading(heading: LocaleKeys.support.tr()),
          const SizedBox(height: 8),
          OptionsBox(children: [
            ProfileTile(
              label: LocaleKeys.get_help.tr(),
              icon: Icons.help_outline,
              onTap: () {},
            ),
            ProfileTile(
              label: LocaleKeys.faq.tr(),
              icon: Icons.question_answer_outlined,
              onTap: () {},
            ),
          ]),
          const SizedBox(height: 72),
        ],
      ),
    ));
  }
}
