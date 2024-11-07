import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:korean/auth/login/login.dart';
import 'package:korean/components/password_text_field.dart';
import 'package:korean/components/text_form_builder.dart';
import 'package:korean/utils/validation.dart';
import 'package:korean/view_models/auth/register_view_model.dart';
import 'package:korean/widgets/indicators.dart';
import 'package:korean/utils/constants.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    RegisterViewModel viewModel = Provider.of<RegisterViewModel>(context);
    return LoadingOverlay(
      progressIndicator: circularProgress(context),
      isLoading: viewModel.loading,
      child: Scaffold(
        key: viewModel.scaffoldKey,
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 10),
            Text(
              '환영합니다! \n계정을 만들고 친구들과 소통하세요',
              style: TextStyle(
                /*fontWeight: FontWeight.bold,*/
                fontSize: 16,
                color:Color(0xff75c5c1),
              ),
            ),
            SizedBox(height: 30.0),
            buildForm(viewModel, context),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '회원이신가요?  ',
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      CupertinoPageRoute(
                        builder: (_) => Login(),
                      ),
                    );
                  },
                  child: Text(
                    '로그인',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      /*color: Theme.of(context).colorScheme.secondary,*/
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

  buildForm(RegisterViewModel viewModel, BuildContext context) {
    // viewModel.init(context);

    return Form(
      key: viewModel.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.person_outline,
            hintText: "사용자명",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateName,
            onSaved: (String val) {
              viewModel.setName(val);
            },
            focusNode: viewModel.usernameFN,
            nextFocusNode: viewModel.emailFN,
          ),
          SizedBox(height: 20.0),
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.mail_outline,
            hintText: "이메일",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateEmail,
            onSaved: (String val) {
              viewModel.setEmail(val);
            },
            focusNode: viewModel.emailFN,
            nextFocusNode: viewModel.cellphoneFN,
          ),
          SizedBox(height: 20.0),

          ListTile(
            contentPadding: EdgeInsets.all(0.0),
            title: Container(
              width: MediaQuery.of(context).size.width/2,
              child: TextFormBuilder(
                enabled: !viewModel.loading,
                prefix: Ionicons.phone_portrait_outline,
                hintText: "휴대폰번호",
                textInputAction: TextInputAction.next,
                validateFunction: Validations.validatePhone,
                onSaved: (String val) {
                  viewModel.setCellphone(val);
                },
                focusNode: viewModel.cellphoneFN,
                nextFocusNode: viewModel.passFN,
              ),
            ),
            trailing: ElevatedButton(
              style:ElevatedButton.styleFrom(
                minimumSize:Size(30, 24),
                backgroundColor: Constants.mainBTN,

              ),
              onPressed: () {
                viewModel.setAuthCodeSend(context);
              },
              child: Text("인증번호",style: TextStyle(color: Colors.white,)),
            ),
          ),
          SizedBox(height: 20.0),
          ListTile(
            contentPadding: EdgeInsets.all(0.0),
            title: Container(
              width: MediaQuery.of(context).size.width/2,
              child: TextFormBuilder(
                enabled: !viewModel.loading,
                prefix: Ionicons.phone_portrait_outline,
                hintText: "인증번호",
                textInputAction: TextInputAction.next,
                validateFunction: Validations.validateAuth,
                onSaved: (String val) {

                  viewModel.setAuthCode(val);
                },
              ),
            ),
            trailing: ElevatedButton(
              style:ElevatedButton.styleFrom(
                minimumSize:Size(30, 24),
                backgroundColor: Constants.mainBTN,

              ),
              onPressed: () {
                viewModel.setAuthCodeCheck(context);
              },
              child: Text("인증하기",style: TextStyle(color: Colors.white,)),
            ),
          ),
          SizedBox(height: 20.0),
          PasswordFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.lock_closed_outline,
            suffix: Ionicons.eye_outline,
            hintText: "Password",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validatePassword,
            obscureText: true,
            onSaved: (String val) {
              viewModel.setPassword(val);
            },
            focusNode: viewModel.passFN,
            nextFocusNode: viewModel.cPassFN,
          ),
          SizedBox(height: 20.0),
          PasswordFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.lock_open_outline,
            hintText: "Confirm Password",
            textInputAction: TextInputAction.done,
            validateFunction: Validations.validatePassword,
            submitAction: () => viewModel.register(context),
            obscureText: true,
            onSaved: (String val) {
              viewModel.setConfirmPass(val);
            },
            focusNode: viewModel.cPassFN,
          ),
          SizedBox(height: 25.0),
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
              child: Text(
                '회원가입',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () => viewModel.register(context),
            ),
          ),
        ],
      ),
    );
  }
}
