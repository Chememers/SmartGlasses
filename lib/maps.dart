import 'package:http/http.dart' as http;
import 'dart:convert';

var url = "http://www.mapquestapi.com/directions/v2/route";
var key = "ivvTktSW08yUuYd7TebZLeVB64ufAIZT"; // MapQuest API Key
// String from = "1900 Prairie City Rd, Folsom, CA 95630";
// String to = "1655 Iron Point Rd, Folsom, CA 95630";

Future<Map<String, dynamic>> getDirections(String from, String to) async {
  var url =
      "http://www.mapquestapi.com/directions/v2/route?key=${key}&from=${from}&to=${to}";
  final response = await http.get(url);
  final Map<String, dynamic> data = json.decode(response.body);
  //Do stuff with data
  return data;
}
