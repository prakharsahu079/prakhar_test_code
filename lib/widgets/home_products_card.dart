import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prakhar_test/screens/CardPage.dart';

class HomeProductCard extends StatefulWidget {
  final String productId;
  final String image;
  final String name;
  final String price;
  final String rating;

  HomeProductCard({
    required this.image,
    required this.productId,
    required this.name,
    required this.price,
    required this.rating,
  });

  @override
  _HomeProductCardState createState() => _HomeProductCardState();
}

class _HomeProductCardState extends State<HomeProductCard> {
  bool _registerFormLoading = false;
  final CollectionReference _cardRef =
      FirebaseFirestore.instance.collection('Cart');
  Future _addToCart() {
    setState(() {
      _registerFormLoading = false;
    });
    /*final FirebaseAuth auth = FirebaseAuth.instance;

    final User user = auth.currentUser;
    final uid = user.uid;*/

    return _cardRef
        .doc(widget.productId)
        .set({"size": "L"});


    Navigator.push(context, MaterialPageRoute(
      builder: (context) => CartPage(),
    ),);

    setState(() {
      _registerFormLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200.0,
                child: Image.network(
                  widget.image.toString(),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 10),
                child: Text(
                  '${widget.name}',
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.w800,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: 50,
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 2,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '4.3',
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.bottomLeft,
                child: Text(
                  '\$${widget.price}',
                  style: TextStyle(fontSize: 16, fontFamily: 'avenir'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, top: 8),
                child: OutlinedButton(
                  onPressed: () async {
                    await _addToCart();
                  },
                  child: Text("Add to card"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
