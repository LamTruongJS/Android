

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile1_flutter/model/cataloge_model.dart';
import 'package:profile1_flutter/providers/cataloge_provider.dart';

import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    ProviderCataloge providerCataloge = context.watch<ProviderCataloge>(); // Watch khi lắng nghe để hiển thị
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      bottomSheet: _bottomSheet(providerCataloge.total),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildList(providerCataloge.gioHang, context),
      ),
    );
  }
  Widget _buildItem(BuildContext context, MatHang mh){
    ProviderCataloge providerCataloge1 = context.read<ProviderCataloge>(); // read khi muốn dùng để thay đổi
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.check),
          SizedBox(width: 20,),
          Expanded(child: Text('${mh.name}', style: TextStyle(fontSize: 20),),),
          IconButton(icon: Icon(Icons.remove_circle_outline),  onPressed: () => providerCataloge1.removeFromCart(mh)),
          SizedBox(width: 10,)
        ],
      ),
    );
  }
  Widget _buildList(List<MatHang> dsMh, BuildContext context){
    return ListView.separated(
        itemBuilder: (context, index) => _buildItem(context, dsMh[index]),
        separatorBuilder: (context, index) => Divider(thickness: 2, color: Colors.grey,),
        itemCount: dsMh.length);
  }
  Widget _bottomSheet(int price){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Text('$price \$', style: TextStyle(fontSize:  20),),
          SizedBox(width: 20,),
          ElevatedButton(onPressed: () => _showDialog(context), child: Text('Mua'))
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
  void _showDialog(BuildContext context){
    ProviderCataloge providerCataloge = context.read<ProviderCataloge>();
    AlertDialog alertDialog = AlertDialog(
      title: Text('Chi tiết hóa đơn', style: TextStyle(fontSize: 20, color: Colors.teal),),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Các món hàng đã mua', style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),),
            for(MatHang i in providerCataloge.gioHang)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${i.name} : ${i.price} \$'),
              ),
            SizedBox(height: 15,),
            Text('Cần thanh toán : ${providerCataloge.total} \$', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: ()=> Navigator.pop(context), child: Text('OK')),
      ],
    );
    showDialog(context: context, builder: (context) => alertDialog,);
  }
}
