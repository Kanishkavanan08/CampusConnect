import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../models/event_model.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final ApiService _apiService = ApiService();

  // We only need to store the Future itself!
  // 'late' means we promise to initialize it in initState before using it.
  late Future<List<Event>> _eventsFuture;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  // We wrap this in a function so we can easily call it again if the user clicks "Retry"
  void _fetchData() {
    setState(() {
      _eventsFuture = _apiService.fetchEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The magic happens here!
      body: FutureBuilder<List<Event>>(
        future: _eventsFuture, // 1. Give it the Future
        builder: (context, snapshot) { // 2. Check the snapshot of that Future

          // SCENARIO A: Still waiting for the network
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // SCENARIO B: The network request failed
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text('Error: ${snapshot.error}'),
                  ElevatedButton(
                    onPressed: _fetchData, // Call our fetch function again to retry
                    child: const Text('Retry'),
                  )
                ],
              ),
            );
          }

          // SCENARIO C: Success, but the list is empty
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No events scheduled at the moment.'));
          }

          // SCENARIO D: Success! We have our data.
          // snapshot.data contains our List<Event>
          final events = snapshot.data!;

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.event, color: Colors.indigo),
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
        },
      ),
    );
  }
}