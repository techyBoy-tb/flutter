import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupWorldTime() async {
    WorldTime worldTime = WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
    // WorldTime worldTime = WorldTime(location: 'Sidney', flag: 'germany.png', url: 'Australia/South');
    await worldTime.getTime();
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': worldTime.location,
      'flag': worldTime.flag,
      'time': worldTime.time,
      'isDaytime': worldTime.isDaytime,
    });
    }
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: SpinKitSpinningLines(color: Colors.red),
        )
    );
  }
}
