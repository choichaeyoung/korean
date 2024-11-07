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

class GoOut extends StatefulWidget {
  final Member? member;

  const GoOut({this.member});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<GoOut> {
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
          title: Text("탈퇴하기",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700,fontSize: 18.0,),),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: GestureDetector(
                  onTap: () => viewModel.goOut(context),
                  child: Text(
                    '탈퇴',
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
            SizedBox(height: 20.0),
            Text(
              '탈퇴사유',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextFormField(
              initialValue: viewModel.username,
              decoration: InputDecoration(
                hintText: '탈퇴사유를 입력해주세요.',
                focusedBorder: UnderlineInputBorder(),
              ),
              maxLines: 4,
              onChanged: (val) => viewModel.setName(val),
            ),
            SizedBox(height: 10.0),

          ],
        ),
      ),
    );
  }
}
