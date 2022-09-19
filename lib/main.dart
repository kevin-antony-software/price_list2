import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:retop_prices_2/product_details.dart';

import 'price_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const PriceList());
}

class PriceList extends StatelessWidget {
  const PriceList({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'RETOP PRICE LIST'),
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(
              title: 'Retop Price List',
            ),
        ProductDetails.id: (context) => ProductDetails(
              productName: '',
              productPrice: '',
              productImage: '',
            ),
        //MyHomePage.id: (context) => MyHomePage(),
      },
    );
  }
}
