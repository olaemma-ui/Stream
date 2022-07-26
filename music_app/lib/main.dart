import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:music_app/View/AllMusic.dart';

void main() {
  runApp(const Route());
}

class Route extends StatelessWidget {
  const Route({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetMaterialApp(
      initialRoute: "/AllMusic",

      routes: {
        "/AllMusic":(context) => AllMusic()
      },
    );
  }
}
