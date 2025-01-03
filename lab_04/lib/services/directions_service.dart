import 'dart:convert';
import 'package:http/http.dart' as http;

class DirectionsService {
  static Future<String> getDirections(String origin, String destination) async {
    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=YOUR_GOOGLE_API_KEY';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['routes'][0]['overview_polyline']['points'];
    } else {
      throw Exception('Failed to load directions');
    }
  }
}
