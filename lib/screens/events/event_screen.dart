import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../models/event_model.dart'; // Import the model

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final ApiService _apiService = ApiService();

  bool _isLoading = true;

  // CHANGED: This is now a list of Event objects!
  List<Event> _events = [];
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final data = await _apiService.fetchEvents();

      setState(() {
        _events = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text('Error: $_errorMessage'),
            ElevatedButton(
              onPressed: _loadEvents,
              child: const Text('Retry'),
            )
          ],
        ),
      );
    }

    if (_events.isEmpty) {
      return const Center(child: Text('No events scheduled at the moment.'));
    }

    return ListView.builder(
      itemCount: _events.length,
      itemBuilder: (context, index) {
        // CHANGED: Grab the Event object
        final event = _events[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.event, color: Colors.indigo),
            // CHANGED: Access properties using dot notation
            title: Text(
              event.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Date: ${event.date}'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        );
      },
    );
  }
}