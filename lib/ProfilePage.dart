import 'package:flutter/material.dart';
import 'package:hotel/CrudOperation.dart';
import 'package:hotel/EditProfile.dart';
import 'package:hotel/LogInPage.dart';
import 'package:firebase_database/firebase_database.dart';


import 'HomePage.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List<Map> data = [];
  FirebaseDatabase database = FirebaseDatabase.instance;
  String selectedKey = '';
  String userMail = '';
  String designation = '';
  String phone = '';
  String email = '';
  String address ='';
  String myName='';
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    void getdata() async {
      DatabaseEvent d = await database.ref('MyData').once();
      Map temp = d.snapshot.value as Map;
      data.clear();
      temp.forEach((key, value) {
        data.add(value);
      });
      designation = data[0]['designation'];
      phone = data[0]['phone'];
      email = data[0]['email'];
      address = data[0]['address'];
      myName = data[0]['myName'];
      setState(() {});
    }
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: const Color(0xFFF6F7FF),
      appBar: AppBar(
        title: const Text(
          'Profile Page',
          style: TextStyle(color: Colors.teal),
        ),
        elevation: 0.0,
        backgroundColor: const Color(0xFFF6F7FF),
        leading: IconButton(
          onPressed: () async {
            _key.currentState!.openDrawer();
            DatabaseEvent d = await database.ref('MyData').once();
            Map temp = d.snapshot.value as Map;
            data.clear();
            temp.forEach((key, value) {
              data.add(value);
            });
            designation = data[0]['designation'];
            phone = data[0]['phone'];
            email = data[0]['email'];
            address = data[0]['address'];
            myName = data[0]['myName'];
            setState(() {});
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            tooltip: 'Comment Icon',
            onPressed: () async {
                    DatabaseEvent d = await database.ref('MyData').once();
                    Map temp = d.snapshot.value as Map;
                    data.clear();
                    temp.forEach((key, value) {
                      data.add(value);
                    });
                    designation = data[0]['designation'];
                    phone = data[0]['phone'];
                    email = data[0]['email'];
                    address = data[0]['address'];
                    myName = data[0]['myName'];
                    setState(() {});
                  },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.grey,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.grey),
                accountName: Text(
                  myName,
                  style: const TextStyle(fontSize: 18),
                ),
                accountEmail: Text(email),
                currentAccountPictureSize: const Size.square(50),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 75,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/images/PROFILE.jpg'),
                    ),
                  ), //Text//Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(' My Profile '),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserProfile()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(' Home Page '),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(' Edit Data '),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CrudOperation()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.workspaces_outline),
              title: const Text(' Go Premium '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_label),
              title: const Text(' Saved Videos '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('LogIn'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginDemo()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const EditProfile()));
                    },
                    child: CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.grey.shade200,
                      child: const CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage('assets/images/PROFILE.jpg'),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: Container(
                      child: const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Icon(Icons.edit, color: Colors.black),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: Colors.white,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              50,
                            ),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(2, 4),
                              color: Colors.black.withOpacity(
                                0.3,
                              ),
                              blurRadius: 3,
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                myName,
                style: TextStyle(color: Colors.blueGrey[700], fontSize: 25.0),
              ),
              const SizedBox(height: 26),
              Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: const Icon(
                    Icons.account_box_outlined,
                    color: Colors.teal,
                  ),
                  title: Text(
                    designation,
                    style: const TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        fontFamily: "Source Sans Pro"),
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.teal,
                  ),
                  title: Text(
                    phone,
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        fontFamily: "Source Sans Pro"),
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.teal,
                  ),
                  title: Text(
                    email,
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        fontFamily: "Source Sans Pro"),
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: Icon(
                    Icons.location_city,
                    color: Colors.teal,
                  ),
                  title: Text(
                    address,
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        fontFamily: "Source Sans Pro"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
