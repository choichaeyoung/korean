class Cate {
  final String seq;
  final String parent_seq;
  final String title;
  final String sub_title;
  final String book_type;
  final String kind;

  const Cate({
    required this.seq,
    required this.parent_seq,
    required this.title,
    required this.sub_title,
    required this.book_type,
    required this.kind,
  });

  /*
  Map<String, dynamic> toMap() {
    return {
      'seq': seq,
      'cname': cname,
      'count': count,
      'price': price,
    };
  }*/

  factory Cate.fromMap(Map<String, dynamic> map) {
    return Cate(
        seq: map['seq'] as String,
        parent_seq: map['parent_seq'] as String ,
        title: map['title'] as String,
        sub_title: map['sub_title'] ?? "",
        book_type: map['book_type'] ?? "",
        kind: map['kind'] ?? ""
    );
  }
}
