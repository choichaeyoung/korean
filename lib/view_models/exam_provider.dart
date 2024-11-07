import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_ebook_app/models/category.dart';
//import 'package:flutter_ebook_app/util/api.dart';
import 'package:korean/utils/api_request_status.dart';
import 'package:korean/utils/functions.dart';
import 'package:korean/utils/custom_dio.dart';

import 'package:get_storage/get_storage.dart';



class ExamProvider with ChangeNotifier {

  String? memberSeq;
  APIRequestStatus apiRequestStatus = APIRequestStatus.loading;

  void init(BuildContext context) {

    if (GetStorage().hasData("member")) {
      memberSeq = GetStorage().read("member")['member_seq'];
    }

  }

  //시험등록
  Future setExamSave(BuildContext context, String? seq, String? kind,String? set_seq, String? str, int counter) async {
    print(str);

    if (GetStorage().hasData("member")) {
      memberSeq = GetStorage().read("member")['member_seq'];
    }

    final d = (await CustomDio().send(reqMethod: "post", path: "book/set_save", body: {"seq": seq, "kind": kind, "set_seq": set_seq, "str": str,  "member_seq": memberSeq , "time_left":counter})).data;

    print(d['result']);
    var status = d['status'];
    if(status == "SUCCESS") {

      //await GetStorage().write("member", d['result']);
      showInSnackBar('등록 되었습니다.',context);

    }
  }
  void showInSnackBar(String value,context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
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
