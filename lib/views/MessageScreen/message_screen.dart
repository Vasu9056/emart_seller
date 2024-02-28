import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/MessageScreen/chat_screen.dart';
import 'package:emart_seller/views/Settingscreen/profile_screen.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/widgets/normal_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.to(() => Profilescreen());
            },
            icon: Icon(
              Icons.arrow_back,
              color: darkGrey,
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: white,
          elevation: 0.0,
          title: boldText(text: message, size: 16.0, color: fontGrey),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('chats').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(purpleColor),
                ));
              } else {
                var data = snapshot.data!.docs;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(data.length, (index) {
                        var t = data[index]['created_on'] == null
                            ? DateTime.now()
                            : data[index]['created_on'].toDate();
                        var time = intl.DateFormat("h:mma").format(t);
                        return ListTile(
                          onTap: () {
                            // Navigate to ChatScreen when ListTile is tapped
                            Get.to(() => ChatScreen());
                          },
                          leading: const CircleAvatar(
                            backgroundColor: purpleColor,
                            child: Icon(
                              Icons.person,
                              color: white,
                            ),
                          ),
                          title: boldText(
                              text: "${data[index]['sender_name']}",
                              color: fontGrey),
                          subtitle: normalText(
                            text: "${data[index]['last_msg']}",
                            color: darkGrey,
                          ),
                          trailing: normalText(
                            text: time,
                            color: darkGrey,
                          ),
                        );
                      }),
                    ),
                  ),
                );
              }
            }));
  }
}
