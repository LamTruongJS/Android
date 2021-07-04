import 'package:baitap03_onthi/models/nongsan_model.dart';
import 'package:baitap03_onthi/pages/danhsach_nongsan.dart';
import 'package:baitap03_onthi/pages/giohang_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class ChitietNongSan extends StatefulWidget {
  final NongSanSnapshot nongSanSnapshot;
  const ChitietNongSan({Key key, this.nongSanSnapshot}) : super(key: key);

  @override
  _ChitietNongSanState createState() => _ChitietNongSanState();
}

class _ChitietNongSanState extends State<ChitietNongSan> {
  bool a =true;
  List<NongSan> nongsan = List<NongSan>();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(Icons.list_alt_outlined),
            onTap: ()=> Navigator.pop(context),
          ),

          title: Text(widget.nongSanSnapshot.nongSan.tenns),
          actions: [
            GestureDetector(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.shopping_cart,
                        size: 48,
                        color: Colors.white,
                      )),
                  Text(
                    "${giohang.length}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.redAccent),
                  )
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GioHangPage(giohang))
                );


              },
            )

          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(widget.nongSanSnapshot.nongSan.url,width: 600,height: 500,),
              Text(widget.nongSanSnapshot.nongSan.tenns,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.blue),),
              SizedBox(height: 10,),
              Text(widget.nongSanSnapshot.nongSan.mota,style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20,)),
              SizedBox(height: 10,),
              //định dạng số
              Text("Giá: " + NumberFormat.currency(locale: 'vi').format(widget.nongSanSnapshot.nongSan.gia)+ "/kg" ,style: TextStyle(color: Colors.redAccent,fontSize: 20,) ),
              SizedBox(height: 10,),
              TextButton(onPressed: () {
                setState(() {
                  var item =  NongSan(
                    tenns: widget.nongSanSnapshot.nongSan.tenns,
                    mota: widget.nongSanSnapshot.nongSan.mota,
                    soluong: 1,
                    gia: widget.nongSanSnapshot.nongSan.gia,
                    url: widget.nongSanSnapshot.nongSan.url,
                  );

                  if(!giohang.contains(item))
                    giohang.add(item);
                  else giohang.remove(item);

                });
              },
                child: Icon(Icons.add_shopping_cart,size: 50,),
              )
            ],
          ),
        ),
      ),
    );
  }

}
