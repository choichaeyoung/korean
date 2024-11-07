import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:korean/auth/login/login.dart';
import 'package:korean/components/password_text_field.dart';
import 'package:korean/components/text_form_builder.dart';
import 'package:korean/utils/validation.dart';
import 'package:korean/view_models/auth/register_view_model.dart';
import 'package:korean/widgets/indicators.dart';

class Userid extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Userid> {
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
              '아이디 찾기',
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

                GestureDetector(
                  onTap: () => Navigator.pop(context),
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
            prefix: Ionicons.phone_portrait_outline,
            hintText: "휴대폰번호",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validatePhone,
            onSaved: (String val) {
              viewModel.setCellphone(val);
            },

          ),
          SizedBox(height: 20.0),



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
                '아이디찾기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () => viewModel.pUerid(context),
            ),
          ),
        ],
      ),
    );
  }
}
