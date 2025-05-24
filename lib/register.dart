import 'package:firebase_authentication/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterApp extends StatefulWidget {
  @override
  State<RegisterApp> createState() => _RegisterAppState();
}

class _RegisterAppState extends State<RegisterApp> {
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
                "Register Yourself",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30.0),
                  child: Row(
                    children: [

                      Text("Email:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18),)
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
                        border: OutlineInputBorder(),
                        labelText: "Enter Password"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {
                      String mail = emailController.text.trim();
                      String pass = passController.text.trim();
                      if (mail.isEmpty || pass.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please Enter All Fields")));
                      } else {
                        try {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: mail, password: pass)
                              .then((onValue) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Register Successfully")));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => loginPage()));
                          });
                        } catch (err) {
                          print(err);
                        }
                      }
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => loginPage()));
                  },
                  child: Text(
                    "Already have an Account? Click Here",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 19),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
