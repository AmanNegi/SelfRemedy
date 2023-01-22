import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_remedy/helpers/shared_prefs.dart';
import 'package:self_remedy/models/appdata.dart';
import 'package:self_remedy/pages/auth/signup_page.dart';
import 'package:self_remedy/pages/home_page.dart';
import 'package:self_remedy/pages/welcome_page.dart';
import './helpers/api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  apiHelper.initConnection();
  await sharedPrefsHelper.init();
  await sharedPrefsHelper.getUser();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: ValueListenableBuilder<AppData>(
        valueListenable: appdata,
        builder: (context, value, child) {
          return value.isFirstTime
              ? const WelcomePage()
              : value.isLoggedIn
                  ? const HomePage()
                  : const SignUpPage();
        },
      ),

      // home: const SignUpPage(),
    );
  }
}
