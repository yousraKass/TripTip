import 'package:flutter/material.dart';

class AgencyScreen extends StatefulWidget {
  const AgencyScreen({super.key});

  static const pageRoute = "/agency_screen";

  @override
  State<AgencyScreen> createState() => _AgencyScreenState();
}

class _AgencyScreenState extends State<AgencyScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Agency Screen"),
        ),
        body: const Center(
          child: Text("Agency Screen"),
        ),
      ),
    );
  }
}