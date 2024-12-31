import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'wishlist.dart';

import 'cart.dart';

const String _baseURL = 'watchapp.atwebpages.com';

// class to represent a row from the products table
// note: cid is replaced by category name
class Product {
  String _name;
  int _quantity;
  double _price;
  String _image;

  Product(this._name, this._quantity, this._price, this._image);
}

// list to hold products retrieved from getProducts
List<Product> _products = [];
// asynchronously update _products list
void updateWomenProducts(Function(bool success) update) async {
  try {
    final url = Uri.http(_baseURL, 'womenProducts.php');
    final response = await http.get(url).timeout(const Duration(seconds: 60)); // max timeout 5 seconds
    _products.clear(); // clear old products
    if (response.statusCode == 200) { // if successful call
      final jsonResponse = convert.jsonDecode(response.body); // create dart json object from json array
      for (var row in jsonResponse) { // iterate over all rows in the json array
        Product p = Product( // create a product object from JSON row object
            row['name'],
            int.parse(row['quantity']),
            double.parse(row['price']),
            row['image']
        );
        _products.add(p); // add the product object to the _products list
      }
      update(true); // callback update method to inform that we completed retrieving data
    }
  }
  catch (e) {
    update(false); // inform through callback that we failed to get data
  }
}


// shows products stored in the _products list as a ListView
class ShowWomenProducts extends StatelessWidget {
  const ShowWomenProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) => Column(children: [
          const SizedBox(height: 10),
          Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black87),
              padding: const EdgeInsets.all(5),
              width: width * 0.9,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          _products[index]._image,
                          height: 100,
                          errorBuilder: (context, error, stackTrace) {
                            return Text('Image not available');
                          },
                        ),
                      )

                    ]),
                    Column(children: [
                      Text(_products[index]._name, style: const TextStyle(fontSize: 15, color: Colors.white)),
                      const SizedBox(height: 15,),
                      Text('\$${_products[index]._price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 15, color: Colors.white)),
                    ]),
                    Column(
                      children: [
                        ElevatedButton(onPressed: (){
                          WishlistProduct wlp = WishlistProduct(_products[index]._name, _products[index]._quantity, _products[index]._price, _products[index]._image);
                          wlProducts.add(wlp);
                        }, child: const Icon(Icons.star)),
                        const SizedBox(height: 20,),
                        ElevatedButton(onPressed: (){
                          Cart c = Cart(_products[index]._name, _products[index]._price, _products[index]._image);
                          myCart.add(c);
                          totalPrice += _products[index]._price;
                        }, child: const Icon(Icons.add))
                      ],
                    ),
                  ])
          )
        ])
    );
  }

}
