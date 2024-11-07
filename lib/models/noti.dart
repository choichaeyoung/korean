class Noti {
  final String seq;
  final String from_seq;
  final String image;
  final String user_name;
  final String table;
  final String msgseq;
  final String msg;
  final String regist_date;
  final String status;


  const Noti({
    required this.seq,
    required this.from_seq,
    required this.image,
    required this.user_name,
    required this.table,
    required this.msgseq,
    required this.msg,
    required this.regist_date,
    required this.status,

  });


  Map<String, dynamic> toMap() {
    return {
      'seq': seq,
      'from_seq': from_seq,
      'image': image,
      'user_name': user_name,
      'table': table,
      'msgseq': msgseq,
      'msg': msg,
      'status': status,
      'regist_date': regist_date,
    };
  }

  factory Noti.fromMap(Map<String, dynamic> map) {
    return Noti(
      seq: map['seq'] as String,
      from_seq: map['from_seq'] as String ,
      image: map['image'] as String ,
      user_name: map['user_name']  as String ,
      table: map['table']  as String ,
      msgseq: map['msgseq']  as String ,
      msg: map['msg'] as String ,
      status: map['status'] as String ,
      regist_date: map['regist_date'] as String ,
    );
  }
//</editor-fold>
}
