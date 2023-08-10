import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign/main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class second extends StatefulWidget {
  // const second(String name, {Key? key}) : super(key: key);
  String name, email, image;

  second(this.name, this.email, this.image);

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.name}"),
       
      ),
      drawer: Drawer(
        width: 250,
        backgroundColor: Colors.grey,
        child: Column(
          children: [
            UserAccountsDrawerHeader(arrowColor: Colors.grey,
                decoration: BoxDecoration(gradient: LinearGradient(
                    colors: [Colors.yellow, Colors.red, Colors.lightGreen])),
                accountName: Text("${widget.name}", style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),),
                accountEmail: Text("${widget.email}", style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage("${widget.image}"),
                )),
            Card(
                color: Colors.grey,
                margin: EdgeInsets.all(5),
                child: TextField(
                  decoration: InputDecoration(hintText: "${widget.name}"),
                )),
            Card(
                color: Colors.grey,
                margin: EdgeInsets.all(5),
                child: TextField(
                  decoration: InputDecoration(hintText: "${widget.email}"),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          await GoogleSignIn().signOut();
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return Home();
                            },
                          ));
                        },
                        child: Text("Logout", style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),))),
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Card(
              color: Colors.grey,
              margin: EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(hintText: "${widget.name}"),
              )),
          Card(
              color: Colors.grey,
              margin: EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(hintText: "${widget.email}"),
              )),
          // Card(color: Colors.grey,margin: EdgeInsets.all(5),child:
          // TextField(decoration: InputDecoration(hintText: "${widget.number}"),)),

          ElevatedButton(
              onPressed: () async {
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return Home();
                  },
                ));
              },
              child: Text("Logout", style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),))
        ],
      ),
    );
  }
}
