import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:korean/view_models/auth/login_view_model.dart';
import 'package:korean/view_models/auth/posts_view_model.dart';
import 'package:korean/view_models/auth/register_view_model.dart';
import 'package:korean/view_models/conversation/conversation_view_model.dart';
import 'package:korean/view_models/profile/edit_profile_view_model.dart';
//import 'package:korean/view_models/status/status_view_model.dart';
import 'package:korean/view_models/theme/theme_view_model.dart';
import 'package:korean/view_models/user/user_view_model.dart';
import 'package:korean/view_models/home_provider.dart';
import 'package:korean/view_models/exam_provider.dart';
import 'package:korean/view_models/profile_provider.dart';
import 'package:korean/utils/constants.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => RegisterViewModel()),
  ChangeNotifierProvider(create: (_) => LoginViewModel()),
  ChangeNotifierProvider(create: (_) => PostsViewModel()),
  ChangeNotifierProvider(create: (_) => EditProfileViewModel()),
  //ChangeNotifierProvider(create: (_) => ConversationViewModel()),
  //ChangeNotifierProvider(create: (_) => StatusViewModel()),
  ChangeNotifierProvider(create: (_) => UserViewModel()),
  ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ChangeNotifierProvider(create: (_) => HomeProvider()),
  ChangeNotifierProvider(create: (_) => ExamProvider()),
  ChangeNotifierProvider(create: (_) => ProfileProvider()),
];
