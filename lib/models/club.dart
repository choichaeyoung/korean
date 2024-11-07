class Club {
  final String club_seq;
  final String chief_seq;
  final String cname;
  final String cphoto;
  final String image;
  final String title;
  final String mcount;
  final String auth_code;
  final String description;
  final String category;
  final String status;
  final String regist_date;
  final String addr;
  final bool open;

//<editor-fold desc="Data Methods">

  const Club({
    required this.club_seq,
    required this.chief_seq,
    required this.cname,
    required this.cphoto,
    required this.image,
    required this.title,
    required this.mcount,
    required this.auth_code,
    required this.description,
    required this.category,
    required this.status,
    required this.regist_date,
    required this.addr,
    required this.open,
  });

  Map<String, dynamic> toMap() {
    return {
      'club_seq': club_seq,
      'chief_seq': chief_seq,
      'cname': cname,
      'cphoto': cphoto,
      'image': image,
      'title': title,
      'mcount': mcount,
      'auth_code': auth_code,
      'description': description,
      'status': status,
      'regist_date': regist_date,
      'addr': addr,
      'category': category,
      'open': open,
    };
  }

  factory Club.fromMap(Map<String, dynamic> map) {
    return Club(
      club_seq: map['club_seq'] as String,
      chief_seq: map['chief_seq'] as String,
      cname: map['cname'] as String,
      cphoto: map['cphoto'] as String,
      image: map['image'] as String ,
      title: map['title']  as String ,
      mcount: map['mcount']  as String ,
      auth_code: map['auth_code']  as String ,
      description: map['description'] as String ,
      status: map['status'] as String ,
      regist_date: map['regist_date'] as String ,
      addr: map['addr'] as String ,
      category: map['category'] as String ,
      open: false,
    );
  }

//</editor-fold>
}
