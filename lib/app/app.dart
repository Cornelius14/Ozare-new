import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:ozare/features/auth/bloc/auth_bloc.dart';
import 'package:ozare/features/auth/repository/auth_repository.dart';
import 'package:ozare/features/auth/repository/local_db_repository.dart';
import 'package:ozare/features/dash/bloc/dash_bloc.dart';
import 'package:ozare/features/dash/repository/dash_repository.dart';
import 'package:ozare/features/event/bloc/event_bloc.dart';
import 'package:ozare/features/event/repository/event_repository.dart';
import 'package:ozare/features/home/cubit/home_cubit.dart';
import 'package:ozare/features/profile/bloc/profile_bloc.dart';
import 'package:ozare/features/profile/repository/profile_repository.dart';
import 'package:ozare/features/search/bloc/search_bloc.dart';
import 'package:ozare/features/search/repo/search_repo.dart';
import 'package:ozare/features/splash/view/splash_page.dart';
import 'package:ozare/main.dart';
import 'package:easy_localization/easy_localization.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// Auth Bloc
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authRepository: getIt<AuthRepository>(),
            localDBRepository: getIt<LocalDBRepository>(),
          )..add(const AuthCheckRequested()),
        ),

        /// Home Cubit
        BlocProvider<HomeCubit>(create: (context) => HomeCubit()),

        /// Dash Bloc
        BlocProvider<DashBloc>(
            create: (context) => DashBloc(
                  dashRepository: getIt<DashRepository>(),
                )),

        /// Profile Bloc
        BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
                  profileRepository: getIt<ProfileRepository>(),
                )),

        /// Event Bloc
        BlocProvider<EventBloc>(
            create: (context) => EventBloc(
                  eventRepository: getIt<EventRepository>(),
                )),

        // Search Bloc
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(repo: getIt<SearchRepo>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        title: 'Ozare',
        home: const SplashPage(),
      ),
    );
  }
}
