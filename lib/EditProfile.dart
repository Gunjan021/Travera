import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hotel/CrudOperation.dart';
import 'package:hotel/HomePage.dart';
import 'package:hotel/LogInPage.dart';
import 'package:hotel/ProfilePage.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController emailController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController myNameController = TextEditingController();

  List<Map> data = [];
  FirebaseDatabase database = FirebaseDatabase.instance;
  String selectedKey = '';
  String userMail = '';
  String userName ='';
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
      myNameController.text = data[0]['myName'];
      emailController.text = data[0]['email'];
      phoneController.text=data[0]['phone'];
      addressController.text = data[0]['address'];
      designationController.text = data[0]['designation'];
      userName=data[0]['myName'];
      userMail=data[0]['email'];
      // selectedKey = data[0]['key'];
      setState(() {});
    }
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        backgroundColor: const Color(0xFFF6F7FF),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: const Color(0xFFF6F7FF),
          leading: IconButton(
            onPressed: ()  async {
              _key.currentState!.openDrawer();
              // DatabaseEvent d = await database.ref('MyData').once();
              // Map temp = d.snapshot.value as Map;
              // data.clear();
              // temp.forEach((key, value) {
              //   data.add(value);
              // });
              // userMail=data[0]['email'];
              // userName = data[0]['myName'];
              // setState(() {});
              DatabaseEvent d = await database.ref('MyData').once();
              Map temp = d.snapshot.value as Map;
              data.clear();
              temp.forEach((key, value) {
                data.add(value);
              });
              print(data);
              userMail=data[0]['email'];
              userName = data[0]['myName'];
              myNameController.text = data[0]['myName'];
              emailController.text = data[0]['email'];
              phoneController.text=data[0]['phone'];
              addressController.text = data[0]['address'];
              designationController.text = data[0]['designation'];
              setState(() {});
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Travera',
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                ),
                // textAlign: TextAlign.center,
              )
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.comment,
                color: Colors.black,
              ),
              tooltip: 'Comment Icon',
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: TextField(
                  controller: myNameController,
                  decoration: const InputDecoration(
                  hintText: "Enter Name",
                  labelText: 'Name',
                ),
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: TextFormField(
                  controller: designationController,
                  decoration: const InputDecoration(
                  hintText: "Enter Designation",
                  labelText: 'Designation',
                ),
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                  hintText: "Enter Phone",
                  labelText: 'Phone',
                ),
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                  hintText: "Enter Email",
                  labelText: 'Email',
                ),
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: TextField(controller: addressController,decoration: const InputDecoration(
                  hintText: "Enter Address",
                  labelText: 'Address',
                ),
                ),
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // ElevatedButton(
                  //     onPressed: () {
                  //       String? key = database.ref('MyData').push().key;
                  //       database.ref('MyData').child(key!).set({
                  //         'email': emailController.text,
                  //         'designation': designationController.text,
                  //         'address': addressController.text,
                  //         'phone': phoneController.text,
                  //         'key': key,
                  //       });
                  //     },
                  //     child: const Text('Insert')),
                  // const SizedBox(height: 15.0),
                  ElevatedButton(
                      onPressed: () {
                        selectedKey = data[0]['key'];
                        database.ref('MyData').child(selectedKey).update({
                          'myName': myNameController.text,
                          'email': emailController.text,
                          'designation': designationController.text,
                          'address': addressController.text,
                          'phone': phoneController.text,
                        });
                      },
                      child: const Text('Update')),
                  const SizedBox(height: 15.0),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       database.ref('MyData').child(selectedKey).remove();
                  //     },
                  //     child: const Text('Delete')),
                  // const SizedBox(height: 15.0),
                  MaterialButton(
                      onPressed: () async {
                        DatabaseEvent d = await database.ref('MyData').once();
                        Map temp = d.snapshot.value as Map;
                        data.clear();
                        temp.forEach((key, value) {
                          data.add(value);
                        });
                        print(data);
                        myNameController.text = data[0]['myName'];
                        emailController.text = data[0]['email'];
                        phoneController.text=data[0]['phone'];
                        addressController.text = data[0]['address'];
                        designationController.text = data[0]['designation'];
                        userName=data[0]['myName'];
                        userMail=data[0]['email'];
                        // selectedKey = data[0]['key'];
                        setState(() {});
                      },
                      child: const Icon(Icons.refresh)),
                ],
              ),
            ],
          ),
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
                    userName,
                    style: const TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text(userMail),
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
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: const Color(0xFFB7B7B7),
          selectedItemColor: Colors.deepOrangeAccent,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: "BookMark",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: "Destination",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "Notification",
            ),
          ],
        ),
      ),
    );
  }
}
