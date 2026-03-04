import 'package:go_router/go_router.dart';
import 'package:veda_main/screens/pagenotfound.dart';
import 'package:veda_main/screens/about.dart';
import 'package:veda_main/screens/contactus.dart';
import 'package:veda_main/screens/hardwareandnetworkingpg.dart';
import 'package:veda_main/screens/home.dart';
import 'package:veda_main/screens/services.dart';
import 'package:veda_main/screens/softwarepg.dart';
import 'package:veda_main/screens/webapppg.dart';
import 'package:veda_main/screens/whyus.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const VedaHomePage(),
      ),
      GoRoute(
        path: '/about',
        name: 'about',
        builder: (context, state) => const AboutUsPage(),
      ),
      GoRoute(
        path: '/services',
        name: 'services',
        builder: (context, state) => const ServicesPage(),
      ),
      GoRoute(
        path: '/why-us',
        name: 'why-us',
        builder: (context, state) => const WhyUsPage(),
      ),
      GoRoute(
        path: '/webapp',
        name: 'webapp',
        builder: (context, state) => const Webapppg(),
      ),
      GoRoute(
        path: '/software',
        name: 'software',
        builder: (context, state) => const Softwarepg(),
      ),
      GoRoute(
        path: '/hardware',
        name: 'hardware',
        builder: (context, state) => const Hardwareandnetworkingpg(),
      ),
      GoRoute(
        path: '/contact-us',
        name: 'contact-us',
        builder: (context, state) => const ContactUsPage(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
}
