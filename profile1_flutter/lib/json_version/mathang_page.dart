import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile1_flutter/json_version/myproviders.dart';
import 'package:provider/provider.dart';
import 'model.dart';

class MatHangInfoPage extends StatefulWidget {
 int indexMH=-1;
MatHangInfoPage({this.indexMH});
  @override
  _MatHangInfoPageState createState() => _MatHangInfoPageState();
}

class _MatHangInfoPageState extends State<MatHangInfoPage> {
  final _formKey =GlobalKey<FormState>();
  int _indexMH;
  @override
  Widget build(BuildContext context) {
    MatHang matHang = _indexMH == -1 ? MatHang(): context.watch<CatalogeFileProvider>().listMH[_indexMH];
    return Scaffold(
      appBar: AppBar(
        title: Text("Mặt Hàng"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: matHang.id ==null ? null: matHang.id.toString(),
                  decoration: InputDecoration(
                    labelText: "Id",
                    hintText: "Nhập id của mặt hàng"
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (newValue)=>matHang.id = int.parse(newValue),
                  validator: (value)=> value.isEmpty ? "Không được để trống": null,
                ),
                SizedBox(height: 10,),
                TextFormField(
                  initialValue: matHang.name ==null ? null: matHang.name.toString(),
                  decoration: InputDecoration(
                      labelText: "Name",
                      hintText: "Nhập tên của mặt hàng"
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (newValue)=>matHang.name = newValue,
                  validator: (value)=> value.isEmpty ? "Không được để trống": null,

                ),
                SizedBox(height: 10,),
                TextFormField(
                  initialValue: matHang.price ==null ? null: matHang.price.toString(),
                  decoration: InputDecoration(
                      labelText: "Price",
                      hintText: "Nhập Giá của mặt hàng"
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (newValue)=>matHang.price = int.parse(newValue),
                  validator: (value)=> value.isEmpty || int.parse(value)<=0 ? "Không được để trống và không được bé hơn 0": null,
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          child: Text("Ok"),
                          onPressed: ()=> _save(context, matHang),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Cancer"),
                          )
                      ),
                    ),
                  ],
                )
              ],

            ),

          ),
        ),
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    _indexMH = widget.indexMH;
  }

  _save(BuildContext context, MatHang matHang){
    if(_formKey.currentState.validate() == true){
      _formKey.currentState.save();
      CatalogeFileProvider catalogeFileProvider = context.read<CatalogeFileProvider>();
      if(_indexMH == -1){
        matHang.color = Colors.primaries[matHang.id % Colors.primaries.length];
        catalogeFileProvider.addMatHang(matHang);
      }
      else
        catalogeFileProvider.updateMatHangs(); //lưu thông tin xuống bộ nhớ
      Navigator.pop(context);
    }
  }
}
