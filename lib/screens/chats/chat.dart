import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/controllers/chat_controller.dart';
import 'package:hive/controllers/gc_list_controller.dart';
import 'package:hive/controllers/user_controller.dart';
import 'package:hive/screens/chats/gc_details.dart';
import 'package:hive/screens/pages/home.dart';
import 'package:hive/screens/utils/snackbars/snacks.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class Chat extends StatefulWidget {
  var gc_details;
  Chat({Key? key, required this.gc_details}) : super(key: key);

  /* CHAR2 RANI 'Map gc_details' PERO ANG PLANO JD KAY (ANG CODE ANG IPASA? OR ANG DETAILS MISMO SA GC ANG IPASA?) 
  DAYON ANG CODE GAMITON INIG FETCH SA MGA CHAT
  */
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var chatFieldController = TextEditingController();
  var datetime = DateFormat.yMMMd().add_jm();

  @override
  Widget build(BuildContext context) {
    widget.gc_details;
    var group_chat_details = GC_Controller.instance.gc_details;
    double iconSize = MediaQuery.of(context).size.width;
    if (WidgetsBinding.instance.window.viewInsets.bottom != 0.0) {
      iconSize = 0;
    } else {
      iconSize = MediaQuery.of(context).size.width;
    }
    Chat_Controller.instance.getMessages(group_chat_details['code']);
    // Chat_Controller chat_controller = Get.put(Chat_Controller());
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: Color.fromRGBO(249, 243, 222, 1),
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () async {
              await Chat_Controller.instance.refreshMessages();
              Navigator.pop(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: Home(),
                      duration: Duration(milliseconds: 600)));
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  // GC_Controller.instance
                  //     .GetGCDetails(widget.gc_details['code']);
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.leftToRight,
                          child: GC_Details(),
                          duration: Duration(milliseconds: 300)));
                },
                child: Text(
                  group_chat_details['name'],
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                      fontSize: 25),
                ),
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green[700],
                        borderRadius: BorderRadius.circular(30)),
                    height: MediaQuery.of(context).size.height * 0.014,
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Text(
                    '9 Active',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontSize: 15),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Text(
                    '${group_chat_details['people'].length.toString()} People',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.video_call_rounded,
                size: 35,
              ),
              color: Color.fromRGBO(253, 197, 8, 1),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.04,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.call_outlined,
                size: 25,
              ),
              color: Color.fromRGBO(253, 197, 8, 1),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: Chat_Controller.instance.message_table
                      .orderBy('timestamp', descending: true)
                      .where("gc_code", isEqualTo: group_chat_details['code'])
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      Snacks().snack_failed(
                          'Loading of messages failed', 'Something went wrong');
                      print('ERROR' + snapshot.error.toString());
                      return Text(
                        'Something went wrong',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(253, 197, 8, 1),
                            fontFamily: 'Montserrat',
                            fontSize: 20),
                      );
                    }

                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Color.fromRGBO(253, 197, 8, 1),
                          color: Color.fromRGBO(3, 3, 3, 1),
                        ),
                      );
                    } else {
                      if (snapshot.data!.docs.length == 0) {
                        return Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Center(
                              child: Text(
                                'Welcome to',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(253, 197, 8, 1),
                                    fontFamily: 'Montserrat',
                                    fontSize: 20),
                              ),
                            ),
                            Text(
                              '${group_chat_details['name']}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(253, 197, 8, 1),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30),
                            ),
                            Center(
                              child: Text(
                                'Start Buzzing Now',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(253, 197, 8, 1),
                                    fontFamily: 'Montserrat',
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return ListView.builder(
                          reverse: true,
                          padding: const EdgeInsets.all(0),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot doc = snapshot.data?.docs[index];

                            if (doc['sender'] ==
                                UserController.instance.user['user_id']) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                            ),
                                            Text('You',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 151, 151, 151),
                                                    fontSize: 15,
                                                    fontFamily:
                                                        'Montserrat-SemiBold'))
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 5,
                                              left: 15,
                                              right: 15,
                                              bottom: 5),
                                          padding: EdgeInsets.all(20),
                                          // height: MediaQuery.of(context).size.height * 0.17,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Text('''${doc['message']}''',
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      68, 68, 68, 1),
                                                  fontSize: 15,
                                                  fontFamily: 'Montserrat')),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(20),
                                            ),
                                            color:
                                                Color.fromRGBO(253, 197, 8, 1),
                                          ),
                                        ),
                                        if (doc['timestamp'] == null)
                                          Container(
                                            height: 7,
                                            width: 7,
                                            child: CircularProgressIndicator(
                                              backgroundColor: Color.fromRGBO(
                                                  253, 197, 8, 1),
                                              color: Color.fromRGBO(
                                                  145, 141, 141, 1),
                                            ),
                                          )
                                        else
                                          Container(
                                            margin: EdgeInsets.only(left: 25),
                                            child: Text(
                                                '${datetime.format(doc['timestamp'].toDate())}',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 151, 151, 151),
                                                    fontSize: 15,
                                                    fontFamily:
                                                        'Montserrat-SemiBold')),
                                          )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/img/sample.jpg"),
                                                      fit: BoxFit.cover)),
                                            ),
                                            FutureBuilder(
                                                future: UserController.instance
                                                    .getUsernamebyUserid(
                                                        doc['sender']),
                                                builder: (_, snapshot) {
                                                  if (snapshot.data == null) {
                                                    return CircularProgressIndicator(
                                                      backgroundColor:
                                                          Color.fromRGBO(
                                                              171, 171, 171, 1),
                                                      color: Color.fromRGBO(
                                                          138, 138, 138, 1),
                                                    );
                                                  } else {
                                                    return Text(snapshot.data,
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    151,
                                                                    151,
                                                                    151),
                                                            fontSize: 15,
                                                            fontFamily:
                                                                'Montserrat-SemiBold'));
                                                  }
                                                })
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 5,
                                              left: 15,
                                              right: 15,
                                              bottom: 5),
                                          padding: EdgeInsets.all(20),
                                          // height: MediaQuery.of(context).size.height * 0.17,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Text('''${doc['message']}''',
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontFamily: 'Montserrat')),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                            ),
                                            color: Colors.white,
                                          ),
                                        ),
                                        if (doc['timestamp'] == null)
                                          Container(
                                            height: 7,
                                            width: 7,
                                            child: CircularProgressIndicator(
                                              backgroundColor: Color.fromRGBO(
                                                  253, 197, 8, 1),
                                              color: Color.fromRGBO(3, 3, 3, 1),
                                            ),
                                          )
                                        else
                                          Container(
                                            margin: EdgeInsets.only(left: 25),
                                            child: Text(
                                                '${datetime.format(doc['timestamp'].toDate())}',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 151, 151, 151),
                                                    fontSize: 15,
                                                    fontFamily:
                                                        'Montserrat-SemiBold')),
                                          )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        );
                      }
                    }
                  })),
        ),
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.all(15),
            // height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.zero,
                  width: iconSize * 0.24,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.camera_alt,
                          size: 30,
                        ),
                        color: Color.fromRGBO(253, 197, 8, 1),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.photo,
                          size: 30,
                        ),
                        color: Color.fromRGBO(253, 197, 8, 1),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: chatFieldController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    cursorColor: Color.fromRGBO(253, 197, 8, 1),
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(249, 243, 222, 1),
                        hintText: "Message",
                        hintStyle: TextStyle(fontFamily: 'Montserrat'),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(253, 197, 8, 1))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide(color: Colors.white))),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                // Send Button
                IconButton(
                  onPressed: () {
                    // print(chatFieldController.text);
                    if (chatFieldController.text != '') {
                      var user_id = UserController.instance.user['user_id'];
                      var msg = chatFieldController.text;
                      var code = group_chat_details['code'];
                      Chat_Controller.instance
                          .addNewMessage(user_id, msg, code);
                    }
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    chatFieldController.clear();
                  },
                  icon: Icon(
                    Icons.send,
                    size: 25,
                  ),
                  color: Color.fromRGBO(253, 197, 8, 1),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
