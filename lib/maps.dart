import 'package:http/http.dart' as http;

var url = "http://www.mapquestapi.com/directions/v2/route";
var key = "ivvTktSW08yUuYd7TebZLeVB64ufAIZT"; // MapQuest API Key

var params = {
  "key": key,
  "from": "1900 Prairie City Rd, Folsom, CA 95630",
  "to": "1655 Iron Point Rd, Folsom, CA 95630"
};
