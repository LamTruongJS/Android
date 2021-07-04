import 'dart:ui';

import 'package:flutter/material.dart';

class MatHang{
  int id;
  String name;
  Color color;
  int price;
  MatHang({this.id, this.name, this.color, this.price});
  factory MatHang.fromJson(Map<String, dynamic> json){
    int colorIndex= json['color'] as int;
    return MatHang(
      id: json['id'] as int,//map-->json --> "id":1
      name: json['name'] as String, //map-->json --> "name":"Táo"
      color: Colors.primaries[colorIndex],//map-->json --> "color":2
      price: json['price'] as int //map-->json --> "price":2000
    );
  }
  // map là chuỗi json nhưng ko có dấu nháy
  //json là chuỗi nhưng có dấu nháy''
  //from Json: Map--> object
  //to Json: this--> Map

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'name': name,
      'color': Colors.primaries.indexOf(color),
      'price': price
    };
  }
}
class MatHangDatabase{
  List<MatHang> listMH;
   MatHangDatabase(this.listMH);
   factory MatHangDatabase.fromJson(Map<String, dynamic> json){
     var list = json["mat_hangs"] as List;
     var mhs= list.map((e)=> MatHang.fromJson(e)).toList();
     return MatHangDatabase(mhs);
   }
   Map<String, dynamic> toJson(){
     return{
       "mat_hangs": List<dynamic>.from(listMH.map((e) => e.toJson()))
       //dynamic: List<Map<string,dynamic>>: là các đối tượng trong map
     };
   }
}
