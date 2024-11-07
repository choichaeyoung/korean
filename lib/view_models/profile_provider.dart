import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_ebook_app/models/category.dart';
//import 'package:flutter_ebook_app/util/api.dart';
import 'package:korean/utils/api_request_status.dart';
import 'package:korean/utils/functions.dart';
import 'package:korean/utils/custom_dio.dart';
//import 'package:get_storage/get_storage.dart';
import 'package:korean/models/book.dart';
import 'package:korean/models/club.dart';
import 'package:korean/models/member.dart';
import 'package:korean/models/summary.dart';
import 'package:korean/models/category.dart';
import 'package:get_storage/get_storage.dart';


class ProfileProvider with ChangeNotifier {

  final clubList = <Club>[];
  final bookList = <Book>[];
  final memberList = <Member>[];
  final cateList = <Cate>[];
  final tagList = <Cate>[];

  String? memberSeq;
  String? nickname;
  String? photo;

  Member? member;
  Sum? summary;

  APIRequestStatus apiRequestStatus = APIRequestStatus.loading;

  void init(BuildContext context) {

    if (GetStorage().hasData("member")) {
      memberSeq = GetStorage().read("member")['member_seq'];
      nickname = GetStorage().read("member")['nickname'];
      photo = GetStorage().read("member")['photo'];
    }
  }

  Future getMember(String? memberSeq) async {

    //print(book_seq);
    //var mtype = GetStorage().read("member")['mtype'];
    //var campusSeq = GetStorage().read("member")['campus_seq'];
    //var memberSeq = GetStorage().read("member")['member_seq'];



    setApiRequestStatus(APIRequestStatus.loading);
    try {
      final res = (await CustomDio()
          .send(reqMethod: "post", path: "member/info", body: {"member_seq": 2}))
          .data;

      var info = res['info'] ; //회원정보
      //var sum = res['summary'] ; //통계정보

      //var blist = res['book'] as List; //
      //var mlist = res['member'] as List; //책
      //var mclub = res['club'] as List; //참여한클럽
      //var cate = res['catelist'] as List; //책 카테고리


      print(info);

      //info
      member = Member.fromMap(info);
      //통계
      //summary = Sum.fromMap(sum);



      notifyListeners();
      setApiRequestStatus(APIRequestStatus.loaded);

    } catch (err) {
      //CustomAlert.showError(context: context, err: err.toString());
      checkError(err);
      //rethrow;
    }
  }

  Future getClubs() async {

    //var mtype = GetStorage().read("member")['mtype'];
    //var campusSeq = GetStorage().read("member")['campus_seq'];
    //var memberSeq = GetStorage().read("member")['member_seq'];
    setApiRequestStatus(APIRequestStatus.loading);
    try {
      final res = (await CustomDio()
          .send(reqMethod: "post", path: "club/main", body: {"campus_seq": 1,"member_seq": 1}))
          .data['list'] as List;

      print(res);

      final list = res.map((e) => Club.fromMap(e)).toList();
      clubList.clear();
      clubList.addAll(list);
      notifyListeners();
      setApiRequestStatus(APIRequestStatus.loaded);

    } catch (err) {
      //CustomAlert.showError(context: context, err: err.toString());
      checkError(err);
      rethrow;
    }
  }

  void checkError(e) {
    if (Functions.checkConnectionError(e)) {
      setApiRequestStatus(APIRequestStatus.connectionError);
    } else {
      setApiRequestStatus(APIRequestStatus.error);
    }
  }

  void setApiRequestStatus(APIRequestStatus value) {
    apiRequestStatus = value;
    notifyListeners();
  }


}
