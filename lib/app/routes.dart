import 'package:coding_chal/views/screens/homepage.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Routes {
  static const toHomePage = '/';

  /// Returns a list of getX pages.
  static List<GetPage<dynamic>>? routes = [
    GetPage(name: Routes.toHomePage, page: () => const HomePage()),
  ];
}
