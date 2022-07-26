import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:music_app/resources/Global.dart';

class CustomWidget {
  ///TODO: Single music cover
  Widget albumCard({
    required String url,
    required Icon icon,
    required BuildContext context,
    double width = 100,
    double height = 300,
    double playBtnWidth = 50,
    double playBtnHeight = 50,
    double maxWidth = 20,
    double maxHeight = 30,
  }) {
    width = ((MediaQuery.of(context).size.width / 100) * width < maxWidth)
        ? (MediaQuery.of(context).size.width / 100) * width
        : maxWidth;
    height = ((MediaQuery.of(context).size.height / 100) * height < maxHeight)
        ? (MediaQuery.of(context).size.height / 100) * height
        : maxHeight;

    return Container(
      padding: const EdgeInsets.all(16),
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: BorderRadius.circular(1000),
            color: const Color.fromARGB(82, 255, 255, 255),
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () {
                print("hola");
              },
              child: SizedBox(
                width: playBtnWidth,
                height: playBtnHeight,
                child: icon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //TODO:Music Cover

  Widget musicCard(
      {required String title,
      required String artist,
      required String url,
      required BuildContext context,
      required double radius,
      double titleSize = 2,
      double artistSize = 2,
      double width = 40,
      double height = 40,
      double maxWidth = 50,
      double maxHeight = 80}) {
    Size size = MediaQuery.of(context).size;

    height = (((size.height / 100) * height) < maxHeight)
        ? ((size.height / 100) * height) - 50
        : ((size.height / 100) * height) / 2.5;
    width = height;

    radius = ((size.width / 100) * radius);

    titleSize = titleSize * ((size.height) / 100) + 5;

    artistSize = artistSize * ((size.height) / 100) + 5;

    return Ink(
      width: width,
      child: Column(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(url))),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            artist,
            style: TextStyle(
              fontSize: artistSize,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            maxLines: 2,
          )
        ],
      ),
    );
  }

