import 'package:flutter/material.dart';
import 'package:yogzen_v_1/screens/community/studio_widget.dart';
class YogaStudio extends StatelessWidget {
static const routeName = "/yogaStudio";
  const YogaStudio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YogaClassesCard(),
    );
  }
}