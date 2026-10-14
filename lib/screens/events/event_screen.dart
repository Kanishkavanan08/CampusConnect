import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final ApiService _apiService = ApiService();

  // State variables to track our network request
  bool _isLoading = true;
  List<String> _events = [];
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Fetch data as soon as the screen loads
    _loadEvents();
  }

  // Our async function that handles the Future
  Future<void> _loadEvents() async {
    try {
      // 1. Set loading to true (it already is, but good practice for pull-to-refresh)
      setState(() {
        _isLoading = true;
        _errorMessage = null; // Clear old errors
      });

      // 2. AWAIT the future. The code pauses on this line until the 2 seconds finish!
      final data = await _apiService.fetchEvents();

      // 3. Success! Update the list and stop loading.
      setState(() {
        _events = data;
        _isLoading = false;
      });

    } catch (e) {
      // 4. If something crashed (like no internet), catch the error!
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // SCENARIO A: Still waiting for the Future
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // SCENARIO B: The Future threw an error
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text('Error: $_errorMessage'),
            ElevatedButton(
              onPressed: _loadEvents, // Retry button
              child: const Text('Retry'),
            )
          ],
        ),
      );
    }

    // SCENARIO C: The Future finished, but the list is empty
    if (_events.isEmpty) {
      return const Center(
        child: Text('No events scheduled at the moment.'),
      );
    }

    // SCENARIO D: The Future finished successfully with data!
    return ListView.builder(
      itemCount: _events.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.event, color: Colors.indigo),
            title: Text(
              _events[index],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        );
      },
    );
  }
}