class Routes {
  static const String home = '/';

  static List<GetPage> pages = [
    GetPage(
      name: home,
      page: () => const MyHomePage(title: 'Fly Checklist'),
    ),
  ];
}
