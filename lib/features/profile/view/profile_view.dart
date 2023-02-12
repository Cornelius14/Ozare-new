import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ozare/common/widgets/widgets.dart';
import 'package:ozare/features/profile/bloc/profile_bloc.dart';
import 'package:ozare/features/profile/widgets/widgets.dart';
import 'package:ozare/models/ouser.dart';
import 'package:ozare/translations/locale_keys.g.dart';

import 'view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    super.key,
    required this.ouser,
    required this.page,
    required this.state,
  });

  final PPage page;
  final OUser ouser;
  final ProfileState state;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarProfileSection(
          page: widget.page,
        ),

        // Name
        if (widget.page != PPage.editAccount) ...[
          Text(
            '${widget.ouser.firstName} ${widget.ouser.lastName}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 24),
        ],

        /// wins and losses
        if (widget.page != PPage.editAccount) ...[
          const WinOrLosses(
            wins: 200,
            losses: 32,
          ),
          const SizedBox(height: 24),
        ],

        /// Notifications
        /// For Notifications Page Only
        if (widget.page == PPage.notifications) ...[
          Heading(heading: LocaleKeys.notifications.tr()),
          const SizedBox(height: 8),
          Expanded(
              child: widget.state.notifications.isEmpty
                  ? const Center(child: Text('No Notifications'))
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 64),
                      itemCount: widget.state.notifications.length,
                      itemBuilder: (context, index) {
                        return NotificationTile(
                          notification: widget.state.notifications[index],
                        );
                      })),
        ],

        /// Edit Account
        /// For Edit account Page Only
        if (widget.page == PPage.editAccount)
          EditAccountView(oUser: widget.ouser),

        /// Personal Info
        /// For Settings Page Only
        if (widget.page == PPage.settings) const SettingsView(),

        /// Recent History
        /// for Profile Page only
        if (widget.page == PPage.profile) ...[
          Heading(heading: LocaleKeys.recent_history.tr()),
          const SizedBox(height: 8),
          Expanded(
              child: widget.state.history.isEmpty
                  ? const Center(child: Text('No History'))
                  : ListView.builder(
                      padding: const EdgeInsets.only(
                          bottom: 64, left: 24, right: 24),
                      itemCount: widget.state.history.length,
                      itemBuilder: (context, index) {
                        return HistoryItem(
                          history: widget.state.history[index],
                        );
                      })),
        ]
      ],
    );
  }
}
