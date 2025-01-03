class Event {
  final String title;
  final DateTime date;
  final String location;

  Event({required this.title, required this.date, required this.location});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date.toIso8601String(),
      'location': location,
    };
  }

  static Event fromMap(Map<String, dynamic> map) {
    return Event(
      title: map['title'],
      date: DateTime.parse(map['date']),
      location: map['location'],
    );
  }
}
