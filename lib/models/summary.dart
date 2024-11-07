class Sum {
  final String mybook;
  final String friends;
  final String clubs;
  final String posts;
  final String books;
  final String buyamount;


  const Sum({
    required this.mybook,
    required this.friends,
    required this.clubs,
    required this.posts,
    required this.books,
    required this.buyamount,
  });


  Map<String, dynamic> toMap() {
    return {
      'mybook': mybook,
      'friends': friends,
      'clubs': clubs,
      'posts': posts,
      'books': books,
      'buyamount': buyamount,
    };
  }

  factory Sum.fromMap(Map<String, dynamic> map) {
    return Sum(
        mybook: map['mybook'] as String,
        friends: map['friends'] as String ,
        clubs: map['clubs'] as String ,
        posts: map['posts']  as String ,
        books: map['books']  as String ,
        buyamount: map['buyamount']  as String
    );
  }
}