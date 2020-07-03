class CustlistItem{

  String cname;
  String iname;
  String pno;
  String address;
  String location;
  String amount;

  CustlistItem({this.cname, this.iname, this.pno, this.address, this.location, this.amount});

}

class CustList{
  List<CustlistItem> custList;

  CustList({this.custList});

}