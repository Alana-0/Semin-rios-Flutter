import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:puc_minas/app/core/constants/app_assests.dart';
import 'package:puc_minas/app/core/constants/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
//RENDERIZAÇÃO DA TELAtela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.haku)
                .animate(onComplete: (controller) => controller.repeat(reverse: true))
                .fade(begin: 0, end: 1, duration: 3.seconds)
                .flip(curve: Curves.elasticIn, begin: 2, end: 8, duration: 3.seconds),
            ElevatedButton(
              onPressed: () async {
                var sp = await SharedPreferences.getInstance();

                var result = sp.getString('cpf');
                if (result != null)
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
                else
                  Navigator.of(context).pushNamed(AppRoutes.login);
              },
              child: const Text('ENTRAR'),
            ).animate().scaleXY(
                  begin: 0,
                  end: 1.2,
                  duration: 2.seconds,
                )
          ],
        ),
      ),
    );
  }
}
