import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:retop_prices_2/product_details.dart';

final _firestore = FirebaseFirestore.instance;

class MyHomePage extends StatefulWidget {
  static const String id = 'price_list';
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Material(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('Prices').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("no data1");
                    } else if (snapshot.hasData) {
                      final prices = snapshot.data?.docs;

                      List<Widget> priceWidgets = [];

                      for (var price in prices!) {
                        final productName = price["productName"];
                        final productPrice = price["price"].toString();
                        final productImage = price["link"];
                        final priceWidget = GestureDetector(
                          // When the child is tapped, show a snackbar.
                          onTap: () {
                            print(productName);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                  productName: productName,
                                  productPrice: productPrice,
                                  productImage: productImage,
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(productName),
                            leading: Image(
                              image: NetworkImage(productImage),
                            ),
                            trailing: Text(productPrice),
                          ),
                        );
                        priceWidgets.add(priceWidget);
                      }

                      return Expanded(
                        child: ListView(
                          // itemExtent: prices.length.toDouble(),
                          //shrinkWrap: true,

                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 10.0),
                          children: priceWidgets,
                        ),
                      );
                    }
                    return Text("no data");
                  }),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class textBubble extends StatelessWidget {
  textBubble({
    required this.productName,
    required this.productPrice,
  });

  final String productName;
  final String productPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$productName",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
