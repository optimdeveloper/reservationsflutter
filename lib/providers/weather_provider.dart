import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherService {
  Future<void> fetchWeather() async {
    http.Response response =
        //  await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
        await http.get(Uri.parse(
            'https://my.meteoblue.com/packages/basic-3h_trendpro-day?apikey=fpSZa2t1ND384LzH&lat=-2.8922693&lon=-78.98938&asl=2543&format=json'));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body));
    } else {
      throw Exception('Failed to load todos');
    }
  }
}

class Data {
  String userId;
  int id;
  String title;
  bool completed;
  Data({this.userId, this.id, this.title, this.completed});

  Data.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        id = json['id'],
        title = json['title'],
        completed = json['completed'];

  Map<String, dynamic> toJson() =>
      {'userId': userId, 'id': id, 'title': title, 'completed': completed};
}
