import 'package:flutter/material.dart';

AppBar appbar() {
  return AppBar(
    backgroundColor: Colors.lightGreen,
    elevation: 1.0,
    title: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
  );
}
