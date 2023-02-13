import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/maki_icons.dart';
import 'package:ozare/features/dash/bloc/dash_bloc.dart';
import 'package:ozare/features/dash/widgets/widgets.dart';
import 'package:ozare/models/league.dart';
import 'package:ozare/translations/locale_keys.g.dart';

class DashView extends StatefulWidget {
  const DashView({
    super.key,
  });

  @override
  State<DashView> createState() => _DashViewState();
}

class _DashViewState extends State<DashView> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///// APP BAR /////

        const UpperSection(),

        /// Match Categories
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              MatchCategoryTabItem(
                isActive: selectedTab == 0,
                label: LocaleKeys.soccer.tr(),
                onTap: () {
                  if (selectedTab != 0) {
                    context
                        .read<DashBloc>()
                        .add(const DashCategoryChanged(DashCategory.soccer));
                    setState(() {
                      selectedTab = 0;
                    });
                  }
                },
                icon: FontAwesome5.futbol,
              ),
              MatchCategoryTabItem(
                isActive: selectedTab == 1,
                label: LocaleKeys.basketball.tr(),
                onTap: () {
                  if (selectedTab != 1) {
                    context.read<DashBloc>().add(
                        const DashCategoryChanged(DashCategory.basketball));
                    setState(() {
                      selectedTab = 1;
                    });
                  }
                },
                icon: FontAwesome5.basketball_ball,
              ),
              MatchCategoryTabItem(
                isActive: selectedTab == 2,
                label: LocaleKeys.cricket.tr(),
                onTap: () {
                  // setState(() {
                  //   selectedTab = 2;
                  // });
                },
                icon: Maki.cricket,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        /// MATCHES LISTS \\
        BlocConsumer<DashBloc, DashState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is DashLoading) {
              return const LoadingSection();
            } else if (state is DashFailure) {
              return Center(
                child: Text(state.message),
              );
            }
            final List<League> leagues = state.leagues;
            log('Leagues Length: ${leagues.length.toString()}');
            if (leagues.isEmpty) {
              return const NoEventsTile();
            }
            // tpo
            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 32),
                itemCount: leagues.length,
                itemBuilder: (context, index) {
                  final League league = leagues[index];
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: LeagueSection(league: league));
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
