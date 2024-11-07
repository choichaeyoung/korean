import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:korean/view_models/theme/theme_view_model.dart';
import 'package:korean/utils/router.dart';

import 'package:korean/models/member.dart';
import 'package:korean/screens/edit_pass.dart';
import 'package:korean/screens/goout.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korean/auth/login/login.dart';
import 'package:korean/utils/custom_alert.dart';
class Setting extends StatefulWidget {

  final Member? member;

  const Setting({this.member});

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {

            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_backspace),
        ),
        // backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: false,
        elevation: 0.0,
        title: Text(
          "환경설정",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700,fontSize: 18.0,),
        ),
      ),
      // backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[



            ListTile(
              title: Text(
                "비밀번호변경",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),


              trailing: IconButton(
                  onPressed: () {
                    MyRouter.pushPage(
                      context,
                      EditPass(member:widget.member),
                    );
                  },
                  icon: const Icon(Icons.arrow_right_alt_outlined)
              ),
            ),
            Divider(),
            ListTile(
                title: Text(
                  "고객센터",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.0),
                    Text(
                      "한국어학당 ",
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      "Tel : 02-830-8433 ",
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      "Email : deeplearn@deeplearn.co.kr",
                    ),
                  ],
                ),
                trailing: Icon(Icons.error)),
            /*Divider(),
            ListTile(
              title: Text(
                "Dark Mode",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              subtitle: Text("Use the dark mode"),
              trailing: Consumer<ThemeProvider>(
                builder: (context, notifier, child) => CupertinoSwitch(
                  onChanged: (val) {
                    notifier.toggleTheme();
                  },
                  value: notifier.dark,
                  activeColor: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),*/
            Divider(),
            ListTile(
              title: Text(
                "회원탈퇴",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),


              trailing: IconButton(
                  onPressed: () {
                    MyRouter.pushPage(
                      context,
                      GoOut(member:widget.member),
                    );
                  },
                  icon: const Icon(Icons.arrow_right_alt_outlined)
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                "",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),


              trailing: Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: GestureDetector(
                  onTap: () async {

                    var ddd = await CustomAlert.customChooseDialog(context: context, title: '로그아웃 하겠습니까?', data:['예', '아니요']);
                    //print('==>'+ddd.toString());
                    if(ddd==0){
                      //await firebaseAuth.signOut();
                      await GetStorage().remove("member");

                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Login()), (route) => false);
                    }
                  },
                  child: Text(
                    '로그아웃',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
