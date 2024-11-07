
import 'dart:ffi';

class Question {
  final String? title;
  final String? content;
  final String? seq;
  final String? test_seq;
  final int? num;
  final String? score;
  final String? question;
  final String? audioUrl;
  final String? mediaUrl;
  final String? answer;
  final List<dynamic>? answers;
  final String? explanation;
  final String? userAnswer;
  final String? sXO;
  final String? qtype;
  //final String? correct ;

  Question({ this.title, this.content, this.seq,  this.test_seq, this.num, this.score,  this.question, this.answer, this.answers, this.audioUrl, this.mediaUrl, this.explanation, this.userAnswer, this.sXO,  this.qtype});


  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      title: map['title'] ?? "" ,
      content: map['content'] ?? "" ,
      seq: map['seq'] ?? "" ,
      test_seq: map['test_seq'] ?? "" ,
      num: map['num'] as int,
      score: map['score'] ?? "" ,
      question: map['question'] ?? "" ,
      audioUrl: map['audio_url'] ?? "" ,
      mediaUrl: map['media_url'] ?? "" ,
      answer: map['answer'] ?? "" ,
      answers: map['answers'] ?? "" ,
      explanation: map['explanation'] ?? "" ,
      userAnswer: map['userAnswer'] ?? "" ,
      sXO: map['sXO'] ?? "" ,
      qtype: map['qtype'] ?? "" ,
    );
  }



}