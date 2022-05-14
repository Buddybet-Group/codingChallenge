import 'package:get/get_navigation/src/routes/get_route.dart';
import '../views/screens/home.dart';

class Routes {
  static const toHomePage = '/';

  /// Returns a list of getX pages.
  static List<GetPage<dynamic>>? routes = [
    GetPage(name: Routes.toHomePage, page: () => const Home()),
  ];
}
