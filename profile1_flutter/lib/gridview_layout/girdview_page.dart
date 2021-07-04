import 'package:flutter/material.dart';

//product
class Product{
  int id;
  String name;

  Product({this.id, this.name});
}


class MyGridViewPage extends StatelessWidget {
// Danh sach product
  List<Product> list = List.generate(1000, //số lượng sản phẩm
          (index) => Product(id: index+1, name: "Product: ${index+1}"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView Demo"),
      ),
      body: GridView.count(
          crossAxisCount: 3, //số sản phẩm trên 1 hàng
          mainAxisSpacing: 5,
        children: list.map((e) => Card(
          child: Center(
            child: Text(e.name,style: TextStyle(fontSize: 15, color: Colors.red),),
          ),
        )).toList()
      ),
    );
  }
}

class MyGridViewExtendPage extends StatelessWidget {
  List<Product> list = List.generate(1000,
          (index) => Product(id: index+1, name: "Product: ${index+1}"));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GirdExtend Demo"),
      ),
      body:GridView.extent(maxCrossAxisExtent: 300, // Chiều rộng tối đa của ô
        children: list.map((e) => Card(
          child: Center(
            child: Text(e.name),
          ),
        )).toList(),
      ),
    );
  }
}

