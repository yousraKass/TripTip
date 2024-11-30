import 'package:flutter/material.dart';
import 'views/OfferScreen.dart';
import 'package:triptip/views/ReviewScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      initialRoute: OfferDetailsPage.pageRoute,
      routes: {
        OfferDetailsPage.pageRoute : (ctx) => OfferDetailsPage(),
        ReviewScreen.pageRoute : (ctx) => ReviewScreen(),

      },
    );
  }
}
