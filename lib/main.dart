import 'package:itemlocator/screens/wrapper.dart';
import 'package:itemlocator/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:itemlocator/models/user.dart';

void main() =>runApp(ItemLocator());


class ItemLocator extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}