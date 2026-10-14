class Event {
  final String id;
  final String title;
  final String date;

  Event({
    required this.id,
    required this.title,
    required this.date,
  });

  // This is a "factory constructor". It takes a raw JSON map (Map<String, dynamic>)
  // and spits out a safely formatted Event object.
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      date: json['date'],
    );
  }
}