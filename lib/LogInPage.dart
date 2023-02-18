import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hotel/SignUpPage.dart';
import 'package:hotel/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginDemo extends StatefulWidget {
  const LoginDemo({Key? key}) : super(key: key);

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  List<Map> data = [];
  FirebaseDatabase database = FirebaseDatabase.instance;
  String selectedKey = '';
  bool isValid = false;
  bool isEmail = false;
  void Validate(String email) {
    isValid = EmailValidator.validate(email);
    print(isValid);
  }

  bool isPassword = false;
  String _errorMessage = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Log-in",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
        backgroundColor: Colors.blueAccent[400],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(50.0)),
              child: Image.asset('assets/images/login.jpg'),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email id as abc@gmail.com',
                      suffixIcon: isEmail
                          ? const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                            )
                          : null),
                  onChanged: (val) {
                    Validate(emailController.text);
                    setState(() {
                      if (isValid) {
                        isEmail = false;
                        _errorMessage = '';
                      } else {
                        _errorMessage = 'Please Enter correct email';
                        isEmail = true;
                      }
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                controller: passController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password',
                    suffixIcon: isPassword
                        ? Icon(
                            Icons.error_outline,
                            color: Colors.red,
                          )
                        : null),
                onChanged: (val) {
                  setState(() {
                    if (passController.text.length >= 6) {
                      isPassword = false;
                      _errorMessage = '';
                    } else {
                      _errorMessage =
                          'Please Enter minimum 6 character password';
                      isPassword = true;
                    }
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),
            MaterialButton(
              onPressed: () {
                // String? key = database.ref('User').push().key;
                // database.ref('User').child(key!).set({
                //   'email': emailController.text,
                //   'pass': passController.text,
                //   'key': key,
                // });
                database.ref('User').child(selectedKey).update({
                  'email': emailController.text,
                  'pass': passController.text,
                });
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: MaterialButton(
                onPressed: () {
                  if (isValid == true &&
                      isPassword == false &&
                      passController.text.isNotEmpty) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  } else {}
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
                        MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpDemo()));
              },
              child: Text(
                'New User? Create Account',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
