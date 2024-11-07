import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_ebook_app/models/category.dart';
//import 'package:flutter_ebook_app/util/api.dart';
import 'package:korean/utils/api_request_status.dart';
import 'package:korean/utils/functions.dart';
import 'package:korean/utils/custom_dio.dart';
//import 'package:get_storage/get_storage.dart';
import 'package:korean/models/book.dart';
import 'package:korean/models/bookhis.dart';
import 'package:korean/models/question.dart';
import 'dart:convert';
import 'package:korean/models/category.dart';

import 'package:korean/models/member.dart';
import 'package:korean/models/goods.dart';
import 'package:korean/models/noti.dart';
import 'package:korean/models/test_progress.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';

class HomeProvider with ChangeNotifier {

  final books = <Book>[];
  Book? book;

  TestProgress? testProgress;

  final category = <Cate>[];
  //final bookPost = <Feeds>[];
  final his = <Bookhis>[];

  final examList = <Question>[];
  final members = <Member>[];

  final notiList = <Noti>[];
  String? memberSeq;
  String? nickname;
  String? photo;

  int notiCount = 0;


  //CategoryFeed top = CategoryFeed();
  //CategoryFeed recent = CategoryFeed();
  APIRequestStatus apiRequestStatus = APIRequestStatus.loading;
  //Api api = Api();

  /*getFeeds() async {
    setApiRequestStatus(APIRequestStatus.loading);
    try {
      CategoryFeed popular = await api.getCategory(Api.popular);
      setTop(popular);
      CategoryFeed newReleases = await api.getCategory(Api.popular);
      setRecent(newReleases);
      setApiRequestStatus(APIRequestStatus.loaded);
    } catch (e) {
      checkError(e);
    }
  }*/

  void init(BuildContext context) {

    if (GetStorage().hasData("member")) {
      memberSeq = GetStorage().read("member")['member_seq'];
      nickname = GetStorage().read("member")['nickname'];
      photo = GetStorage().read("member")['photo'];

      print(memberSeq);

    }

  }

  Future getHome() async {

    //var mtype = GetStorage().read("member")['mtype'];
    //var campusSeq = GetStorage().read("member")['campus_seq'];
    //var memberSeq = GetStorage().read("member")['member_seq'];
    setApiRequestStatus(APIRequestStatus.loading);
    try {
      final res = (await CustomDio()
          .send(reqMethod: "post", path: "main", body: {"campus_seq": 1,"member_seq": memberSeq}))
          .data;
      var feed = res['list'] as List;
      print(feed);
      final list = feed.map((e) => Cate.fromMap(e)).toList();
      print(list);

      category.clear();
      category.addAll(list);

      notifyListeners();
      setApiRequestStatus(APIRequestStatus.loaded);

    } catch (err) {
      //CustomAlert.showError(context: context, err: err.toString());
      checkError(err);
      //rethrow;
    }
  }

  Future getBooks(String? seq, String? type) async {

    //var mtype = GetStorage().read("member")['mtype'];
    //var campusSeq = GetStorage().read("member")['campus_seq'];
    //var memberSeq = GetStorage().read("member")['member_seq'];
    setApiRequestStatus(APIRequestStatus.loading);
    try {
      final res = (await CustomDio()
          .send(reqMethod: "post", path: "book", body: {"seq": seq, "type": type}))
          .data['list'] as List;

      final users = res.map((e) => Book.fromMap(e)).toList();
      books.clear();
      books.addAll(users);
      notifyListeners();
      setApiRequestStatus(APIRequestStatus.loaded);

    } catch (err) {
      //CustomAlert.showError(context: context, err: err.toString());
      checkError(err);
      //rethrow;
    }
  }

  Future getBookHis(String? set_seq, String? kind) async {

    print(set_seq);
    print(kind);


    setApiRequestStatus(APIRequestStatus.loading);

    try {
      final res = (await CustomDio()
          .send(reqMethod: "post", path: "book/history", body: {"set_seq": set_seq, "kind": kind, "member_seq": '2'}))
          .data['list'] as List;
      print(res);

      final users = res.map((e) => Bookhis.fromMap(e)).toList();
      his.clear();
      his.addAll(users);
      notifyListeners();
      setApiRequestStatus(APIRequestStatus.loaded);

    } catch (err) {
      //CustomAlert.showError(context: context, err: err.toString());
      checkError(err);
      //rethrow;
    }
  }

  Future getExam(String? set_seq, String? kind) async {

    setApiRequestStatus(APIRequestStatus.loading);

    try {
      final res = (await CustomDio()
          .send(reqMethod: "post", path: "book/test_progress", body: {"set_seq": set_seq, "kind": kind, "member_seq": 2}))
          .data;
     // print(res);

      var info = res['record'] ;

      var list1 = res['list'] as List;
      print(info);

      print("start:");
      testProgress = TestProgress.fromMap(info);
      print("info:");print(testProgress);



      if(list1 != null) {
        final aaa = list1.map((e) => Question.fromMap(e)).toList();
        print(aaa);
        examList.clear();
        examList.addAll(aaa);
        print(examList);
      }
      notifyListeners();
      setApiRequestStatus(APIRequestStatus.loaded);

      // return examList;

    } catch (err) {
      //CustomAlert.showError(context: context, err: err.toString());
      checkError(err);
      //rethrow;
      // return [];
    }

  }

