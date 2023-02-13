import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ozare/consts.dart';
import 'package:ozare/features/auth/view/auth_page.dart';
import 'package:ozare/translations/locale_keys.g.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthPage(),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: gradient,
              ),
            ),
            Image.asset(
              'assets/images/splash.png',
              height: size.height * 1.1,
              width: size.width * 1.1,
              fit: BoxFit.cover,
              color: Colors.white.withOpacity(0.05),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.width * 0.4,
                  width: size.width * 0.4,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: gradient,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF50ABEA).withGreen(180),
                        blurRadius: 12,
                        spreadRadius: 12,
                      )
                    ],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Animate(effects: const [
                      ShakeEffect(
                        duration: Duration(
                          milliseconds: 500,
                        ),
                        delay: Duration(milliseconds: 500),
                      )
                    ], child: Image.asset('assets/images/logo.png')),
                  ),
                ),
                const SizedBox(height: 32),
                const Text("Ozare",
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                Text(
                    LocaleKeys
                        .first_social_betting_platform_on_the_ton_blockchain
                        .tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
