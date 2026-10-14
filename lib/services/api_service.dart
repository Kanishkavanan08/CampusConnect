import 'dart:convert'; // Required to decode JSON
import 'package:http/http.dart' as http; // Import the http package
import '../models/event_model.dart'; // Import our new model

class ApiService {
  // Use 10.0.2.2 if testing on an Android Emulator, because localhost points to the phone itself!
  // If testing on Windows Desktop, use localhost. Let's assume Android Emulator for now.
  static const String baseUrl = 'http://localhost:3000';
// If localhost still fails, try 'http://127.0.0.1:3000'

  // Notice it now returns a Future of List<Event> instead of List<String>
  Future<List<Event>> fetchEvents() async {
    try {
      // 1. Make the GET request over the network
      final response = await http.get(Uri.parse('$baseUrl/events'));

      // 2. Check if the server responded with a 200 OK status
      if (response.statusCode == 200) {

        // 3. Convert the raw JSON string into a Dart List of Maps
        List<dynamic> jsonList = json.decode(response.body);

        // 4. Map each raw JSON item into our safe Event model
        return jsonList.map((json) => Event.fromJson(json)).toList();

      } else {
        throw Exception('Failed to load events. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}