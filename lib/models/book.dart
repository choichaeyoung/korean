class Book {
  final String set_seq;
  final String round;
  final String title;
  final String set_cnt;
  final String time_left;

//<editor-fold desc="Data Methods">

  const Book({
    required this.set_seq,
    required this.title,
    required this.round,
    required this.set_cnt,
    required this.time_left,
  });

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      set_seq: map['seq'] as String,
      title: map['title']  as String ,
      round: map['round'] ?? "" ,
      set_cnt: map['set_cnt'] ?? "" ,
      time_left: map['time_left'] ?? "" ,
    );
  }
//</editor-fold>
}
