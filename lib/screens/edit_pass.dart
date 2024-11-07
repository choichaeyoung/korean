import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:korean/components/text_form_builder.dart';
import 'package:korean/models/member.dart';

import 'package:korean/utils/validation.dart';
import 'package:korean/view_models/auth/register_view_model.dart';
import 'package:korean/widgets/indicators.dart';

class EditPass extends StatefulWidget {
  final Member? member;

  const EditPass({this.member});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditPass> {
  //UserModel? user;

  bool init = false;

  @override
  Widget build(BuildContext context) {
    RegisterViewModel viewModel = Provider.of<RegisterViewModel>(context);
    if(init == false) {
      viewModel.setMemberSeq(widget.member!.member_seq);
    }
    init == true;

    return LoadingOverlay(
      progressIndicator: circularProgress(context),
      isLoading: viewModel.loading,
      child: Scaffold(
        key: viewModel.scaffoldKey,
        appBar: AppBar(
          centerTitle: false,
          title: Text("비밀번호변경",style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700,fontSize: 18.0,)),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: GestureDetector(
                  onTap: () => viewModel.editPass(context),
                  child: Text(
                    '변경',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          children: [

            SizedBox(height: 10.0),
            buildForm(viewModel, context)
          ],
        ),
      ),
    );
  }

  buildForm(RegisterViewModel viewModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: viewModel.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormBuilder(
              enabled: !viewModel.loading,
              initialValue: viewModel.password,
              prefix: Ionicons.lock_open_outline,
              hintText: "비밀번호",
              textInputAction: TextInputAction.next,
              validateFunction: Validations.validatePassword,
              onSaved: (String val) {
                viewModel.setPassword(val);
              },
            ),
            SizedBox(height: 10.0),
            TextFormBuilder(
              initialValue: viewModel.cPassword,
              enabled: !viewModel.loading,
              prefix: Ionicons.lock_open_outline,

              hintText: "비밀번호 확인",
              textInputAction: TextInputAction.next,
              validateFunction: Validations.validatePassword,
              onSaved: (String val) {
                viewModel.setConfirmPass(val);
              },
            ),
            SizedBox(height: 10.0),

          ],
        ),
      ),
    );
  }
}
