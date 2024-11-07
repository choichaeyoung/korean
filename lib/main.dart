//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:korean/components/life_cycle_event_handler.dart';
import 'package:korean/landing/landing_page.dart';
import 'package:korean/screens/mainscreen.dart';
import 'package:korean/services/user_service.dart';
//import 'package:korean/utils/config.dart';
import 'package:korean/utils/constants.dart';
import 'package:korean/utils/providers.dart';
import 'package:korean/view_models/theme/theme_view_model.dart';
import 'package:get_storage/get_storage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Config.initFirebase();

  //AuthRepository.initialize(appKey: 'bc9df54a7e5b9471fd0917cbac264800');
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isLogin = false;
  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addObserver(
      LifecycleEventHandler(
        detachedCallBack: () => UserService().setUserStatus(false),
        resumeCallBack: () => UserService().setUserStatus(true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<ThemeProvider>(
        builder: (context, ThemeProvider notifier, Widget? child) {
          return MaterialApp(
            title: Constants.appName,
            debugShowCheckedModeBanner: false,
            theme: themeData(
              notifier.dark ? Constants.darkTheme : Constants.lightTheme,
            ),

            //supportedLocales: [
            //  Locale('ko'), // English
            //],
            home: Landing(),
          );
        },
      ),
    );
  }
  ThemeData themeData(ThemeData theme) {
    return theme.copyWith(
      textTheme: GoogleFonts.nanumGothicTextTheme(
        theme.textTheme,
      ),
    );
  }
}

