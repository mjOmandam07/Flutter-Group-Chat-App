import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/controllers/chat_controller.dart';
import 'package:hive/controllers/gc_list_controller.dart';
import 'package:hive/screens/chats/gc_details.dart';
import 'package:hive/screens/pages/home.dart';
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

  @override
  Widget build(BuildContext context) {
    widget.gc_details;
    double iconSize = MediaQuery.of(context).size.width;
    if (WidgetsBinding.instance.window.viewInsets.bottom != 0.0) {
      iconSize = 0;
    } else {
      iconSize = MediaQuery.of(context).size.width;
    }
    Chat_Controller chat_controller = Get.put(Chat_Controller());
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: Color.fromRGBO(249, 243, 222, 1),
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
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
                  GC_Controller.instance
                      .GetGCDetails(widget.gc_details['code']);
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.leftToRight,
                          child: GC_Details(),
                          duration: Duration(milliseconds: 300)));
                },
                child: Text(
                  widget.gc_details['name'],
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
                    '${widget.gc_details['people'].length.toString()} People',
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
            child: GetBuilder<Chat_Controller>(builder: (_) {
              return ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(0),
                itemCount: chat_controller.chats.length,
                itemBuilder: (context, index) {
                  if (chat_controller.chats[index]['sender'] == 'Oswng') {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  Text('You',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 151, 151, 151),
                                          fontSize: 15,
                                          fontFamily: 'Montserrat-SemiBold'))
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 5, left: 15, right: 15, bottom: 5),
                                padding: EdgeInsets.all(20),
                                // height: MediaQuery.of(context).size.height * 0.17,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                    '''${chat_controller.chats[index]['msg_payload']}''',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: Color.fromRGBO(68, 68, 68, 1),
                                        fontSize: 15,
                                        fontFamily: 'Montserrat')),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                  color: Color.fromRGBO(253, 197, 8, 1),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 25),
                                child: Text(
                                    chat_controller.chats[index]['datetime'],
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 151, 151, 151),
                                        fontSize: 15,
                                        fontFamily: 'Montserrat-SemiBold')),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/img/sample.jpg"),
                                            fit: BoxFit.cover)),
                                  ),
                                  Text(chat_controller.chats[index]['sender'],
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 151, 151, 151),
                                          fontSize: 15,
                                          fontFamily: 'Montserrat-SemiBold'))
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 5, left: 15, right: 15, bottom: 5),
                                padding: EdgeInsets.all(20),
                                // height: MediaQuery.of(context).size.height * 0.17,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                    '''${chat_controller.chats[index]['msg_payload']}''',
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
                              Container(
                                margin: EdgeInsets.only(left: 25),
                                child: Text(
                                    chat_controller.chats[index]['datetime'],
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 151, 151, 151),
                                        fontSize: 15,
                                        fontFamily: 'Montserrat-SemiBold')),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            }),
          ),
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
                      chat_controller.addNewMessage(chatFieldController.text);
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
