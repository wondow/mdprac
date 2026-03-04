import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyanAccent,
          title: Text(
            "Welcome to the Login page",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Text(
              "My Application",
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 37,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("Enter username"),
            TextField(),
            Text("Enter password"),
            TextField(),
            SizedBox(height: 30),
            MaterialButton(
              onPressed: () {},
              color: Colors.white,
              textColor: Colors.deepOrangeAccent,
              child: Text("Login"),
            ),
          ],
        ),
      ),
    ),
  );
}
