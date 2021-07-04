import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile1_flutter/json_version/cataloge_json_ver_page.dart';
import 'package:profile1_flutter/json_version/myproviders.dart';
import 'package:provider/provider.dart';

class AppPageJsonVersion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context){
        CatalogeFileProvider catalogeFileProvider = CatalogeFileProvider();
        catalogeFileProvider.readMatHangs(); // phương thức async(bất đồng bộ)
        return catalogeFileProvider;
      },
      child: MaterialApp(
        title: "Cataloge App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        home: CatalogeJsonVersionPage(),
      ),
    );
  }
}
