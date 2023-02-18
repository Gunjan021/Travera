import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hotel/HomePage.dart';
import 'package:hotel/LogInPage.dart';
import 'package:hotel/ProfilePage.dart';
class CrudOperation extends StatefulWidget {
  const CrudOperation({Key? key}) : super(key: key);

  @override
  State<CrudOperation> createState() => _CrudOperationState();
}

class _CrudOperationState extends State<CrudOperation> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  List<Map> data = [];
  List<Map> datadb = [];
  FirebaseDatabase database = FirebaseDatabase.instance;
  String selectedKey = '';
  String userMail = '';
  String userName = '';
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  void clearText() {
    emailController.clear();
    passController.clear();
  }
  Future<void> refresh()  async {
    DatabaseEvent d = await database.ref('UserData').once();
    Map temp = d.snapshot.value as Map;
    data.clear();
    temp.forEach((key, value) {
      data.add(value);
    });
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future<void> getdata() async {
      DatabaseEvent d = await database.ref('UserData').once();
      Map temp = d.snapshot.value as Map;
      data.clear();
      temp.forEach((key, value) {
        data.add(value);
      });
      clearText();
      setState(() {
        refresh();
      });
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
              DatabaseEvent d = await database.ref('MyData').once();
              Map temp = d.snapshot.value as Map;
              datadb.clear();
              temp.forEach((key, value) {
                datadb.add(value);
              });
              userMail=datadb[0]['email'];
              userName=datadb[0]['myName'];
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
        body: Column(
          children: [
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: TextField(controller: emailController,decoration: const InputDecoration(
                hintText: "Enter Name",
                labelText: 'Name',
              ),),
            ),
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: TextField(controller: passController,decoration: const InputDecoration(
                hintText: "Enter Number",
                labelText: 'Number',
              ),
              maxLength: 10,),
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                    onPressed: () {
                      String? key = database.ref('UserData').push().key;
                      database.ref('UserData').child(key!).set({
                        'email': emailController.text,
                        'pass': passController.text,
                        'key': key,
                      });
                      clearText();
                      setState(() {
                        refresh();
                      });
                    },
                    child: const Icon(Icons.add)),
                const SizedBox(height: 15.0),
                MaterialButton(
                    onPressed: () {
                      database.ref('UserData').child(selectedKey).update({
                        'email': emailController.text,
                        'pass': passController.text,
                      });
                      clearText();
                      setState(() {
                        refresh();
                      });
                    },
                    child: const Icon(Icons.edit)),
                const SizedBox(height: 15.0),
                MaterialButton(
                    onPressed: () {
                      database.ref('UserData').child(selectedKey).remove();
                      clearText();
                      setState(() {
                        refresh();
                      });
                    },
                    child: const Icon(Icons.delete)),
                const SizedBox(height: 15.0),
                MaterialButton(
                    onPressed: () async {
                      DatabaseEvent d = await database.ref('UserData').once();
                      Map temp = d.snapshot.value as Map;
                      data.clear();
                      temp.forEach((key, value) {
                        data.add(value);
                      });
                      clearText();
                      setState(() {
                        refresh();
                      });
                    },
                    child: const Icon(Icons.refresh)),
              ],
            ),
            const SizedBox(height: 15.0),
            const Text('Click on data to Update and Delete'),
            const SizedBox(height: 15.0),
            Table(
              // defaultColumnWidth: const FixedColumnWidth(120.0),
              border: TableBorder.all(
                  color: Colors.blueAccent,
                  style: BorderStyle.solid,
                  width: 2),
              children: [
                TableRow( children: [
                  Column(children:const [Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Name', style: TextStyle(fontSize: 20.0)),
                  )]),
                  Column(children:const [Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Number', style: TextStyle(fontSize: 20.0)),
                  )]),
                ]),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    emailController.text = data[index]['email'];
                    passController.text = data[index]['pass'];
                    selectedKey = data[index]['key'];
                    setState(() {});
                  },
                  child:Table(
                    // defaultColumnWidth: const FixedColumnWidth(120.0),
                    border: TableBorder.all(
                        color: Colors.teal,
                        style: BorderStyle.solid,
                        width: 1),
                    children: [
                      TableRow( children: [
                        Column(children: [Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data[index]['email'], style: const TextStyle(fontSize: 20.0)),
                        )]),
                        Column(children: [Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data[index]['pass'], style: const TextStyle(fontSize: 20.0)),
                        )]),
                      ]),
                    ],
                  ),
                ),
              ),
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
                title: const Text(' Edit Profile '),
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
