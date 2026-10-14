// We import this to use Future.delayed
import 'dart:async';

class ApiService {
  // This function returns a Future containing a List of Strings.
  // The 'async' keyword tells Flutter this operation takes time.
  Future<List<String>> fetchEvents() async {

    // Simulate a slow 2-second network delay
    await Future.delayed(const Duration(seconds: 2));

    // After 2 seconds, return the "data" from our fake server
    return [
      'AI & Machine Learning Workshop',
      'Flutter Hackathon 2026',
      'Campus Cultural Fest',
      'Mid-Semester Tech Symposium'
    ];

    // (Note: To test errors later, we could throw an Exception here instead of returning data)
  }
}