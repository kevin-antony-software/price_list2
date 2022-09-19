import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  static const String id = 'product_details';

  const ProductDetails({
    required this.productName,
    required this.productPrice,
    required this.productImage,
  });

  final String productName;
  final String productPrice;
  final String productImage;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  double _currentSliderValue = 0;
  double afterDiscount = 0;

  @override
  Widget build(BuildContext context) {
    //afterDiscount = double.parse(widget.productPrice);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName),
      ),
      body: Material(
        child: Column(
          children: [
            Image(
              image: NetworkImage(widget.productImage),
            ),
            Text(
              "Selling Price is : ${widget.productPrice}",
              style: const TextStyle(fontSize: 30.0),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Discount : $_currentSliderValue %",
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
            StatefulBuilder(
              builder: (context, state) => Center(
                child: Slider(
                  value: _currentSliderValue,
                  min: 0.0,
                  divisions: 20,
                  max: 40.0,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double newValue) {
                    setState(() {
                      _currentSliderValue = newValue;
                      afterDiscount = (double.parse(widget.productPrice) *
                          (1 - newValue / 100));
                    });
                  },
                ),
              ),
            ),
            Text(
              "Discounted Priceis : ${afterDiscount.round()}",
              style: TextStyle(fontSize: 30.0),
            ),
          ],
        ),
      ),
    );
  }
}
