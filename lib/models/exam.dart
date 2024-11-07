class Exam {
  final String seq;
  final String num;
  final String score;
  final String subject;
  final String ask;
  final String ask1;
  final String ask2;
  final String ask3;
  final String ask4;
  final String answer;
  final String solve;
  final String audio;
  final String title;
  final String content;

//<editor-fold desc="Data Methods">

  const Exam({
    required this.seq,
    required this.num,
    required this.score,
    required this.subject,
    required this.ask,
    required this.ask1,
    required this.ask2,
    required this.ask3,
    required this.ask4,
    required this.answer,
    required this.solve,
    required this.audio,
    required this.title,
    required this.content,

  });

  factory Exam.fromMap(Map<String, dynamic> map) {
    return Exam(
      seq: map['seq'] as String,
      num: map['num'] as String,
      score: map['score'] ?? "" ,
      subject: map['subject'] ?? "" ,
      ask: map['ask'] ?? "" ,
      ask1: map['ask1'] ?? "" ,
      ask2: map['ask2'] ?? "" ,
      ask3: map['ask3'] ?? "" ,
      ask4: map['ask4'] ?? "" ,
      answer: map['answer'] ?? "" ,
      solve: map['solve'] ?? "" ,
      audio: map['audio'] ?? "" ,
      title: map['title'] ?? "" ,
      content: map['content'] ?? "" ,
    );
  }
//</editor-fold>
}
