class Feeds {
  final String post_seq;
  final String book_seq;
  final String member_seq;
  final String subject;
  final String image;
  final String title;
  final String book_image;
  final String author;
  final String publisher;
  final String description;
  final String regist_date;
  final String nickname;
  final String photo;


//<editor-fold desc="Data Methods">

  const Feeds({
    required this.post_seq,
    required this.book_seq,
    required this.member_seq,
    required this.subject,
    required this.image,
    required this.title,
    required this.book_image,
    required this.author,
    required this.publisher,
    required this.description,
    required this.regist_date,
    required this.nickname,
    required this.photo,

  });

  @override
  String toString() {
    return 'Feeds{'
        ' post_seq: $post_seq,'
        ' book_seq: $book_seq,'
        ' member_seq: $member_seq,'
        ' subject: $subject,'
        ' image: $image,'
        ' title: $title,'
        ' book_image: $book_image,'
        ' author: $author,'
        ' published: $publisher,'
        ' description: $description,'
        ' regist_date: $regist_date,'
        ' nickname: $nickname,'
        ' photo: $photo,'

        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      'post_seq: post_seq,'
          'book_seq: book_seq,'
          'member_seq': member_seq,
      'subject': subject,
      'image': image,
      'title': title,
      'book_image': book_image,
      'author': author,
      'publisher': publisher,
      'description': description,
      'regist_date': regist_date,
      'nickname': nickname,
      'photo': photo,


    };
  }

  factory Feeds.fromMap(Map<String, dynamic> map) {
    return Feeds(
      post_seq: map['post_seq'] as String,
      book_seq: map['book_seq'] as String,
      member_seq: map['member_seq'] as String,
      subject: map['subject'] as String ,
      image: map['image'] as String ,
      title: map['title']  as String ,
      book_image: map['book_image'] as String ,
      author: map['author']  as String ,
      publisher: map['publisher']  as String ,
      description: map['description'] as String ,
      regist_date: map['regist_date'] as String ,
      nickname: map['nickname'] as String ,
      photo: map['photo'] as String ,

    );
  }

//</editor-fold>
}
