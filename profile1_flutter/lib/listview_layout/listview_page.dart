import 'package:flutter/material.dart';
import 'package:profile1_flutter/gridview_layout/girdview_page.dart';

class ListViewPage extends StatelessWidget {

  List<Product> list = List.generate(100, (index) => Product(id: index + 1, name: "Home number: ${index+1}"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List View Builder"),
      ),
      body: Center(
        child: ListView.builder(
            itemBuilder: (context, index) => ListTile(
              leading: Icon(Icons.home_outlined, color: Colors.red,),
              title: Text(list[index].name),
              subtitle: Text("Phone: 0905172802"),
            ),
        ),
      ),
    );
  }
}

class ListViewSaperatedPage extends StatelessWidget {

  List<Product> list = List.generate(100, (index) => Product(id: index + 1, name: "Trash: ${index+1}"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView Saperated Demo"),
      ),
      body: Center(
        child: ListView.separated(  //giữa các item sẽ có khoảng trắng
            itemBuilder:(context, index) => ListTile(
              leading: Icon(Icons.delete, color: Colors.red,),
              title: Text(list[index].name, style: TextStyle(fontSize: 25, color: Colors.blue),),
              subtitle: Text("Phone: 0905172802", style: TextStyle(color: Colors.black, fontSize: 20),),
            ) ,
            separatorBuilder: (context, index) => Divider(color: Colors.purple, thickness: 2,), // đường khoảng cách
            itemCount: list.length,
        ),
      ),
    );
  }
}

