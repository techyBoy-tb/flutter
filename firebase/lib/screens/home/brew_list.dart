import 'package:firebase/models/Brew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  final List<Widget> _brewTiles = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context) ?? [];

    Widget buildTile(Brew brew) {
      return Card(
        margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: const AssetImage('assets/coffee_icon.png'),
            backgroundColor: Colors.brown[brew.strength],
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugars} sugar(s)'),
          // 'Takes ${brew.sugars} sugar${int.parse(brew.sugars) > 1 ? 's' : ''}'),
        ),
      );
    }

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return buildTile(brews[index]);
      },
    );
    //
    // Future ft = Future(() {});
    // if (brews != null) {
    //   for (var brew in brews) {
    //     ft = ft.then((_) {
    //       return Future.delayed(const Duration(milliseconds: 100), () {
    //         _brewTiles.add(buildTile(brew));
    //         _listKey.currentState?.insertItem(_brewTiles.length - 1);
    //       });
    //     });
    //   }
    // }

    // return AnimatedList(
    //     key: _listKey,
    //     initialItemCount: _brewTiles.length,
    //     itemBuilder: (context, index, animation) {
    //       return SlideTransition(
    //         position: animation.drive(Tween(
    //           begin: const Offset(1, 0),
    //           end: const Offset(0, 0),
    //         )),
    //         child: _brewTiles[index],
    //       );
    //     });
  }
}
