import 'dart:async';
import'package:flutter/material.dart';
import 'package:itemlocator/models/cust.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:itemlocator/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:itemlocator/models/user.dart';



class ShowCust extends StatefulWidget {
  @override
  _ShowCustState createState() => _ShowCustState();
}

class _ShowCustState extends State<ShowCust> {

  FirebaseUser currentUser;
  final AuthService _auth = AuthService();
  List<Cust> allData = <Cust>[];

  @override
  // ignore: missing_return
  Future  initState() {
    DatabaseReference custRef = FirebaseDatabase.instance.reference();
    custRef.child('custs').once().then((DataSnapshot snap)  {

      var keys = snap.value.keys;
      var data = snap.value;
      allData.clear();
      for(var key in keys) {
         allData.add(new Cust(data[key]['cname'],
            data[key]['iname'],
            data[key]['pno'],
            data[key]['address'],
            data[key]['location'],
            data[key]['amount'],
            data[key]['time'],
            data[key]['name']));
      }

      setState(() {
        print('Length: ${allData.length}');


      });

    });
    super.initState();
    _loadCurrentUser();
  }


  _onEntryAdded(Event event){

    setState(() {
      allData.add(new Cust.fromSnapshot(event.snapshot));
      allData.sort((c2,c1) => c1.time.compareTo(c2.time));

    });
  }

  Future<void> _onRefresh() {
    allData.clear();
    DatabaseReference custRef = FirebaseDatabase.instance.reference();
    custRef.child('custs').onChildAdded.listen(_onEntryAdded);
    Completer<Null> completer = new Completer<Null>();
    Timer timer = new Timer(new Duration(seconds: 3), () {
      completer.complete();
    });
    return completer.future;

  }
  
  void _loadCurrentUser() async{
    
     await FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        this.currentUser = user;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    var query = FirebaseDatabase.instance.reference().child('custs').orderByChild('time');
    return Scaffold(
      body: new Container(
        color: Colors.lightBlueAccent,
        child: new StreamBuilder(
          stream: query.onValue,
          // ignore: missing_return
          builder: (context, snap) {
            if (snap.hasData && !snap.hasError &&
                snap.data.snapshot.value != null) {
              Map data = snap.data.snapshot.value;
              List cust = [];

              return RefreshIndicator(
                child: ListView.builder(
                  //key: new Key(),
                  itemCount: allData.length,
                  itemBuilder: (context, index) {
                    return ui(
                      allData[index].cname,
                      allData[index].iname,
                      allData[index].pno,
                      allData[index].address,
                      allData[index].location,
                      allData[index].amount,
                      allData[index].time,
                      allData[index].name,
                    );
                  },
                ),
                onRefresh: _onRefresh,
              );

            } else
              return Center(child: Text('No Data Available'));
          }
        ),
      ),
      backgroundColor: Colors.lightBlueAccent,
    );
  }


  Widget ui(String cname, String iname, String pno, String address, String location, String amount, String time, String name){
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
        child: ListTile(
          leading: Icon(Icons.account_balance_wallet),
          title: Text(cname),
          subtitle: Text('Amount Collected: Rs. $amount\n'
              'Time Added: $time'),
          isThreeLine: true,
          trailing: Icon(Icons.arrow_forward),
          onTap: (){
            showDialog(context: context,
               barrierDismissible: false,
              builder: (BuildContext context){
                return AlertDialog(
                  title: Text('Customer Details'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('Customer Name: $cname\n'),
                        Text('Item Delivered: $iname\n'),
                        Text('Phone no. : $pno\n'),
                        Text ('Customer Address: $address\n'),
                        Text('Location: $location\n'),
                        Text('Amount Received: $amount\n'),
                        Text('Updated by: $name\n'),
                        Text('Time Added: $time'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('OK'),
                      onPressed: (){ Navigator.of(context).pop();},
                    ),
                  ],

                );
              },);
          },
        ),
      ),
    );
  }

  }


