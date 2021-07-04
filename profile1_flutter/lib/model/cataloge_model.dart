import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class MatHang{
  int id;
  String name;
  Color color;
  int price;

  MatHang({this.id, this.name, this.color, this.price});
}
List<String> names=["Tao", "Xoai","Cam","Buoi Da Xanh", "Sau rieng","Man","Dao","DuaHau","Xoai cat","Dua xiem","Mang cut","Buoi nam roi"];
class CatalogeModel{
  static List<MatHang> matHangs= List.generate(names.length,
          (index) => MatHang(
            id: index,
            name: names[index],
            color: Colors.primaries[index % Colors.primaries.length],
            price: 25,
          )
  );
}
