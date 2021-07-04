import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model.dart';
class MyStorePage extends StatefulWidget {
  @override
  _MyStorePageState createState() => _MyStorePageState();
}

class _MyStorePageState extends State<MyStorePage> {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  List<String> loaiMHs =['Tivi','Phone', 'Laptop'];
  MatHang mh = MatHang();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Form Widget Demo"),
      ),
      body: Form(
        key: _formState,
        autovalidateMode: AutovalidateMode.disabled,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mặt Hàng',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  )
                ),

                onSaved: (newValue) {mh.tenMH=newValue;},
                validator: (value) => value.isEmpty ? "Chưa có Tên mặt hàng":null,
              ),

              SizedBox(height: 10,),
              DropdownButtonFormField<String>(
                  items: loaiMHs.map((loaiMH) => DropdownMenuItem<String>(
                    child: Text(loaiMH),
                    value: loaiMH,
                  )
                  ).toList(),
                  onChanged: (value){
                    mh.loaiMH= value;
                  },
                validator: (value) => value==null ? "Chưa chọn loại mặt hàng": null,
                decoration: InputDecoration(
                  labelText: 'Loại Mặt Hàng',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10),)
                  )
                ),
              ),

              SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Số Lượng',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  )
                ),
                onSaved: (newValue) {mh.soLuong= int.parse(newValue);},
                validator: (value) =>_validateSoluong(value),
                keyboardType: TextInputType.numberWithOptions(
                  signed: false, decimal: false
                ),
              ),
              Row(
                children: [
                  Expanded(child: SizedBox(),flex: 1,),
                  RaisedButton(
                    child: Text("OK"),
                    color: Colors.white,
                    onPressed:(){
                      if(_formState.currentState.validate())
                      {
                        _formState.currentState.save();
                        _showAlertDialog(context);
                      }
                    },
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ],
          ),
        ),
      ),
    ) ;
  }
  void _showAlertDialog(BuildContext context){
    AlertDialog alertDialog = AlertDialog(
      title: Text('Xác nhận'),
      content: Text("Mặt hàng; ${mh.tenMH}\n"
          "Thuộc loại mặt hàng: ${mh.loaiMH}\n"
          "Với số lượng: ${mh.soLuong}"),
      actions: [
        FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK')
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (context) => alertDialog,
    );
  }
  String _validateSoluong(String value)
  {
    int sl = value.isEmpty ? 0 : int.tryParse(value);
    return sl <= 0 ? "Số lượng mặt hàng phải lớn hơn 0" : null;
  }
  // int _valueTinhTong(String value)
  // {
  //   int sl= value.isEmpty ? 0 : int.tryParse(value);
  //   int tong = 0;
  //   tong = sl * 100;
  //   return tong;
  // }
}

