class Record {
  final String date;
  final int hold;
  Record({this.hold, this.date});

  Record.fromMap(Map<String, dynamic> map)
      : assert(map['date'] != null),
        assert(map['hold'] != null),
        date = map['date'],
        hold = map['hold'];

  @override
  String toString() => "$date :: $hold";
}
