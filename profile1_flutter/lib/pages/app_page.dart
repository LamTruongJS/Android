import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile1_flutter/pages/cateloge_page.dart';
import 'package:profile1_flutter/pages/users.dart';
import 'package:profile1_flutter/providers/cataloge_provider.dart';
import 'package:provider/provider.dart';

class AppPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProviderCataloge(),
        child: MaterialApp(
          title: "Cateloge App",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.red
            ),
          home: UserPage(),
          // home: CatalogePage(),
    ),
    );
  }
}
