import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ozare/consts.dart';
import 'package:ozare/features/dash/view/dash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/features/home/home.dart';
import 'package:ozare/features/profile/view/view.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ozare/translations/locale_keys.g.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab =
        context.select((HomeCubit cubit) => cubit.state.tabIndex);
    final hideStatus = context.select((HomeCubit cubit) => cubit.state.hide);
    final size = MediaQuery.of(context).size;
    final showBetButton = selectedTab == 0 && !hideStatus;
    // log('showBetButton: ${showBetButton.toString()}');
    // log('selected Tab: ${selectedTab.toString()}');
    // log('hideStatus: ${hideStatus.toString()}');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton:
          // showBetButton
          //     ?
          Container(
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
          gradient: gradient,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            FontAwesome.award,
            color: Colors.white,
          ),
        ),
      )
      // : null
      ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: !hideStatus
          ? BottomAppBar(
              shape: const CircularNotchedRectangle(),
              child: SizedBox(
                height: 68,
                width: size.width,
                child: Row(children: [
                  BottomNavItem(
                    label: LocaleKeys.home.tr(),
                    iconPath: 'assets/icons/home.svg',
                    isActive: selectedTab == 0,
                    onTap: () {
                      context.read<HomeCubit>().setTab(0);
                    },
                  ),
                  BottomNavItem(
                    label: LocaleKeys.wallets.tr(),
                    iconPath: 'assets/icons/wallet.svg',
                    isActive: selectedTab == 1,
                    onTap: () {
                      context.read<HomeCubit>().setTab(1);
                    },
                  ),
                  const Spacer(),
                  BottomNavItem(
                    label: LocaleKeys.notifications.tr(),
                    iconPath: 'assets/icons/bell.svg',
                    isActive: selectedTab == 2,
                    onTap: () {
                      context.read<HomeCubit>().setTab(2);
                    },
                  ),
                  BottomNavItem(
                    label: LocaleKeys.profile.tr(),
                    iconPath: 'assets/images/user.png',
                    isActive: selectedTab == 3,
                    isProfile: true,
                    onTap: () {
                      context.read<HomeCubit>().setTab(3);
                    },
                  ),
                ]),
              ),
            )
          : null,
      body: IndexedStack(
        index: selectedTab,
        children: const [
          DashPage(),
          PaymentsPage(),
          NotificationsPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    super.key,
    required this.label,
    required this.iconPath,
    required this.isActive,
    required this.onTap,
    this.isProfile = false,
  });

  final String label;
  final String iconPath;
  final bool isActive;
  final bool isProfile;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: isProfile
            ?
            // Profile Nav Item
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DottedBorder(
                    borderType: BorderType.Circle,
                    color: isActive ? primary1Color : Colors.grey,
                    child: CircleAvatar(
                      radius: 13,
                      backgroundImage: AssetImage(iconPath),
                    ),
                  ),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                      color: isActive ? primary1Color : Colors.grey,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              )
            :
            // Default Nav Item
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    iconPath,
                    color: isActive ? primary1Color : Colors.grey,
                    height: 28,
                  ),
                  const SizedBox(height: 4),
                  AutoSizeText(
                    label,
                    textAlign: TextAlign.center,
                    maxFontSize: 11,
                    minFontSize: 8,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: isActive ? primary1Color : Colors.grey,
                      letterSpacing: 0.2,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
      ),
    );
  }
}
