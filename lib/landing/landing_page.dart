import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:korean/auth/login/login.dart';
import 'package:korean/auth/register/register.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korean/screens/mainscreen.dart';
class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {

  @override
  void initState() {
    super.initState();
    startNavigate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff75c5c1),
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60,),
            Text(
              '너와 나,',
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.w600,
                color:Colors.white,
                /*fontFamily: 'Ubuntu-Regular',*/
              ),
            ),
            SizedBox(height: 10,),
            Text(
              '한국어로 연결되다.',
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.w600,
                color:Colors.white,
                /*fontFamily: 'Ubuntu-Regular',*/
              ),
            ),
            SizedBox(height: 130,),

            /*Text(
              '  너의 생각에 밑줄을',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color:Color(0xff75c5c1),
                /*fontFamily: 'Ubuntu-Regular',*/
              ),
            ),*/
            // SizedBox(height: 60,),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 50.0,
                  // width: 162.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 130,),

            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        CupertinoPageRoute(
                          builder: (_) => Login(),
                        ),
                      );
                    },
                    child: Container(
                      height: 48.0,
                      width: 130.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        border: Border.all(color: Colors.white),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xff75c5c1),
                            Color(0xff75c5c1),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '로그인',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        CupertinoPageRoute(
                          builder: (_) => Register(),
                        ),
                      );
                    },
                    child: Container(
                      height: 45.0,
                      width: 130.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        border: Border.all(color: Colors.white),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            //Theme.of(context).colorScheme.secondary,
                            Color(0xff75c5c1),
                            Color(0xff75c5c1),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '회원가입',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }

  void startNavigate() async {
    final myModel = GetStorage().hasData("member");

    await Future.delayed(const Duration(seconds: 1));

    print(myModel);
    if (myModel) {
      /// there are login data saved
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) =>  TabScreen()),
              (Route<dynamic> route) => false);
    }
  }
}

