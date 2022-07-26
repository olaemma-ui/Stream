import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Widget/CustomWidget.dart';

class AllMusic extends StatefulWidget {
  const AllMusic({Key? key}) : super(key: key);

  @override
  State<AllMusic> createState() => _AllMusicState();
}

class _AllMusicState extends State<AllMusic> {
  GlobalKey key = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  bool play = true;
  double volume = 0;
  void action() {}
  CustomWidget customWidget = CustomWidget();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customWidget.appBackground(
          appBar: AppBar(),
          context: context,
          backgroundImage:
              "https://th.bing.com/th/id/R.af2575a2a68e7b67c6e16a36567ca37a?rik=pWb5EHooK3cOSQ&pid=ImgRaw&r=0",
          body: customWidget.responsiveSearchBar(
              controller: controller,
              context: context,
              action: () {
                action();
              })),
    );
  }
}


// gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomCenter,
//                 colors: (mode == "dark")
//                     ? const <Color>[
//                         Color.fromARGB(255, 2, 51, 85),
//                         Color.fromARGB(255, 57, 10, 33),
//                         Color.fromARGB(255, 27, 2, 14),
//                         Color.fromARGB(255, 1, 24, 49),
//                         Color.fromARGB(255, 57, 10, 33),
//                       ]
//                     : const <Color>[
//                         Color.fromARGB(255, 158, 38, 96),
//                         Color.fromARGB(255, 222, 159, 190),
//                         Color.fromARGB(255, 104, 148, 196),
//                         Color.fromARGB(255, 203, 129, 165),
//                       ])),