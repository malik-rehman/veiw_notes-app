import 'package:firebase_authentication/home.dart';
import 'package:firebase_authentication/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  var emailController = TextEditingController();

  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Scaffold(
      appBar: AppBar(
        title: Container(
          width: 600,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.black),
          child: Center(
              child: Text(
            "Login",
            style: TextStyle(
                color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold),
          )),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 30.0),
            child: Row(
              children: [
                Text(
                  "Email:",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )
              ],
            ),
          ),

          Container(
            width: 300,
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Enter Email"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 30.0),
            child: Row(
              children: [

                Text("Password:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18),)
              ],
            ),
          ),
          Container(
            width: 300,
            child: TextField(
              controller: passController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Enter password"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
    onPressed: () async {
    String mail = emailController.text.trim();
    String pass = passController.text.trim();

    if (mail.isEmpty || pass.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Enter all the fields")));
    return;
    }

    try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: mail, password: pass);

    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Login Successfully")));

    Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => DataStore()));
    } on FirebaseAuthException catch (e) {
    String message = "Login failed";
    if (e.code == 'user-not-found') {
    message = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
    message = 'Wrong password provided.';
    } else if (e.code == 'network-request-failed') {
    message = 'No internet connection.';
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }


  },
              child: Text("Login", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),)),
          SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => RegisterApp()));
            },
            child: Text("Create Account", style: TextStyle(color: Colors.blueAccent, fontSize: 19),),
          )
        ],
      ),
    )));
  }
}
