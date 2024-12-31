import 'package:flutter/material.dart';
import 'cart.dart';
import 'smartProducts.dart';

class Smart extends StatefulWidget {
  const Smart({super.key});

  @override
  State<Smart> createState() => _SmartState() ;
}

class _SmartState extends State<Smart> {

  bool _load = false; // used to show products list or progress bar

  void update(bool success) {
    setState(() {
      _load = true; // show product list
      if (!success) { // API request failed
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('failed to load data')));
      }
    });
  }

  @override
  void initState() {
    // update data when the widget is added to the tree the first tome.
    updateSmartProducts(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(onPressed: !_load ? null : () {
            setState(() {
              _load = false; // show progress bar
              updateSmartProducts(update); // update data asynchronously
            });
          }, icon: const Icon(Icons.refresh)),
          IconButton(onPressed: () {
            setState(() { // open the search product page
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CartList())
              );
            });
          }, icon: const Icon(Icons.shopping_cart), color: Colors.black,)
        ],
        title: const Text('SMART', style: TextStyle(fontSize: 30,color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: _load ? const ShowSmartProducts() : const Center(
          child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator())
      ),
    );
  }
}