  //Todo: Music list
  Widget musicList({
    required String title,
    required String artist,
    required String min,
    required Icon leadingIcon,
    required String url,
    required Icon suffixIcon,
    required Function leadingAction,
    required Function suffixAction,
    required int count,
    required BuildContext context,
    required bool play,
    required Color bgColor,
    Color txtColor = Colors.black,
    double titleSize = 2,
    double artistSize = 2,
    double width = 10,
    double height = 10,
    double playSize = 4,
  }) {
    Size size = MediaQuery.of(context).size;

    double devSize = (size.height + size.width) / 100;

    GlobalKey containerKey = GlobalKey();
    return Container(
        key: containerKey,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Color.fromARGB(149, 37, 35, 35),
                  spreadRadius: 0,
                  blurRadius: 0,
                  blurStyle: BlurStyle.inner)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(
                    leadingIcon.icon,
                    size: devSize * leadingIcon.size!,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 50),
                      child: Text(
                        count.toString(),
                        key: ValueKey<String>(count.toString()),
                        style: TextStyle(
                            fontSize: devSize * titleSize - 2, color: txtColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      leadingAction();
                      print("play = $play");
                    },
                    child: Ink.image(
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        width: ((devSize * height) - 40 < 50)
                            ? 50
                            : (devSize * height) - 40,
                        height: ((devSize * height) - 40 < 50)
                            ? 50
                            : (devSize * height) - 40,
                        image: Image.network(
                          url,
                          fit: BoxFit.cover,
                        ).image,
                        child: AnimatedSwitcher(
                          switchInCurve: Curves.bounceIn,
                          duration: const Duration(milliseconds: 500),
                          child: (play)
                              ? Icon(
                                  Icons.play_arrow_rounded,
                                  key: ValueKey<bool>(play),
                                  color:
                                      const Color.fromARGB(161, 158, 158, 158),
                                  size: devSize * playSize,
                                )
                              : Icon(
                                  Icons.pause,
                                  color:
                                      const Color.fromARGB(161, 158, 158, 158),
                                  size: devSize * playSize,
                                  key: ValueKey<bool>(play),
                                ),
                        )),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                fontSize: titleSize * devSize, color: txtColor),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: 4),
                          Text(
                            artist,
                            style: TextStyle(
                                fontSize: artistSize * devSize,
                                color: txtColor),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    print("ola");
                  },
                  child: Ink(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      suffixIcon.icon,
                      size: devSize * suffixIcon.size! - 4,
                      color: suffixIcon.color,
                    ),
                  ),
                ),
                Text(
                  min,
                  style: TextStyle(
                      fontSize: titleSize * devSize - 4, color: txtColor),
                  overflow: TextOverflow.clip,
                  maxLines: 3,
                ),
              ],
            )
          ],
        ));
  }

  // Todo: Music category
  Widget cartegories(
      {required String url,
      required String category,
      required Function action,
      required BuildContext context,
      required Icon child,
      double maxWidth = 10,
      double maxHeight = 10,
      double height = 40,
      double width = 40,
      double radius = 5}) {
    Size size = MediaQuery.of(context).size;

    double devSize = (size.height + size.width) / 100;
    devSize = (devSize <= 15) ? devSize : 15;

    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: () {
        action();
      },
      child: Ink(
        width: width * devSize,
        height: height * devSize,
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(image: Image.asset(url).image)),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Ink(
            width: (width * devSize) / 3,
            height: (height * devSize) / 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: Icon(
              child.icon,
              size: child.size! * devSize,
              color: child.color,
            ),
          ),
        ),
      ),
    );
  }

  // Trending
  Widget trending(
      {required Widget category,
      required String title,
      required List<double> textSizes,
      required String artist,
      required BuildContext context,
      double height = 20,
      double width = 20}) {
    Size size = MediaQuery.of(context).size;

    double devSize = (size.height + size.width) / 100;
    devSize = (devSize <= 15) ? devSize : 15;
    return Ink(
      width: width * devSize,
      height: height * devSize,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Color.fromARGB(149, 37, 35, 35),
                spreadRadius: 0,
                blurRadius: 0,
                blurStyle: BlurStyle.inner)
          ]),
      child: Align(
        alignment: Alignment.center,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              category,
              Text(
                title,
                style: TextStyle(
                    fontSize: textSizes[0] * devSize,
                    fontWeight: FontWeight.bold,
                    color: txtColor,
                    height: 1.5),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                artist,
                style: TextStyle(
                  fontSize: textSizes[1] * devSize,
                  height: 1.5,
                  color: txtColor,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              )
            ]),
      ),
      // padding: const EdgeInsets.only(top: 12.0),
    );
  }

  //Music player
  Widget musicPlayer(
      {required String title,
      double titleSize = 2,
      double artistSize = 2,
      required String artist,
      required String url,
      required String min,
      required bool play,
      required Function action,
      required double volume,
      double time = 0.0,
      required Function download,
      required BuildContext context,
      required Function playAction,
      required Function backwardAction,
      required Function forwardAction,
      required Color color}) {
    Size size = MediaQuery.of(context).size;

    double devSize = (size.height + size.width) / 100;
    devSize = (devSize <= 15) ? devSize : 15;

    return Ink(
        width: size.width,
        height: size.height,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Ink(
                  width: (size.width / 100) * 85,
                  height: ((size.height) <= 600 &&
                          (size.width) > 400 &&
                          (size.width) < 480)
                      ? devSize * 25
                      : devSize * 32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white24),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: LayoutBuilder(
                      builder: (BuildContext ctx, BoxConstraints constraints) {
                    if (size.width <= 500 && size.height <= 800) {
                      return Column(
                        children: [
                          musicPlayerImage(
                              devSize: devSize, titleSize: titleSize, url: url),
                          musicPlayerTile(
                              time: time,
                              context: context,
                              devSize: devSize,
                              titleSize: titleSize,
                              artistSize: artistSize,
                              title: title,
                              artist: artist,
                              playAction: playAction,
                              backwardAction: backwardAction,
                              forwardAction: forwardAction,
                              play: play)
                        ],
                      );
                    } else if (size.width <= 800 && size.height <= 500) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: musicPlayerImage(
                                devSize: devSize,
                                titleSize: titleSize,
                                url: url),
                          ),
                          Expanded(
                            flex: 2,
                            child: musicPlayerTile(
                                time: time,
                                context: context,
                                devSize: devSize,
                                titleSize: titleSize,
                                artistSize: artistSize,
                                title: title,
                                artist: artist,
                                playAction: playAction,
                                backwardAction: backwardAction,
                                forwardAction: forwardAction,
                                play: play),
                          )
                        ],
                      );
                    } else if (size.width > 800) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: musicPlayerImage(
                                devSize: devSize,
                                titleSize: titleSize,
                                url: url),
                          ),
                          Expanded(
                            flex: 2,
                            child: musicPlayerTile(
                                time: time,
                                context: context,
                                devSize: devSize,
                                titleSize: titleSize,
                                artistSize: artistSize,
                                title: title,
                                artist: artist,
                                playAction: playAction,
                                backwardAction: backwardAction,
                                forwardAction: forwardAction,
                                play: play),
                          )
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          musicPlayerImage(
                              devSize: devSize, titleSize: titleSize, url: url),
                          musicPlayerTile(
                              time: time,
                              context: context,
                              devSize: devSize,
                              titleSize: titleSize,
                              artistSize: artistSize,
                              title: title,
                              artist: artist,
                              playAction: playAction,
                              backwardAction: backwardAction,
                              forwardAction: forwardAction,
                              play: play)
                        ],
                      );
                    }
                  })),
            ],
          ),
        ));
  }

  ///Playing Music
  Widget player(
      {String end = '00:00',
      String start = '00:00',
      double currentTime = 0.0,
      required double devSize,
      required double timeSize}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 8),
            child: playerText(start, timeSize, devSize, false)),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: LinearProgressIndicator(
              backgroundColor: Colors.white10,
              color: Colors.white70,
              value: currentTime,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(right: 8),
            child: playerText(end, timeSize, devSize, false)),
      ],
    );
  }

  ///Text widget for music player
  Widget playerText(String txt, double size, double devSize, bool bold) {
    return Text(
      txt,
      textHeightBehavior: const TextHeightBehavior(
          applyHeightToFirstAscent: true,
          applyHeightToLastDescent: true,
          leadingDistribution: TextLeadingDistribution.even),
      style: TextStyle(
          height: (bold) ? 3 : 0,
          color: txtColor,
          fontSize: size * devSize,
          fontWeight: (bold) ? FontWeight.bold : FontWeight.normal,
          fontFamily: 'segeo'),
    );
  }

  ///Application background
  Widget appBackground(
      {required Widget body,
      required AppBar appBar,
      required String backgroundImage,
      String mode = "dark",
      required BuildContext context}) {
    txtColor = (mode == "light") ? Colors.black54 : Colors.white;
    return Scaffold(
      // appBar: appBar,
      body: Ink(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          Image.network(
            backgroundImage,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Ink(
                padding: EdgeInsets.all(24),
                color: Colors.white.withOpacity(0.5),
                child: Center(
                  child: body,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  /// Icon Switcher
  Widget switchIcon(
      {required IconData initialIcon,
      required IconData icon,
      required bool play,
      required Function onTap,
      required double playSize,
      required double devSize}) {
    return InkWell(
      borderRadius: BorderRadius.circular(1000),
      onTap: () {
        onTap();
      },
      child: Ink(
          width: devSize * 5,
          height: devSize * 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
          ),
          child: Align(
            alignment: Alignment.center,
            child: AnimatedSwitcher(
              switchInCurve: Curves.easeInOut,
              duration: const Duration(milliseconds: 500),
              child: (play)
                  ? Icon(
                      initialIcon,
                      key: ValueKey<bool>(play),
                      color: Colors.white,
                      size: devSize * playSize,
                    )
                  : Icon(
                      icon,
                      color: Colors.white,
                      size: devSize * playSize,
                      key: ValueKey<bool>(play),
                    ),
            ),
          )),
    );
  }

  ///Responsive IconButton
  Widget responsiveIconButton(
      {required Icon icon,
      required double devSize,
      required Function action,
      Color color = Colors.white}) {
    return SizedBox(
      width: 2.5 * devSize,
      child: IconButton(
        color: color,
        padding: const EdgeInsets.all(0.0),
        icon: Icon(icon.icon, size: icon.size! * devSize),
        onPressed: () {
          action();
        },
      ),
    );
  }

  ///Music player tile
  Widget musicPlayerTile(
      {required BuildContext context,
      required double devSize,
      required double titleSize,
      required double artistSize,
      required String title,
      required String artist,
      required Function playAction,
      required Function backwardAction,
      required Function forwardAction,
      required double time,
      required bool play}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        playerText(title, titleSize, devSize, true),
        playerText(artist, artistSize, devSize, false),
        SizedBox(
            height: 30,
            child: player(devSize: devSize, timeSize: 0.8, currentTime: time)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            responsiveIconButton(
              icon: const Icon(
                CupertinoIcons.repeat,
                size: 2,
              ),
              devSize: devSize,
              action: backwardAction,
            ),
            const SizedBox(
              width: 8,
            ),
            responsiveIconButton(
              icon: const Icon(
                CupertinoIcons.backward,
                size: 2,
              ),
              devSize: devSize,
              action: backwardAction,
            ),
            const SizedBox(
              width: 8,
            ),
            switchIcon(
                initialIcon: CupertinoIcons.play_arrow_solid,
                icon: CupertinoIcons.pause_fill,
                play: play,
                onTap: playAction,
                playSize: 3,
                devSize: devSize),
            const SizedBox(
              width: 8,
            ),
            RotatedBox(
              quarterTurns: 2,
              child: responsiveIconButton(
                icon: const Icon(
                  CupertinoIcons.backward,
                  size: 2,
                ),
                devSize: devSize,
                action: backwardAction,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            responsiveIconButton(
              icon: const Icon(
                CupertinoIcons.shuffle_medium,
                size: 2,
              ),
              devSize: devSize,
              action: backwardAction,
            ),
          ],
        )
      ],
    );
  }

  Widget musicPlayerOpt({
    required BuildContext context,
    required bool mute,
    required Function volumeAction,
    required double volume,
    required Function download,
    required Function likeAction,
    required Function repeatAction,
    int repeat = 0,
    double iconSize = 3,
    IconData volumeIcon = Icons.volume_up_outlined,
    IconData favoriteIcon = CupertinoIcons.volume_mute,
    IconData downloadIcon = CupertinoIcons.volume_mute,
  }) {
    Size size = MediaQuery.of(context).size;

    double devSize = (size.height + size.width) / 100;
    devSize = (devSize <= 15) ? devSize : 15;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.withOpacity(0.8),
      ),
      padding: const EdgeInsets.all(4.0),
      height: (devSize * 10),
      width: devSize * 30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.volume_down_rounded,
                  size: 2 * devSize,
                  color: Colors.white,
                ),
                SizedBox(
                  width: devSize * 20,
                  child: Slider(
                      activeColor: Colors.white,
                      inactiveColor: Colors.white.withOpacity(0.3),
                      value: volume,
                      onChanged: (value) {
                        volumeAction(value);
                        volume = value;
                      },
                      label: "$volume",
                      min: 0,
                      max: 100),
                ),
                Icon(
                  Icons.volume_up_rounded,
                  size: 2 * devSize,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                responsiveIconButton(
                    icon: Icon(
                      (repeat == 0)
                          ? CupertinoIcons.repeat
                          : (repeat == 1)
                              ? CupertinoIcons.repeat_1
                              : CupertinoIcons.shuffle_medium,
                      size: 2,
                    ),
                    devSize: devSize,
                    action: () {}),
                responsiveIconButton(
                    icon: const Icon(
                      CupertinoIcons.suit_heart,
                      size: 2,
                    ),
                    devSize: devSize,
                    action: () {}),
                responsiveIconButton(
                    icon: const Icon(
                      CupertinoIcons.share,
                      size: 2,
                    ),
                    devSize: devSize,
                    action: () {}),
                responsiveIconButton(
                    icon: Icon(
                      (repeat == 0)
                          ? CupertinoIcons.cloud_download
                          : CupertinoIcons.cloud_download_fill,
                      size: 2,
                    ),
                    devSize: devSize,
                    action: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Music player Image
  Widget musicPlayerImage({
    required double devSize,
    required double titleSize,
    required String url,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        playerText("Now Playing ", titleSize, devSize, true),
        Align(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: Image.network(
                url,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  return (loadingProgress != null)
                      ? const SizedBox(
                          child: CircularProgressIndicator(strokeWidth: 2),
                          width: 20,
                        )
                      : child;
                },
              ).image,
              fit: BoxFit.fill,
              width: devSize * 20,
              height: devSize * 15,
            ),
          ),
        ),
      ],
    );
  }

  Widget responsiveSearchBar({
    required TextEditingController controller,
    required BuildContext context,
    required Function action,
  }) {
    Size size = MediaQuery.of(context).size;

    double devSize = (size.height + size.width) / 100;
    devSize = (devSize <= 15) ? devSize : 15;
    return Ink(
      width: size.width,
      height: devSize * 3.5,
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          action();
        },
        style: const TextStyle(
          color: Colors.white
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.withOpacity(0.5),
          border:OutlineInputBorder(
            borderRadius: BorderRadius.circular(1000)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1000),
              borderSide: const BorderSide(
                color: Colors.black
              )
            ),
            hintText: "Search",
            hintStyle: TextStyle(fontSize: 1.5 * devSize, color: Colors.grey),
            prefixIcon: Icon(
              CupertinoIcons.search,
              size: 1.5 * devSize,
              color: Colors.grey,
            )
          ),
      ),
    );
  }
}
