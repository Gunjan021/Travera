import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignUpDemo extends StatefulWidget {
  const SignUpDemo({Key? key}) : super(key: key);

  @override
  _SignUpDemoState createState() => _SignUpDemoState();
}

class _SignUpDemoState extends State<SignUpDemo> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool isDate = false;
  bool isName = false;
  bool isPhone = false;
  bool isPassword = false;
  bool isEmail = false;
  bool isValid = false;
  void Validate(String email) {
    isValid = EmailValidator.validate(email);
    print(isValid);
  }

  String _errorMessage = '';
  String male = "male";
  String female = "female";
  String group_gender = "male";
  bool cbread = false;
  bool cbgame = false;
  bool cbcode = false;
  String dob = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Sign-up",
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
        backgroundColor: const Color.fromRGBO(4, 179, 152, 20),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Container(
            //   decoration: BoxDecoration(
            //       color: Colors.red, borderRadius: BorderRadius.circular(50.0)),
            //   child: Image.asset('assets/images/signup.jpg'),
            // ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: nameController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Enter Your Name',
                    suffixIcon: isName
                        ? const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                          )
                        : null),
                onChanged: (val) {
                  setState(() {
                    if (nameController.text.length <= 1) {
                      isName = true;
                      _errorMessage = "PLease Enter atleast 2 character name";
                    } else {
                      isName = false;
                      _errorMessage = "";
                    }
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
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
                keyboardType: TextInputType.visiblePassword,
                controller: passController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password',
                    suffixIcon: isPassword
                        ? const Icon(
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
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: phoneController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Contact No.',
                    hintText: 'Enter 10 Digit Contact Number',
                    suffixIcon: isPhone
                        ? const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                          )
                        : null),
                maxLength: 10,
                onChanged: (val) {
                  setState(() {
                    if (phoneController.text.length <= 9) {
                      isPhone = true;
                      _errorMessage = 'Please Enter 10 Digit Contact Number';
                    } else {
                      _errorMessage = '';
                      isPhone = false;
                    }
                  });
                },
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: Card(
                borderOnForeground: true,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Gender:'),
                    ),
                    Radio(
                      value: male,
                      groupValue: group_gender,
                      onChanged: (val) {
                        group_gender = val.toString();
                        setState(() {});
                      },
                    ),
                    const Text('Male'),
                    Radio(
                      value: female,
                      groupValue: group_gender,
                      onChanged: (val) {
                        group_gender = val.toString();
                        setState(() {});
                      },
                    ),
                    const Text('Female'),
                  ],
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: Card(
                borderOnForeground: true,
                child: Row(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Hobbi:'),
                  ),
                  Checkbox(
                    value: cbread,
                    onChanged: (val) {
                      cbread = !cbread;
                      setState(() {});
                    },
                  ),
                  const Text('Reading'),
                  Checkbox(
                    value: cbgame,
                    onChanged: (val) {
                      cbgame = !cbgame;
                      setState(() {});
                    },
                  ),
                  const Text('Gaming'),
                ]),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                keyboardType: TextInputType.none,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Date Of Birth',
                    hintText: dob,
                    suffixIcon: isDate
                        ? const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                          )
                        : null),
                onChanged: (val) {},
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2005),
                  );
                  dob = date!.day.toString() +
                      '/' +
                      date.month.toString() +
                      '/' +
                      date.year.toString();
                  print(dob);
                  setState(() {
                    if (dob.isNotEmpty) {
                      isDate = false;
                      _errorMessage = "";
                    } else {
                      isDate = true;
                      _errorMessage = "PLease Enter date of birth";
                    }
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(43, 196, 138, 20),
                  borderRadius: BorderRadius.circular(20)),
              child: MaterialButton(
                onPressed: () {
                  // if (isValid == true &&
                  //     emailController.text.isNotEmpty &&
                  //     isPassword == false &&
                  //     passController.text.isNotEmpty &&
                  //     isName == false &&
                  //     nameController.text.isNotEmpty &&
                  //     isPhone == false &&
                  //     phoneController.text.isNotEmpty &&
                  //     isDate == false &&
                  //     dateController.text.isNotEmpty) {
                  Navigator.pop(context);
                  // } else {}
                },
                child: const Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
                        MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Already a User? Login',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
