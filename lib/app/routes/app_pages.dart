import 'package:get/get.dart';

import 'package:chatapp/app/modules/authenticationscreen/bindings/authenticationscreen_binding.dart';
import 'package:chatapp/app/modules/authenticationscreen/views/authenticationscreen_view.dart';
import 'package:chatapp/app/modules/bottomnavigationscreen/bindings/bottomnavigationscreen_binding.dart';
import 'package:chatapp/app/modules/bottomnavigationscreen/views/bottomnavigationscreen_view.dart';
import 'package:chatapp/app/modules/calls/bindings/calls_binding.dart';
import 'package:chatapp/app/modules/calls/views/calls_view.dart';
import 'package:chatapp/app/modules/chatscreen/bindings/chatscreen_binding.dart';
import 'package:chatapp/app/modules/chatscreen/views/chatscreen_view.dart';
import 'package:chatapp/app/modules/forgotpassword/bindings/forgotpassword_binding.dart';
import 'package:chatapp/app/modules/forgotpassword/views/forgotpassword_view.dart';
import 'package:chatapp/app/modules/homescreen/bindings/homescreen_binding.dart';
import 'package:chatapp/app/modules/homescreen/views/homescreen_view.dart';
import 'package:chatapp/app/modules/login/bindings/home_binding.dart';
import 'package:chatapp/app/modules/login/views/login_view.dart';
import 'package:chatapp/app/modules/peopelesscreen/bindings/peopelesscreen_binding.dart';
import 'package:chatapp/app/modules/peopelesscreen/views/peopelesscreen_view.dart';
import 'package:chatapp/app/modules/registerscreen/bindings/registerscreen_binding.dart';
import 'package:chatapp/app/modules/registerscreen/views/registerscreen_view.dart';
import 'package:chatapp/app/modules/searchscreen/bindings/searchscreen_binding.dart';
import 'package:chatapp/app/modules/searchscreen/views/searchscreen_view.dart';
import 'package:chatapp/app/modules/settingsscreen/bindings/settingsscreen_binding.dart';
import 'package:chatapp/app/modules/settingsscreen/views/settingsscreen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTHENTICATIONSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => Loginscreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTERSCREEN,
      page: () => RegisterscreenView(),
      binding: RegisterscreenBinding(),
    ),
    GetPage(
      name: _Paths.HOMESCREEN,
      page: () => HomescreenView(),
      binding: HomescreenBinding(),
    ),
    GetPage(
      name: _Paths.AUTHENTICATIONSCREEN,
      page: () => AuthenticationscreenView(),
      binding: AuthenticationscreenBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOMNAVIGATIONSCREEN,
      page: () => BottomnavigationscreenView(),
      binding: BottomnavigationscreenBinding(),
    ),
    GetPage(
      name: _Paths.CALLS,
      page: () => CallsView(),
      binding: CallsBinding(),
    ),
    GetPage(
      name: _Paths.PEOPELESSCREEN,
      page: () => PeopelesscreenView(),
      binding: PeopelesscreenBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGSSCREEN,
      page: () => SettingsscreenView(),
      binding: SettingsscreenBinding(),
    ),
    GetPage(
      name: _Paths.CHATSCREEN,
      page: () => ChatscreenView(),
      binding: ChatscreenBinding(),
    ),
    GetPage(
      name: _Paths.FORGOTPASSWORD,
      page: () => ForgotpasswordView(),
      binding: ForgotpasswordBinding(),
    ),
    GetPage(
      name: _Paths.SEARCHSCREEN,
      page: () => SearchscreenView(),
      binding: SearchscreenBinding(),
    ),
  ];
}
