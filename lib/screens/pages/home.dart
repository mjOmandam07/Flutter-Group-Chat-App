import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/controllers/auth_controller.dart';
import 'package:hive/controllers/gc_list_controller.dart';
import 'package:hive/controllers/user_controller.dart';
import 'package:hive/screens/chats/chat.dart';
import 'package:hive/screens/chats/create_join_gc.dart';
import 'package:page_transition/page_transition.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  void _onItemTapped(int index) {
    if (index == 0) {
      _key.currentState?.openDrawer();
    } else if (index == 1) {
      _logoutDialog();
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logoutDialog() {
    showDialog(
      context: context, barrierDismissible: true, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          elevation: 24.0,
          title: new Text(
            'Buzzing off so soon?',
            style: TextStyle(fontFamily: 'Montserrat-SemiBold'),
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text(
                  'Are you sure you want to buzz off from Hive? We\'ll miss you and your honeycombed messages',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
              ],
            ),
          ),
          actions: [
            Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color.fromRGBO(253, 197, 8, 1),
                      width: 0.8,
                    )),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                    child: Text(
                      'Stay',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color.fromRGBO(253, 197, 8, 1),
                      ),
                    ))),
            Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(253, 197, 8, 1),
                    borderRadius: BorderRadius.circular(5)),
                child: TextButton(
                    onPressed: () {
                      GC_Controller.instance.refresh_gc();
                      AuthController.instance.logout();
                      // Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                    child: Text(
                      'Buzz off',
                      style: TextStyle(
                          fontFamily: 'Montserrat', color: Colors.white),
                    )))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(234, 234, 234, 1),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(253, 197, 8, 1),
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: CreateGroupChat(),
                  duration: Duration(milliseconds: 400)));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.

          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text("Setting",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        fontSize: 27,
                        color: Colors.white)),
              ),
              decoration: BoxDecoration(color: Color.fromRGBO(253, 197, 8, 1)),
            ),
            ListTile(
              leading: Icon(
                Icons.person_2_outlined,
              ),
              title: const Text('Configure Account',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 16)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.dark_mode,
              ),
              title: const Text('Dark Mode',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 16)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        unselectedItemColor: Color.fromRGBO(253, 197, 8, 1),
        fixedColor: Color.fromRGBO(253, 197, 8, 1),
        backgroundColor: Color.fromRGBO(21, 21, 21, 1),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Color.fromRGBO(253, 197, 8, 1),
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromRGBO(253, 197, 8, 1),
            icon: Icon(Icons.exit_to_app),
            label: 'Log Out',
          ),
        ],
      ),
      body: GetBuilder<UserController>(builder: (_) {
        if (UserController.instance.user == null) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Color.fromRGBO(253, 197, 8, 1),
            color: Color.fromRGBO(21, 21, 21, 1),
          ));
        } else {
          GC_Controller.instance
              .getUserGroupChats(UserController.instance.user['user_id']);
          return Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(16, 50, 10, 16),
                child: TextField(
                  // textAlign: TextAlign.center,
                  cursorColor: Color.fromRGBO(253, 197, 8, 1),
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Search Hive",
                      hintStyle: TextStyle(
                        fontFamily: 'Montserrat-Semibold',
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(253, 197, 8, 1))),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white))),
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height * 0.75,
                // color: Colors.white,
                child: GetBuilder<GC_Controller>(builder: (_) {
                  if (GC_Controller.instance.gc_refreshed == false) {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Color.fromRGBO(253, 197, 8, 1),
                      color: Color.fromRGBO(21, 21, 21, 1),
                    ));
                  } else {
                    if (GC_Controller.instance.gc_list.length == 0) {
                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Text(
                            'No Hive?',
                            style: TextStyle(
                                color: Color.fromRGBO(253, 197, 8, 1),
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w900,
                                fontSize: 70),
                          ),
                          Text(
                            'Join or Create Hive now!',
                            style: TextStyle(
                                color: Color.fromRGBO(253, 197, 8, 1),
                                fontFamily: 'Montserrat',
                                fontSize: 26),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.bottomToTop,
                                      child: CreateGroupChat(),
                                      duration: Duration(milliseconds: 400)));
                              //     .then((value) {
                              //   Future.delayed(const Duration(seconds: 1),
                              //       () async {
                              //     print("asdadsd");
                              //     GC_Controller.instance.getUserGroupChats(
                              //         UserController.instance.user['user_id']);
                              //   });
                              // });
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 15, right: 15, top: 15),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.07,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(253, 197, 8, 1),
                                  borderRadius: BorderRadius.circular(18)),
                              child: Center(
                                child: Text(
                                  'New Hive',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Montserrat-SemiBold'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      var gc = GC_Controller.instance.gc_list.reversed.toList();
                      return ListView.builder(
                        itemCount: gc.length,
                        padding: const EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: Chat(
                                        gc_details: gc[index],
                                      ),
                                      duration: Duration(milliseconds: 300)));
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.only(left: 11, top: 3),
                              height: MediaQuery.of(context).size.height * 0.17,
                              child: Text(gc[index]['name'],
                                  style: TextStyle(
                                      color: Color.fromRGBO(253, 197, 8, 1),
                                      fontSize: 30,
                                      fontFamily: 'Montserrat')),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image:
                                          AssetImage("assets/img/sample.jpg"),
                                      fit: BoxFit.cover)),
                            ),
                          );
                        },
                      );
                    }
                  }
                }),
              )
            ],
          );
        }
      }),
    );
  }
}
