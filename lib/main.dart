import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/providers/movie_provider.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/screen/navigator/main_menu.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/theme.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/utils/text_plus_jakarta_sans.dart';

void main() async {
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
      ],
      child: const MaterialApp(
        title: 'TMBD',
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    String? username = await const FlutterSecureStorage().read(key: "username");

    Future.delayed(const Duration(seconds: 2), () {
      if (username == "" || username == null || username.isEmpty) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const MainMenu(id: 0)),
            (Route<dynamic> route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const MainMenu(id: 0)),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  void initState() {
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget logo() {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              'assets/png/logo.png',
              width: 96,
              fit: BoxFit.cover,
            ),
            JakartaSans.custom(
                text: 'TMDB',
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: black),
            const Spacer(),
            Image.asset(
              'assets/png/logo_tiketux.png',
              width: 64,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 24),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: logo(),
    );
  }
}
