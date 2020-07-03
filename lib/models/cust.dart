import 'package:firebase_database/firebase_database.dart';

class Cust{

  String cname;
  String iname;
  String pno;
  String address;
  String location;
  String amount;
  String time;
  String name;

  Cust(this.cname, this.iname, this.pno, this.address, this.location, this.amount, this.time, this.name);

  Cust.fromSnapshot(DataSnapshot snapshot)
  :
        cname = snapshot.value['cname'],
        iname = snapshot.value['iname'],
        pno = snapshot.value['pno'],
        address = snapshot.value['address'],
        location = snapshot.value['location'],
        amount = snapshot.value['amount'],
        time = snapshot.value['time'],
        name = snapshot.value['name'];

    toJson(){
      return{
        'cname': cname,
        'iname':iname,
        'pno':pno,
        'address':address,
        'location': location,
        'amount':amount,
        'time':time,
        'name':name,
      };
    }

  }
