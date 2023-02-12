import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/common/widgets/widgets.dart';
import 'package:ozare/features/profile/bloc/profile_bloc.dart';
import 'package:ozare/features/profile/view/profile_view.dart';
import 'package:ozare/models/ouser.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        final ProfileStatus status = state.status;
        log('ProfilePage: status: $status');
        if (status == ProfileStatus.loading) {
          return const Loader(message: 'Loading...');
        } else if (status == ProfileStatus.failure) {
          return const Center(child: Text('Something went wrong'));
        } else if (status == ProfileStatus.loaded) {
          final OUser ouser = state.user!;
          final PPage page = state.page;
          log('ProfilePage: page: $page');

          ///
          switch (page) {
            case PPage.profile:
              return ProfileView(ouser: ouser, page: page, state: state);

            case PPage.settings:
              return ProfileView(ouser: ouser, page: page, state: state);

            case PPage.editAccount:
              return ProfileView(ouser: ouser, page: page, state: state);

            case PPage.notifications:
              return ProfileView(ouser: ouser, page: page, state: state);

            case PPage.wallet:
              return ProfileView(ouser: ouser, page: page, state: state);

            case PPage.selectLanguage:
              return ProfileView(ouser: ouser, page: page, state: state);
          }
        }
        return const Loader(message: 'Loading...');
      },
    );
  }
}
