import 'package:itemlocator/services/auth.dart';
import 'package:itemlocator/shared/constants.dart';
import 'package:itemlocator/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:itemlocator/models/cust.dart';


class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String name = '';



  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text('Create an Account!'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person, color: Colors.white,),
            label: Text('Log In', style: TextStyle(color: Colors.white),),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                cursorColor: Colors.black87,
                decoration: textInputDecoration.copyWith(hintText: 'email',icon: Icon(Icons.alternate_email, color: Colors.black,)),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                cursorColor: Colors.black87,
                decoration: textInputDecoration.copyWith(hintText: 'password',icon: Icon(Icons.arrow_forward_ios, color: Colors.black)),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                cursorColor: Colors.black87,
                decoration: textInputDecoration.copyWith(hintText: 'Name',icon: Icon(Icons.person, color: Colors.black)),
                validator: (val) => val.isEmpty ? 'Enter a Name' : null,
                onChanged: (val) {
                  setState(() => name = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.blueGrey,
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result == null) {
                        setState(() {
                          loading = false;
                          error = 'Please supply a valid email';
                        });
                      }
                    }
                  }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}