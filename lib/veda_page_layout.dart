import 'package:flutter/material.dart';
import 'package:veda_main/footer.dart';
import 'package:veda_main/topbar.dart';

class VedaPageLayout extends StatelessWidget {
  final Widget child; // page content
  final bool scrollable;

  const VedaPageLayout({
    super.key,
    required this.child,
    this.scrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Stack(
        children: [
          // page main content
          if (scrollable)
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: kToolbarHeight),
                  child,
                  const Footer(),
                ],
              ),
            )
          else
            Column(
              children: [
                const SizedBox(height: kToolbarHeight),
                Expanded(child: child),
                const Footer(),
              ],
            ),

          // fixed topbar
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: ReusableMenu(
                menuRoutes: {
                  'Home': '/',
                  'About': '/aboutus',
                  'Services': '/ourservices',
                  'Contact': '/contactus',
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
