class Goods {
  final String goods_seq;
  final String image;
  final String title;
  final String description;
  final String category;
  final String status;
  final int price1;
  final int price2;


//<editor-fold desc="Data Methods">

  const Goods({
    required this.goods_seq,
    required this.image,
    required this.title,

    required this.description,
    required this.category,
    required this.status,

    required this.price1,
    required this.price2,
  });

  @override
  String toString() {
    return 'Goods{'
        ' goods_seq: $goods_seq,'

        ' image: $image,'
        ' title: $title,'

        ' description: $description,'
        ' category: $category,'
        ' status: $status,'

        '}';
  }

  Goods copyWith({
    String? goods_seq,
    String? image,
    String? title,

    String? description,
    String? category,
    String? status,

  }) {
    return Goods(
      goods_seq: goods_seq ?? this.goods_seq,

      image: image ?? this.image,
      title: title ?? this.title,

      description: description ?? this.description,
      status: status ?? this.status,
      category: category ?? this.category,

      price1: price1 ?? this.price1,
      price2: price2 ?? this.price2,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'goods_seq': goods_seq,

      'image': image,
      'title': title,

      'description': description,
      'status': status,
      'category': category,
    };
  }

  factory Goods.fromMap(Map<String, dynamic> map) {
    return Goods(
      goods_seq: map['goods_seq'] as String,

      image: map['image'] as String ,
      title: map['title']  as String ,

      description: map['description'] as String ,
      status: map['status'] as String ,
      category: map['category'] as String ,

      price1: int.parse(map['price1']) as int ,
      price2: int.parse(map['price2']) as int ,
    );
  }
//</editor-fold>
}
