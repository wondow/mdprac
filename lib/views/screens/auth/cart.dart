import 'package:feb25prac/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var myButterNames = ["Cashmere", "blue lagoon","halo"];
var scent = ["vanilla jasmine", "phylosophy's dear grace", "victoria secret love bomb"];

var myButters=[ 
  ButterType(name: "cashmere", scent: "vanilla jasmine"),
  ButterType(name: "blue lagoon", scent: "phylosophy's dear grace"),
  ButterType(name: "baby blue", scent: "powder chamomile"),
  ButterType(name: "halo", scent: "victoria secret love bomb"),

];

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  
  Widget build(BuildContext context) {

   
    
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Image.asset("assets/images/sc.png", width: 100, height: 100),
            Column(
              children: [
                Text(myButterNames [index]),
                Text(scent[index]),
              ],
            ),
          ],
        );
      },
    );
    
  }

}
