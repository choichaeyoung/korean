class Member {
  final String member_seq;
  final String userid;
  final String image;
  final String nickname;
  final String profile;

//<editor-fold desc="Data Methods">

  const Member({
    required this.member_seq,
    required this.userid,
    required this.image,
    required this.nickname,
    required this.profile,
  });

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      member_seq: map['member_seq'] as String,
      userid: map['userid'] as String,
      image: map['photo'] ?? "",
      nickname: map['nickname']  ?? "",
      profile: map['profile']  ?? "",

    );
  }

//</editor-fold>
}
