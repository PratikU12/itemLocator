import 'package:flutter/material.dart';
import 'package:itemlocator/services/location.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:itemlocator/models/cust.dart';


class CustForm extends StatefulWidget {
  @override
  _CustFormState createState() => _CustFormState();
}

class _CustFormState extends State<CustForm> {

  List<Cust> custs = [];
  Cust cust;
  DatabaseReference custRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    cust = Cust('','','','','','','','');
    final FirebaseDatabase database = FirebaseDatabase.instance;
    custRef = database.reference().child('custs');
    custRef.onChildAdded.listen(_onEntryAdded);
  }

  _onEntryAdded(Event event) {

    setState(() {
      custs.add(Cust.fromSnapshot(event.snapshot));
    });
  }

  void handleSubmit() {
    final FormState form = formKey.currentState;

    if(form.validate()){

      form.save();
      form.reset();
      custRef.push().set(cust.toJson());
    }
  }


  @override

  Widget build(BuildContext context) {

    return Form(

            key: formKey,
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: <Widget>[
                SizedBox(height: 30.0),
                Text('Add New Entry', style: TextStyle(fontSize: 18.0), textAlign: TextAlign.center,),
                SizedBox(height: 20.0),
                TextFormField(
                  style: TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Customer Name *',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(12.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  onSaved: (val) => cust.cname = val,
                  validator: (val) => val.isEmpty ? 'Please enter Customer Name' : null,

                ),
                SizedBox(height: 20.0),

                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.person_outline),
                    labelText: 'Your Name *',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(12.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  onSaved: (val) => cust.name = val,
                  validator: (val) => val.isEmpty ? 'Please Enter your Name':null,
                ),
                SizedBox(height: 20.0),
                //iname

                TextFormField(
                  style: TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    icon: Icon(Icons.laptop),
                    labelText: 'Item name *',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(12.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Please enter Item Name' : null,
                  onSaved: (val) => cust.iname = val,
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  style: TextStyle(color: Colors.black87),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Phone Number *',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(12.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Please enter Phone Number' : null,
                  onSaved: (val) => cust.pno = val,
                ),
                SizedBox(height: 20.0),
                //amount

                TextFormField(
                  style:TextStyle(color: Colors.black87),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    icon: Icon(Icons.attach_money),
                    labelText: 'Amount Received *',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(12.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  onSaved: (val) => cust.amount = val,
                  validator: (val) => val.isEmpty ? 'Please Enter Amount': null,
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.home),
                    labelText: 'Customer Address *',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(12.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  onSaved: (val) => cust.address = val,
                  validator: (val) => val.isEmpty ? 'Please Enter Address':null,
                ),
                SizedBox(height: 40.0),

                RaisedButton(
                  color: Colors.blueAccent[400],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.black54)),
                  child: Text('Location', style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    cust.location = await getLocation();
                  }
                ),
                SizedBox(height: 20.0),

                  RaisedButton(
                       color: Colors.blueAccent[400],
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.black54)),
                       child: Text('Submit', style: GoogleFonts.roboto(textStyle: TextStyle(color: Colors.white, letterSpacing: .5))),
                       onPressed: (){
                         cust.time = DateTime.now().toString();
                         handleSubmit();
                         Navigator.pop(context);
                       },
                ),
              ],
            )
        );
    }
  }
