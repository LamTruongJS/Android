import 'package:baitap03_onthi/models/nongsan_model.dart';
import 'package:baitap03_onthi/pages/danhsach_nongsan.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class GioHangPage extends StatefulWidget {
  final List<NongSan>_giohang;
  GioHangPage(this._giohang);
  @override
  _GioHangPageState createState() => _GioHangPageState(this._giohang);
}

class _GioHangPageState extends State<GioHangPage> {
  _GioHangPageState(this._giohang);
  List<NongSan> _giohang;
  @override
  int tongTien = 0;
  bool dk = true;

  Widget build(BuildContext context) {
    _giohang.forEach((value) {
      if(dk == true)
        tongTien = tongTien + value.gia*value.soluong;
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Giỏ hàng'),
        actions: [
         GestureDetector(
          child: Icon(Icons.list_alt_outlined),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => dsNongSan(),)),
        ),
        ],
        ),

      body: Column(
        children: [
          SizedBox(height: 10,),
          Text("Khách hàng: Lê Lâm Trường", style: TextStyle(fontSize: 20),),
          Text("Địa chỉ: 173, Vĩnh Lương, Nha Trang", style: TextStyle(fontSize: 20),),
          Text("SĐT:09 0517 2802", style: TextStyle(fontSize: 20),),
          SizedBox(height: 10,),
          if(_giohang.length != 0)
            Expanded(
              child:ListView.builder(
                  itemCount: _giohang.length,
                  itemBuilder: (context, index) {
                    var item = _giohang[index];
                    int tongtamthoi = 0;
                    tongtamthoi = item.soluong*item.gia;
                    //hàm quản lí để tăng giảm số lượng trong giỏ hàng
                    void _soluong(bool ct)
                    {
                      setState(() {
                        if(ct ==true)
                        {
                          //vì mỗi lần tính là nó duyệt lại toàn bộ phần từ trong giỏ, nên t phải khai báo tong tien 0
                          tongTien= 0;
                          item.soluong++;
                          dk= true;
                        }

                        else if(ct == false)
                        {
                          tongTien= 0;
                          item.soluong--;
                          dk= true;
                        }
                      });
                    }
                    return Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                      child: Card(
                          elevation: 10,
                          child:Column(
                            children: [
                              Row(
                                children: [
                                  Image.network(item.url,width: 125,),
                                  SizedBox(width: 20,),
                                  Text(item.tenns,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                  SizedBox(width: 20,),
                                  Text(NumberFormat.currency(locale: 'vi').format(item.gia),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.redAccent),)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(icon: Icon(Icons.remove),iconSize: 35, onPressed: ()=> {
                                    if(item.soluong >1)
                                      _soluong(false),

                                  }),
                                  Text(item.soluong.toString(),style: TextStyle(fontSize: 20),),
                                  IconButton(icon: Icon(Icons.add), iconSize: 35, onPressed: ()=> {
                                    _soluong(true),
                                  }),
                                  SizedBox(width: 40,),
                                  Text(NumberFormat.currency(locale: 'vi').format(tongtamthoi),style: TextStyle(fontSize: 20,color: Colors.redAccent),),
                                  SizedBox(width: 30,),
                                  IconButton(
                                      icon: Icon(Icons.remove_circle,color: Colors.redAccent,),
                                      onPressed: (){
                                        setState(() {
                                          tongTien = tongTien - item.soluong*item.gia;
                                          dk=false;
                                          giohang.remove(item);

                                        });
                                      }),

                                ],
                              ),

                            ],
                          )

                      ),
                    );

                  }), )
          else Text("Hãy đặt hàng rồi quay lại sau nhé!!",style: TextStyle(fontSize: 25),),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Tổng tiền: " + NumberFormat.currency(locale: 'vi').format(tongTien), style: TextStyle(color: Colors.red,fontSize: 24,fontWeight: FontWeight.bold),),
              SizedBox(width: 10,),
              ElevatedButton(
                child: Text("Đặt hàng", style: TextStyle(fontSize: 20),),
                onPressed:() => {
                  _thongbaoDatHang(context),

                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent
                ),
              ),
              SizedBox(width: 10,),
            ],
          ),

        ],
      ),
    );
  }
  void _thongbaoDatHang(BuildContext context){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Thông báo!"),
          content: Text("Đặt hàng thành công"),
          actions: [
            ElevatedButton(
              child: Text("Ok"),
              onPressed: () async {
                _giohang.forEach((element) {
                  _giohang.remove(element);
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => dsNongSan(),));
              },
            ),
          ],
        );
      },);
  }
  @override
  void initState() {
    // TODO: implement initState
    tongTien;
    super.initState();
  }
}