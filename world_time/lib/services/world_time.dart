import 'package:http/http.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String flag;
  String url;

  WorldTime({ required this.location, required this.flag, required this.url });

  String time = '';
  bool isDaytime = false;

  Future<void> getTime() async {
    try {
      Uri uri = Uri.http('worldtimeapi.org', '/api/timezone/$url');
      Response response = await get(uri);
      Map data = jsonDecode(response.body);

      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime = now.hour >= 6 && now.hour < 20;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Error getting time $e');
      time = 'Something went wrong';
    }
  }
}
