import 'package:flutter/material.dart';
import 'package:veda_main/footer.dart';
import 'package:veda_main/letstalk.dart';
import 'package:veda_main/topbar.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: kToolbarHeight),
            child: Column(children: const [LetsTalkSection(), Footer()]),
          ),

          // Fixed TopBar
          ReusableMenu(
            menuRoutes: {
              'Home': '/',
              'About': '/aboutus',
              'Services': '/ourservices',
              'Contact': '/contactus',
            },
          ),
        ],
      ),
    );
  }
}