  Future getExamResume(String? seq) async {

    setApiRequestStatus(APIRequestStatus.loading);

    try {
      final res = (await CustomDio()
          .send(reqMethod: "post", path: "book/resume", body: {"seq": seq}))
          .data;

      var info = res['record'] ;

      var list1 = res['list'] as List;
      print(info);

      print("start:");
      testProgress = TestProgress.fromMap(info);
      print("info:");print(testProgress);



      if(list1 != null) {
        final aaa = list1.map((e) => Question.fromMap(e)).toList();
        print(aaa);
        examList.clear();
        examList.addAll(aaa);
        print(examList);
      }
      notifyListeners();
      setApiRequestStatus(APIRequestStatus.loaded);

      // return examList;

    } catch (err) {
      //CustomAlert.showError(context: context, err: err.toString());
      checkError(err);
      //rethrow;
      // return [];
    }

  }

  //시험삭제
  Future setExamDelete(BuildContext context, String? seq) async {
    final d = (await CustomDio().send(reqMethod: "post", path: "book/exam_delete", body: {"seq": seq})).data;
    var ddd = d['status'];
    if(ddd == "SUCCESS") {
      showInSnackBar('처리 되었습니다.',context);
    }
  }

  Future getNoti(String? keyword) async {

    //var mtype = GetStorage().read("member")['mtype'];
    //var campusSeq = GetStorage().read("member")['campus_seq'];
    //var memberSeq = GetStorage().read("member")['member_seq'];
    setApiRequestStatus(APIRequestStatus.loading);
    try {
      final res = (await CustomDio()
          .send(reqMethod: "post", path: "board/noti", body: {"keyword": keyword,"member_seq": memberSeq}))
          .data['list'] as List;

      print(res);

      final users = res.map((e) => Noti.fromMap(e)).toList();
      notiList.clear();
      notiList.addAll(users);
      notifyListeners();
      setApiRequestStatus(APIRequestStatus.loaded);

    } catch (err) {
      //CustomAlert.showError(context: context, err: err.toString());
      checkError(err);
      //rethrow;
    }
  }


  Future getSearchBook(String? keyword) async {

    //var mtype = GetStorage().read("member")['mtype'];
    //var campusSeq = GetStorage().read("member")['campus_seq'];
    //var memberSeq = GetStorage().read("member")['member_seq'];
    setApiRequestStatus(APIRequestStatus.loading);
    try {
      final res = (await CustomDio()
          .send(reqMethod: "post", path: "book/api", body: {"keyword": keyword,"member_seq": 1 ,"page": 1 }))
          .data['list'] as List;

      //print(res);

      final users = res.map((e) => Book.fromMap(e)).toList();
      books.clear();
      books.addAll(users);
      notifyListeners();
      setApiRequestStatus(APIRequestStatus.loaded);

    } catch (err) {
      //CustomAlert.showError(context: context, err: err.toString());
      checkError(err);
      //rethrow;
    }
  }
  //내책등록
  Future setBook(BuildContext context, String? isbn) async {
        print(isbn);

        final d = (await CustomDio().send(reqMethod: "post", path: "book/setbook", body: {"isbn": isbn, "member_seq": 1 })).data;

        print(d['result']);
        var status = d['status'];
        if(status == "SUCCESS") {
          //로그인처리
          //await GetStorage().write("member", d['result']);
          showInSnackBar('등록 되었습니다.',context);

        }
  }
  void showInSnackBar(String value,context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }



  Future getNotiCount() async {

    var memberSeq = GetStorage().read("member")['member_seq'];
    //setApiRequestStatus(APIRequestStatus.loading);
    try {
      final res = (await CustomDio()
          .send(reqMethod: "post", path: "home/getnoti", body: {"member_seq": memberSeq })).data['count'];
      print(res);
      notiCount = int.parse(res);
      notifyListeners();
      //setApiRequestStatus(APIRequestStatus.loaded);
    } catch (err) {
      //CustomAlert.showError(context: context, err: err.toString());
      checkError(err);
      //rethrow;
    }
  }
  //읽음.
  Future setNotiRead(BuildContext context, String? seq) async {
    final res = (await CustomDio().send(reqMethod: "post", path: "home/setNotiRead", body: {"seq": seq, "member_seq": memberSeq})).data['count'];
    notiCount = int.parse(res);
    notifyListeners();
  }
  Future setNotiReadAll(BuildContext context) async {
    final d = (await CustomDio().send(reqMethod: "post", path: "home/setNotiReadAll", body: {"member_seq": memberSeq})).data;
    var status = d['status'];
    if(status == "SUCCESS") {
      notiCount = 0;
      notifyListeners();
    }
  }



  Future getBook(String? book_seq) async {

    print(book_seq);
    //var mtype = GetStorage().read("member")['mtype'];
    //var campusSeq = GetStorage().read("member")['campus_seq'];
    //var memberSeq = GetStorage().read("member")['member_seq'];

    var url = "book/info/" + book_seq!;
    print(url);

    setApiRequestStatus(APIRequestStatus.loading);
    try {
      final res = (await CustomDio()
          .send(reqMethod: "post", path: url , body: {}))
          .data;

      print(res);

      var info = res['info'] ; //교재정보
      var member = res['member'] as List; //책을 읽은사람
      var post = res['post'] as List; //게시물

      book = Book.fromMap(info);

      if(member != null) {
        final mem = member.map((e) => Member.fromMap(e)).toList();
        members.clear();
        members.addAll(mem);
      }
      //post
      //if(post != null) {
      //  final list = post.map((e) => Feeds.fromMap(e)).toList();
      //  bookPost.clear();
      //  bookPost.addAll(list);
      //}

      notifyListeners();
      setApiRequestStatus(APIRequestStatus.loaded);

    } catch (err) {
      //CustomAlert.showError(context: context, err: err.toString());
      checkError(err);
      //rethrow;
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
  /*
  void setTop(value) {
    top = value;
    notifyListeners();
  }

  CategoryFeed getTop() {
    return top;
  }

  void setRecent(value) {
    recent = value;
    notifyListeners();
  }

  CategoryFeed getRecent() {
    return recent;
  }*/


}
