import 'package:flutter/material.dart';
import 'package:itemlocator/screens/home/cust_form.dart';
import 'package:itemlocator/screens/home/cust_tile.dart';
import 'package:itemlocator/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {

     void _showCustomerPanel(){
       showModalBottomSheet(context: context, builder: (context) {
         return Container(
           padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
           child: CustForm(),
         );
       },
       isDismissible: true,
         isScrollControlled: true,
         enableDrag: true,
       );

     }


    return Scaffold(

        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          title: Text('Item Locator'),
          backgroundColor: Colors.black,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person, color: Colors.white,),
              label: Text('logout', style: TextStyle(color: Colors.white),),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: Container(child: ShowCust(),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/background.png'),),
        ),),
        floatingActionButton: FloatingActionButton(
            onPressed: () => _showCustomerPanel(),
            child: Icon(Icons.add),
            backgroundColor: Colors.lightGreen,),


    );


  }
}