import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:korean/auth/register/profile_pic.dart';
import 'package:korean/services/auth_service.dart';
import 'package:korean/utils/custom_dio.dart';

import 'package:get_storage/get_storage.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:korean/utils/custom_alert.dart';
import 'package:korean/auth/login/login.dart';

class RegisterViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool authCheck = false;
  bool loading = false;
  String? member_seq, username, email, cellphone, authcode, password, cPassword;
  FocusNode usernameFN = FocusNode();
  FocusNode emailFN = FocusNode();
  FocusNode cellphoneFN = FocusNode();
  FocusNode passFN = FocusNode();
  FocusNode cPassFN = FocusNode();
  AuthService auth = AuthService();

  register(BuildContext context) async {
    FormState form = formKey.currentState!;
    form.save();
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      //showInSnackBar(
          //'Please fix the errors in red before submitting.', context);
    } else {
      if (password == cPassword) {
        loading = true;
        notifyListeners();
        //try {
          //bool success = await auth.createUser(
         //   name: username,
         //   email: email,
         //   password: password,
         //   country: country,
        //  );
         // print(success);
          //if (success) {
            //Navigator.of(context).pushReplacement(
             // CupertinoPageRoute(
              //  builder: (_) => ProfilePicture(),
              //),
           // );
          //}
       // } catch (e) {
        //  loading = false;
        //  notifyListeners();
        //  print(e);
       //   showInSnackBar(
      //        '${auth.handleFirebaseAuthError(e.toString())}', context);
      //  }
       // loading = false;
       // notifyListeners();
     // } else {
     //   showInSnackBar('The passwords does not match', context);
     }
    }
  }



  pSearch(BuildContext context) async {
    FormState form = formKey.currentState!;
    //form.save();

    if (!form.validate()) {
      validate = true;
      notifyListeners();
    } else {
      loading = true;
      notifyListeners();
      final d = (await CustomDio().send(
          reqMethod: "post", path: "member/passSearch",
          body: {
            "nickname": username,
            "email": email,
          })).data;

      print(d['result']);
      var status = d['status'];
      //var newpass = d['newpass'];
      loading = false;
      notifyListeners();

      if (status == "SUCCESS") {
        //loading = false;
        CustomAlert.showAlert(
            context: context, msg: '이메일로 새로운 비밀번호를 전송했습니다.');
      } else {
        CustomAlert.showAlert(
            context: context, msg: '회원정보가 없습니다.');
      }
    }
  }
  pUerid(BuildContext context) async {
    FormState form = formKey.currentState!;
    //form.save();

    if (!form.validate()) {
      validate = true;
      notifyListeners();
    } else {
      loading = true;
      notifyListeners();
      var msg = '';
      final d = (await CustomDio().send(
          reqMethod: "post", path: "member/idSearch",
          body: {
            "nickname": username,
            "cellphone": cellphone,
          })).data;

      loading = false;

      notifyListeners();

      msg = d['msg'];
      if(msg != "") {
        CustomAlert.showAlert(context: context, msg: msg );
      } else {
        CustomAlert.showAlert(context: context, msg: '카카오톡 으로 아이디를 보냈 습니다.' );

      }

      loading = false;


    }
  }
  setAuthCodeSend(BuildContext context) async {
    if (cellphone != null) {

      var msg = '';
      loading = true;
      notifyListeners();
      try {
        final d = (await CustomDio().send(reqMethod: "post", path: "member/getAuthCode", body: {"userid": email, "user_name": username, "cellphone": cellphone })).data;

        print(d['result']);
        var status = d['status'];
        msg = d['msg'];
        if(msg != "") {
          CustomAlert.showAlert(context: context, msg: msg );
          //showInSnackBar('발송 되었습니다.',context);
        } else {
          CustomAlert.showAlert(context: context, msg: '인증번호가 발급되었습니다. 카카오톡을 확인하세요' );

        }

      } catch (e) {
        loading = false;
        notifyListeners();
        //print(e);
        CustomAlert.showAlert(context: context, msg: '인증번호가 발급되었습니다. 카카오톡을 확인하세요' );
      }
      loading = false;
      notifyListeners();
    } else {
      showInSnackBar('휴대폰 번호를 입력해 주세요.', context);
    }

  }
  setAuthCodeCheck(BuildContext context) async {

    if (cellphone == null) {

    }
    if (authcode != '') {
      loading = true;
      notifyListeners();
      try {

        print(authcode);
        print(cellphone);

        final d = (await CustomDio().send(reqMethod: "post", path: "member/getAuthCodeCheck", body: {"auth_code": authcode,"cellphone": cellphone  })).data;

        //print(d['result']);
        var status = d['status'];
        var msg = d['msg'];
        if(msg != "") {
          CustomAlert.showAlert(context: context, msg: msg );
          //showInSnackBar('발송 되었습니다.',context);
          if (status == "SUCCESS") {
            authCheck = true;
          }

        }

      } catch (e) {
        loading = false;
        notifyListeners();
        print(e);
        showInSnackBar(
            'Error', context);
      }
      loading = false;
      notifyListeners();
    } else {
      showInSnackBar('인증 번호를 입력해 주세요.', context);
    }

  }

  editPass(BuildContext context) async {
    print(password);
    print(cPassword);

    if (password == cPassword) {
      loading = true;
      notifyListeners();

      final d = (await CustomDio().send(
          reqMethod: "post", path: "member/editpass",
          body: {"member_seq": member_seq, "password": password})).data;

      //print(d['result']);
      var status = d['status'];
      if (status == "SUCCESS") {
        loading = false;
        notifyListeners();
        showInSnackBar('비밀번호가 변경되었습니다.', context);
      }
    }else {
      loading = false;
      showInSnackBar('비밀번호가 다릅니다.', context);
    }

  }

  goOut(BuildContext context) async {

    loading = true;
    notifyListeners();

    final d = (await CustomDio().send(
        reqMethod: "post", path: "member/goout",
        body: {"member_seq": member_seq, "reason": username})).data;

    //print(d['result']);
    var status = d['status'];
    if (status == "SUCCESS") {
      loading = false;
      notifyListeners();

      await GetStorage().remove("member");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return  Login();
          },
        ),
            (route) => false,
      );

    }

  }



  setMemberSeq(val) {
    member_seq = val;
    notifyListeners();
  }
  setEmail(val) {
    email = val;
    notifyListeners();
  }

  setPassword(val) {
    password = val;
    notifyListeners();
  }

  setName(val) {
    username = val;
    notifyListeners();
  }

  setConfirmPass(val) {
    cPassword = val;
    notifyListeners();
  }

  setCellphone(val) {
    cellphone = val;
    notifyListeners();
  }
  setAuthCode(val) {
    authcode = val;
    notifyListeners();
  }


  void showInSnackBar(String value, context) {
   // ScaffoldMessenger.of(context).removeCurrentSnackBar();
    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
