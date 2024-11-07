class Project {
  final String seq;
  final String book_seq;
  final String image;
  final String title;
  final String mcount;
  final String location;
  final String note;
  final String category;
  final String status;
  final bool open;

//<editor-fold desc="Data Methods">

  const Project({
    required this.seq,
    required this.book_seq,
    required this.image,
    required this.title,
    required this.mcount,
    required this.location,
    required this.note,
    required this.category,
    required this.status,
    required this.open,
  });

  @override
  String toString() {
    return 'Project{'
        ' seq: $seq,'
        ' book_seq: $book_seq,'
        ' image: $image,'
        ' title: $title,'
        ' mcount: $mcount,'
        ' location: $location,'
        ' note: $note,'
        ' category: $category,'
        ' status: $status,'
        ' isSelect: $open,'
        '}';
  }

  Project copyWith({
    String? seq,
    String? book_seq,
    String? image,
    String? title,
    String? mcount,
    String? location,
    String? note,
    String? category,
    String? status,
    bool? open,
  }) {
    return Project(
      seq: seq ?? this.seq,
      book_seq: book_seq ?? this.book_seq,
      image: image ?? this.image,
      title: title ?? this.title,
      mcount: mcount ?? this.mcount,
      location: location ?? this.location,
      note: note ?? this.note,
      status: status ?? this.status,
      category: category ?? this.category,
      open: open ?? this.open,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'seq': seq,
      'book_seq': book_seq,
      'image': image,
      'title': title,
      'mcount': mcount,
      'location': location,
      'note': note,
      'status': status,
      'category': category,
      'open': open,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      seq: map['seq'] as String,
      book_seq: map['book_seq'] as String,
      image: map['image'] as String ,
      title: map['title']  as String ,
      mcount: map['mcount']  as String ,
      location: map['location']  as String ,
      note: map['note'] as String ,
      status: map['status'] as String ,
      category: map['category'] as String ,
      open: false,
    );
  }

//</editor-fold>
}
