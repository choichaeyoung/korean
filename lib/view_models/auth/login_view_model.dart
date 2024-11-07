import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:korean/screens/mainscreen.dart';
import 'package:korean/services/auth_service.dart';
import 'package:korean/utils/validation.dart';
import 'package:korean/utils/custom_dio.dart';
import 'package:get_storage/get_storage.dart';

class LoginViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  String? email, password;
  FocusNode emailFN = FocusNode();
  FocusNode passFN = FocusNode();
  //AuthService auth = AuthService();

  login(BuildContext context) async {
    FormState form = formKey.currentState!;
    form.save();
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showInSnackBar('올바른 계정을 입력 하세요.',context);
    } else {
      loading = true;
      notifyListeners();
      try {
        //bool success = await auth.loginUser(
        //  email: email,
        //  password: password,
        //);
        final d = (await CustomDio().send(
            reqMethod: "post",
            path: "auth",
            body: {"userid": email, "password": password}))
            .data;

        print(d['result']);
        var status = d['status'];
        if(status == "SUCCESS") {
          //로그인처리
          await GetStorage().write("member", d['data']);

          Navigator.of(context).pushReplacement(
              CupertinoPageRoute(builder: (_) => TabScreen()));
        } else {
          loading = false;
          showInSnackBar('${d['message']}',context);

        }
      } catch (e) {
        loading = false;
        notifyListeners();
        print(e);
        //showInSnackBar('${auth.handleFirebaseAuthError(e.toString())}',context);
      }
      loading = false;
      notifyListeners();
    }
  }

  forgotPassword(BuildContext context) async {
    loading = true;
    notifyListeners();
    FormState form = formKey.currentState!;
    form.save();
    print(Validations.validateEmail(email));
    if (Validations.validateEmail(email) != null) {
      showInSnackBar('비밀번호를 재설정하려면 유효한 이메일을 입력하세요.',context);
    } else {
      try {
        //await auth.forgotPassword(email!);
        showInSnackBar('비밀번호를 재설정하려면  '
            '이메일을 확인하세요. ', context);
      } catch (e) {
        showInSnackBar('${e.toString()}', context);
      }
    }
    loading = false;
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

  void showInSnackBar(String value,context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
