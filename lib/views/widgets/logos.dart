import 'package:flutter/material.dart';

Widget trip2(BuildContext context) {
  return Image.asset(
    "assets/logo/trip2.png",
    width: MediaQuery.of(context).size.width,
    // height: 200,
    fit: BoxFit.cover,
  );
}

Widget trip3(BuildContext context) {
  return Image.asset(
    "assets/logo/trip3.png",
    width: 100,
    height: 100,
    fit: BoxFit.cover,
  );
}

IconButton back_btn(context) {
  return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.chevron_left));
}
