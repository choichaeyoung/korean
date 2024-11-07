class TestProgress {
  final String seq;
  final String set_seq;
  final String title;
  final String kind;
  final String current;
  final String set_cnt;
  final String time_left;
  final String status;

//<editor-fold desc="Data Methods">

  const TestProgress({
    required this.seq,
    required this.set_seq,
    required this.title,
    required this.kind,
    required this.current,
    required this.set_cnt,
    required this.time_left,
    required this.status,
  });

  factory TestProgress.fromMap(Map<String, dynamic> map) {
    return TestProgress(
      seq: map['seq'] as String,
      set_seq: map['set_seq'] as String,
      title: map['title']  as String ,
      kind: map['kind'] ?? "" ,
      current: map['current'] ?? "" ,
      set_cnt: map['set_cnt'] ?? "" ,
      time_left: map['time_left'] ?? "" ,
      status: map['status'] ?? "" ,
    );
  }
//</editor-fold>
}
