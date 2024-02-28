import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/Orderscreen/componets/chat_bubble.dart';
import 'package:emart_seller/views/MessageScreen/message_screen.dart';
import 'package:emart_seller/views/widgets/normal_test.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MessageScreen()));
          },
          child: Icon(
            Icons.arrow_back,
            color: darkGrey,
          ),
        ),
        backgroundColor: white,
        elevation: 0.0,
        title: boldText(text: chats, size: 16.0, color: fontGrey),
      ),
      body: Padding(
        padding: EdgeInsets.all(9),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ChatBubble();
                },
              ),
            ),
            10.heightBox,
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: "Enter message",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: purpleColor)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: purpleColor),
                          )),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.send,
                        color: purpleColor,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
