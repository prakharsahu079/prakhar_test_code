import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prakhar_test/widgets/home_products_card.dart';

class HomeScreen extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection('Products');
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Icon(Icons.menu, color: Colors.black),
        title: Text(
          "Home Screen",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.shop, color: Colors.black),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: _productsRef.get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  // display data in listvie
                  return GridView.count(
                    controller: new ScrollController(keepScrollOffset: false),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: (itemWidth / 380),
                    physics: BouncingScrollPhysics(),
                    children: snapshot.data!.docs.map((document) {
                      return Container(
                        child: HomeProductCard(
                          name: document.data()['name'],
                          price: document.data()['price'],
                          rating: document.data()['rating'],
                          image: document.data()['images'][0],
                          productId: document.id,
                        ),
                      );
                    }).toList(),
                  );
                }

                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
