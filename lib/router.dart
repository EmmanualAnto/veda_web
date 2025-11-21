import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        path: '/aboutus',
        name: 'aboutus',
        builder: (context, state) => const AboutUsPage(),
      ),
      GoRoute(
        path: '/ourservices',
        name: 'ourservices',
        builder: (context, state) => const ServicesPage(),
      ),
      GoRoute(
        path: '/whyus',
        name: 'whyus',
        builder: (context, state) => const WhyUsPage(),
      ),
      GoRoute(
        path: '/webpage',
        name: 'webpage',
        builder: (context, state) => const Webapppg(),
      ),
      GoRoute(
        path: '/softwarepage',
        name: 'softwarepage',
        builder: (context, state) => const Softwarepg(),
      ),
      GoRoute(
        path: '/hardwarepage',
        name: 'hardwarepage',
        builder: (context, state) => const Hardwareandnetworkingpg(),
      ),
      GoRoute(
        path: '/contactus',
        name: 'contactus',
        builder: (context, state) => const ContactUsPage(),
      ),
    ],
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('Page not found'))),
  );
}
