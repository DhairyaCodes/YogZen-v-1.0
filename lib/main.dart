import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogzen_v_1/components/nav_bar_scree.dart';
import 'package:yogzen_v_1/global/color.dart';
import 'package:yogzen_v_1/screens/camera/camera.dart';
import 'package:yogzen_v_1/screens/community/yog_guru.dart';
import 'package:yogzen_v_1/screens/home/home.dart';
import 'package:yogzen_v_1/screens/specific_needs/specific_needs.dart';
import 'package:yogzen_v_1/screens/welcome/welcome.dart';

List<CameraDescription>? cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YogZen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: kdarkBlue),
          fontFamily: GoogleFonts.outfit().fontFamily,
          useMaterial3: true,
          textTheme: TextTheme(
            displayLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: kblackHeading,
            ),
            headlineLarge: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: kblackHeading,
            ),
            headlineMedium: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kblackHeading,
            ),
          )),
      routes: {
        NavScreen.routeName: (context) => NavScreen(),
        YogGuru.routeName: (context) => YogGuru(),
        Camera.routeName: (context) => Camera(),
        SpecificNeeds.routeName :(context) => SpecificNeeds(),
      },
      home: WelcomeScreen(),
    );
  }
}
