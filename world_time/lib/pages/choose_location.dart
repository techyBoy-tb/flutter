import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:const Text('Choose a location'),
        centerTitle: true,
        elevation: 0,
      ),
      body:ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            WorldTime currentLocation = locations[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
              child: Card(
                child: ListTile(
                  onTap: () async {
                    await currentLocation.getTime();
                    if (context.mounted) {
                      Navigator.pop(
                          context, {
                        'location': currentLocation.location,
                        'flag': currentLocation.flag,
                        'time': currentLocation.time,
                        'isDaytime': currentLocation.isDaytime,
                      });
                    }
                  },
                  title: Text(currentLocation.location),
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('assets/egypt.png'),
                  ),
                )
              ),
            );
          })
    );
  }
}
