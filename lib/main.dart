import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';
import 'package:ozare/app/app.dart';
import 'package:ozare/features/chat/repository/chat_repository.dart';
import 'package:ozare/features/dash/repository/dash_repository.dart';
import 'package:ozare/features/event/repository/event_repository.dart';
import 'package:ozare/features/profile/repository/profile_repository.dart';
import 'package:ozare/features/search/repo/search_repo.dart';
import 'package:ozare/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'features/auth/repository/repository.dart';
import 'features/bet/repository/bet_repository.dart';

final getIt = GetIt.instance;

void main() async {
  // Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();
  // Initalize Firebase App
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();

  await setupDependencies();

  // Bloc.observer = AppBlocObserver();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
        Locale('hi'),
        Locale('de'),
        Locale('pt'),
        Locale('id'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: Phoenix(child: const App()),
    ),
  );
}

Future<void> setupDependencies() async {
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  getIt.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  getIt.registerSingleton<AuthRepository>(AuthRepository(
      firebaseAuth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance));

  getIt.registerSingleton<LocalDBRepository>(
      LocalDBRepository(sharedPreferences: getIt<SharedPreferences>()));

  getIt.registerSingleton<ProfileRepository>(
      ProfileRepository(firestore: getIt<FirebaseFirestore>()));

  getIt.registerSingleton<DashRepository>(DashRepository());

  getIt.registerSingleton<EventRepository>(
      EventRepository(firestore: getIt<FirebaseFirestore>()));

  getIt.registerSingleton<ChatRepository>(
      ChatRepository(firestore: getIt<FirebaseFirestore>()));

  getIt.registerSingleton<BetRepository>(
      BetRepository(firestore: getIt<FirebaseFirestore>()));

  getIt.registerSingleton<SearchRepo>(SearchRepo());
}
