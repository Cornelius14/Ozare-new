import 'package:flutter/material.dart';
import 'package:ozare/features/dash/bloc/dash_bloc.dart';
import 'package:ozare/features/home/view/home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/features/profile/bloc/profile_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context
        .read<DashBloc>()
        .add(const DashLeaguesRequested(DashCategory.soccer));
    context.read<ProfileBloc>()
      ..add(const ProfileHistoryRequested())
      ..add(const ProfileNotificationsRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}
