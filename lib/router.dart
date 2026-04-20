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
        name: 'Home',
        builder: (context, state) => const VedaHomePage(),
      ),
      GoRoute(
        path: '/About-Us',
        name: 'About-Us',
        builder: (context, state) => const AboutUsPage(),
      ),
      GoRoute(
        path: '/Our-Services',
        name: 'Services',
        builder: (context, state) => const ServicesPage(),
      ),
      GoRoute(
        path: '/Why-Us',
        name: 'Why-Us',
        builder: (context, state) => const WhyUsPage(),
      ),
      GoRoute(
        path: '/Web-Applications',
        name: 'Web-App',
        builder: (context, state) => const Webapppg(),
      ),
      GoRoute(
        path: '/Software-Applications',
        name: 'Software',
        builder: (context, state) => const Softwarepg(),
      ),
      GoRoute(
        path: '/Hardware&Networking',
        name: 'Hardware',
        builder: (context, state) => const Hardwareandnetworkingpg(),
      ),
      GoRoute(
        path: '/Contact-Us',
        name: 'Contact-Us',
        builder: (context, state) => const ContactUsPage(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
}
