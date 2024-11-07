import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:korean/auth/register/register.dart';
import 'package:korean/auth/register/pass.dart';
import 'package:korean/auth/register/userid.dart';
import 'package:korean/components/password_text_field.dart';
import 'package:korean/components/text_form_builder.dart';
import 'package:korean/utils/validation.dart';
import 'package:korean/view_models/auth/login_view_model.dart';
import 'package:korean/widgets/indicators.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = Provider.of<LoginViewModel>(context);

    return LoadingOverlay(
      progressIndicator: circularProgress(context),
      isLoading: viewModel.loading,
      child: Scaffold(
        backgroundColor: Colors.white,
        key: viewModel.scaffoldKey,
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 5),
            Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
            SizedBox(height: 30.0),
            /*Center(
              child: Text(
                '독서인',
                style: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),*/

            /*Center(
              child: Text(
                '너의 생각에 밑줄을 긋다.',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300,
                  /*color: Theme.of(context).colorScheme.secondary,*/
                  color:Color(0xff75c5c1),
                ),
              ),
            ),*/
            SizedBox(height: 25.0),
            buildForm(context, viewModel),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('회원이 아닌가요?'),
                SizedBox(width: 5.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (_) => Register(),
                      ),
                    );
                  },
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      //color: Theme.of(context).colorScheme.secondary,
                      color:Color(0xff75c5c1),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildForm(BuildContext context, LoginViewModel viewModel) {
    return Form(
      key: viewModel.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.mail_outline,
            hintText: "Email",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateEmail,
            onSaved: (String val) {
              viewModel.setEmail(val);
            },
            focusNode: viewModel.emailFN,
            nextFocusNode: viewModel.passFN,
          ),
          SizedBox(height: 15.0),
          PasswordFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.lock_closed_outline,
            suffix: Ionicons.eye_outline,
            hintText: "Password",
            textInputAction: TextInputAction.done,
            validateFunction: Validations.validatePassword,
            submitAction: () => viewModel.login(context),
            obscureText: true,
            onSaved: (String val) {
              viewModel.setPassword(val);
            },
            focusNode: viewModel.passFN,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child:  Row(
                  mainAxisAlignment : MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (_) => Userid(),
                          ),
                        );
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '아이디찾기',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:Color(0xff75c5c1),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (_) => Pass(),
                          ),
                        );
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '비밀번호찾기',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:Color(0xff75c5c1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            height: 45.0,
            width: 180.0,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  //Theme.of(context).colorScheme.secondary,
                  Color(0xff75c5c1),
                ),
              ),
              // highlightElevation: 4.0,
              child: Text(
                '로그인'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () => viewModel.login(context),
            ),
          ),
        ],
      ),
    );
  }
}

