import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile1_flutter/model/cataloge_model.dart';
import 'package:profile1_flutter/pages/cart_page.dart';
import 'package:profile1_flutter/providers/cataloge_provider.dart';
import 'package:provider/provider.dart';

class CatalogePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProviderCataloge providerCataloge = context.watch();  // Watch khi lắng nghe để hiển thị
    return Scaffold(
      appBar: AppBar(
        title: Text("Cataloge"),
        actions: [
          GestureDetector(
            child: Stack(
              alignment: Alignment.center,
              children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Icon(Icons.shopping_cart, size: 48,color:Colors.redAccent,),
                 ),
                Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text("${providerCataloge.slMH}",style: TextStyle(fontSize: 20),),
                )

              ],
            ),
            onTap:()=> toCartPage(context) //chuyển đến trang card page
            ),

        ],
      ),
      body: buildListMatHang(context,providerCataloge.cataloge),  // goi widget buillistMatHang
    );
  }
  //tạo ra widget danh sách các mặt hàng
  Widget buildListMatHang(BuildContext context, List<MatHang> list)
  {
    return Padding(
            padding: const EdgeInsets.all(8.0),
            child:ListView.separated(
                itemBuilder: (context, index)=>buildListItem(context, list[index]),
                separatorBuilder: (context,index)=>Divider(thickness: 5,color: Colors.white,),
                itemCount: list.length,
            ),
          );
  }
  //tạo ra widget từng mặt hàng
  Widget buildListItem(BuildContext context, MatHang mh)
  {
    ProviderCataloge providerCataloge = context.read<ProviderCataloge>(); // read khi muốn dùng để thay đổi
    // dùng để truy cập vào object và trả về 1 ProviderCataloge(object)
    // truyền vào bên trong <...> là 1 type của object
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(width: 48, height: 48, color:mh.color,),
        SizedBox(width: 20,),
        Expanded(
            child: Text("${mh.name}",style: TextStyle(fontSize: 20),)
        ),
        TextButton(
            onPressed: () =>providerCataloge.addToCart(mh),
            child: providerCataloge.checkInCart(mh.id) ? Icon(Icons.check):Text("Add")
        ),
        SizedBox(width: 15,)
      ],
    );
  }
  toCartPage(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(
        builder: (context)=> CartPage(),));
  }
 
}
