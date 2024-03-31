import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Favourite> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Favourite> with TickerProviderStateMixin {
  late AnimationController _favoriteController;
  late AnimationController _menuController;

  @override
  void initState() {
    super.initState();

    _favoriteController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _menuController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _favoriteController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /// Toggle example
              // Column(
              //   children: [
              //     const Padding(
              //       padding: EdgeInsets.all(8.0),
              //       child: Text('Toggle'),
              //     ),
              //     IconButton(
              //       splashRadius: 50,
              //       iconSize: 100,
              //       onPressed: () {
              //         if (_favoriteController.status ==
              //             AnimationStatus.dismissed) {
              //           _favoriteController.reset();
              //           _favoriteController.animateTo(0.6);
              //         } else {
              //           _favoriteController.reverse();
              //         }
              //       },
              //       color: Colors.red,
              //       icon: Lottie.asset(Icons8.add_to_favorites,
              //           controller: _favoriteController),
              //     ),
              //   ],
              // ),

              /// change color example
              // To change color, goto https://lottiefiles.com/editor
              // original color
              // changed color
              // Column(
              //   children: [
              //     const Padding(
              //       padding: EdgeInsets.all(8.0),
              //       child: Text('Edited animation color\nblack → blue',
              //           textAlign: TextAlign.center),
              //     ),
              //     Row(
              //       children: [
              //         IconButton(
              //           splashRadius: 50,
              //           iconSize: 100,
              //           onPressed: () {
              //             if (_menuController.status ==
              //                 AnimationStatus.dismissed) {
              //               _menuController.reset();
              //               _menuController.animateTo(0.6);
              //             } else {
              //               _menuController.reverse();
              //             }
              //           },
              //           icon: Lottie.asset(Useanimations.menuV3,
              //               controller: _menuController,
              //               height: 60,
              //               fit: BoxFit.fitHeight),
              //         ),
              //         IconButton(
              //           splashRadius: 50,
              //           iconSize: 100,
              //           onPressed: () {
              //             if (_menuController.status ==
              //                 AnimationStatus.dismissed) {
              //               _menuController.reset();
              //               _menuController.animateTo(0.6);
              //             } else {
              //               _menuController.reverse();
              //             }
              //           },
              //           icon: Lottie.asset(Useanimations.menuV3Blue,
              //               controller: _menuController,
              //               height: 60,
              //               fit: BoxFit.fitHeight),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),

              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary,
                  BlendMode.color,
                ),
                child: Lottie.asset(
                  'assets/fav_lotti.json',
                  repeat: true,
                  reverse: true,
                  height: 300,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
