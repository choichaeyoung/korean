class Bookhis {
  final String seq;
  final String set_seq;
  final String regist_date;
  final String score;
  final String time_left;
  final String status;

//<editor-fold desc="Data Methods">

  const Bookhis({
    required this.seq,
    required this.set_seq,
    required this.regist_date,
    required this.score,
    required this.time_left,
    required this.status,
  });

  factory Bookhis.fromMap(Map<String, dynamic> map) {
    return Bookhis(
      seq: map['seq'] as String,
      set_seq: map['set_seq'] as String,
      regist_date: map['regist_date']  as String ,
      score: map['score'] ?? "" ,
      time_left: map['time_left'] ?? "" ,
      status: map['status'] ?? "" ,
    );
  }
//</editor-fold>
}
