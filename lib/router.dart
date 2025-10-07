import 'package:go_router/go_router.dart';
import 'package:veda_main/screens/contactus.dart';
import 'package:veda_main/screens/hardwareandnetworkingpg.dart';
import 'package:veda_main/screens/home.dart';
import 'package:veda_main/screens/softwarepg.dart';
import 'package:veda_main/screens/webapppg.dart';

class AppRoutes {
  // ignore: unused_element
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const VedaHomePage()),
      GoRoute(path: '/webpage', builder: (context, state) => const Webapppg()),
      GoRoute(
        path: '/softwarepage',
        builder: (context, state) => const Softwarepg(),
      ),
      GoRoute(
        path: '/hardwarepage',
        builder: (context, state) => const Hardwareandnetworkingpg(),
      ),
      GoRoute(
        path: '/contactus',
        builder: (context, state) => const ContactUsPage(),
      ),
    ],
  );
}
