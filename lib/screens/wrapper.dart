import 'package:itemlocator/models/user.dart';
import 'package:itemlocator/screens/authenticate/authenticate.dart';
import 'package:itemlocator/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }

  }
}