import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Ban San Pham",
        theme: ThemeData(primarySwatch: Colors.grey),
        home: ProductPage(),
    );
  }
}

// lam 2 phan tren chung 1 trang
// product_page
class ProductPage extends StatefulWidget {

  @override
  _ProductPageState createState() => _ProductPageState();
}



class _ProductPageState extends State<ProductPage> {
  List<String> listText=["San Pham 1","San Pham 2","San Pham 3","San Pham 4"];
  List<String> listImage =[
    "asset/image/Top1.png",
    "asset/image/Top2.png",
    "asset/image/Top3.png",
    "asset/image/Top4.jpg",
  ];
  int imagePos=0;
  String changeText;


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Giới thiệu sản phẩm",),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            CarouselSlider.builder(
                itemCount: listImage.length,
                itemBuilder: (context, index, realIndex) => Container(
                width: 0.9*width, height: 0.9*width,
                  child: Image.asset(listImage[index]),
                ),
                options: CarouselOptions(
                  height: width*0.9,
                  viewportFraction: 1,
                  onPageChanged:(index,reason)
                    {
                      setState(() {
                        imagePos=index;
                        changeText=listText[index];
                      });
                    }
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child: SizedBox()),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${imagePos+1}/${listImage.length}',style: TextStyle(fontSize: 25, color: Colors.blue),),
                  ),
                )
              ],
            ),
            Text('${changeText}', style: TextStyle(fontSize: 20, color: Colors.black),),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow[500]),
                Icon(Icons.star, color: Colors.yellow[500]),
                Icon(Icons.star, color: Colors.yellow[500]),
                Icon(Icons.star, color: Colors.yellow[500]),
                Icon(Icons.star, color: Colors.yellow),
                Text(" (Xem 100 danh gia)"),
              ],
            )
          ],
        ),
      ),
    );
  }
}


