import 'package:get/get.dart';

import 'factories/factories.dart';

class Routes {
  static const String home = '/';
  static const String signUp = '/sign-up';

  static List<GetPage> pages = [
    GetPage(name: home, page: makeHomePage, binding: makeHomeBinding()),
    GetPage(name: signUp, page: makeSignUpPage, binding: makeSignUpBinding()),
  ];
}
