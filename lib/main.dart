import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign/second.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String name = user.displayName.toString();
      String email = user.email.toString();
      String image = user.photoURL.toString();
      String number = user.phoneNumber.toString();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            // return second(name, email,image,number);
            return second(name, email, image);
          },
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google sign In", style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
      ),
      body: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.pink,Colors.lightGreen]),
              borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 1, color: Colors.black87)),
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.lightGreen,Colors.pink]),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(width: 1, color: Colors.black87)),
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.pink,Colors.lightGreen]),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 1, color: Colors.black87)),
          child: Center(
            child: ElevatedButton(
                onPressed: () {
                  signInWithGoogle().then((value) {
                    String name, email, image, number;
                    name = value.user!.displayName.toString();
                    email = value.user!.email.toString();
                    image = value.user!.photoURL.toString();
                    //  number =value.user!.phoneNumber.toString();
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        // return second(name, email,image,number);
                        return second(name, email, image);
                      },
                    ));
                  });
                },
                child: Text("Google Login", style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),)),
          ),
        ),
      ),
    ),);
  }
}
