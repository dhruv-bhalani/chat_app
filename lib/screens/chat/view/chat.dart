import 'dart:developer';

import 'package:chat_app/helper/extentions.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/euth_service.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:chat_app/services/notiFication_sevice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    UserModel user = Get.arguments;
    TextEditingController messageController = TextEditingController();
    TextEditingController editMsgController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(user.image),
            ),
            10.w,
            Flexible(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${user.name}\n",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: user.email,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.call,
              size: 25,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.video_call,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            20.h,
            const Row(
              children: [
                Spacer(
                  flex: 6,
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: FireStoreService.fireStoreService.fetchChats(
                  sender: AuthService.authService.currentUser!.email ?? "",
                  receiver: user.email,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data;
                    List<QueryDocumentSnapshot<Map<String, dynamic>>> allData =
                        data!.docs;

                    List<ChatModal> allChats = allData
                        .map(
                          (e) => ChatModal.fromMap(
                            data: e.data(),
                          ),
                        )
                        .toList();
                    return (allChats.isEmpty)
                        ? const Center(
                            child: Image(
                              image: AssetImage("assets/gif/noMsg.gif"),
                              fit: BoxFit.cover,
                            ),
                          )
                        : ListView.builder(
                            itemCount: allChats.length,
                            itemBuilder: (context, index) =>
                                (allChats[index].receiver == user.email)
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Flexible(
                                            child: GestureDetector(
                                              onLongPress: () {
                                                Get.defaultDialog(
                                                    title: "Options",
                                                    radius: 10,
                                                    content: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            FireStoreService
                                                                .fireStoreService
                                                                .deleteChat(
                                                              sender: AuthService
                                                                      .authService
                                                                      .currentUser!
                                                                      .email ??
                                                                  "",
                                                              receiver:
                                                                  user.email,
                                                              id: allData[index]
                                                                  .id,
                                                            );
                                                            Get.back();
                                                          },
                                                          icon: const Icon(
                                                              Icons.delete),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            FireStoreService
                                                                .fireStoreService
                                                                .deleteChat(
                                                              sender: AuthService
                                                                      .authService
                                                                      .currentUser!
                                                                      .email ??
                                                                  "",
                                                              receiver:
                                                                  user.email,
                                                              id: allData[index]
                                                                  .id,
                                                            );
                                                          },
                                                          icon: const Icon(
                                                              Icons.copy),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            Get.back();
                                                            editMsgController
                                                                    .text =
                                                                allChats[index]
                                                                    .msg;
                                                            Get.bottomSheet(
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10),
                                                                height: 200,
                                                                child: Column(
                                                                  children: [
                                                                    TextField(
                                                                      onSubmitted:
                                                                          (value) {
                                                                        FireStoreService
                                                                            .fireStoreService
                                                                            .editChat(
                                                                          sender:
                                                                              AuthService.authService.currentUser!.email ?? "",
                                                                          receiver:
                                                                              user.email,
                                                                          id: allData[index]
                                                                              .id,
                                                                          msg:
                                                                              value,
                                                                        );
                                                                      },
                                                                      controller:
                                                                          editMsgController,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        label: const Text(
                                                                            "Edit Message"),
                                                                        suffixIcon:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            Get.back();
                                                                            FireStoreService.fireStoreService.editChat(
                                                                              sender: AuthService.authService.currentUser!.email ?? "",
                                                                              receiver: user.email,
                                                                              id: allData[index].id,
                                                                              msg: editMsgController.text,
                                                                            );
                                                                          },
                                                                          icon:
                                                                              const Icon(Icons.send),
                                                                        ),
                                                                        border:
                                                                            const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(
                                                                            Radius.circular(
                                                                              10,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          icon: const Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.blue),
                                                        ),
                                                      ],
                                                    ));
                                              },
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Text(
                                                  allChats[index].msg,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(10),
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(allChats[index].msg),
                                          )
                                        ],
                                      ),
                          );
                  }
                  return Container();
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    onSubmitted: (value) async {
                      if (value.isNotEmpty) {
                        String senderEmail =
                            AuthService.authService.currentUser!.email ?? "";
                        FireStoreService.fireStoreService.sentChat(
                          chatModal: ChatModal(
                            msg: value,
                            sender: senderEmail,
                            receiver: user.email,
                            time: Timestamp.now(),
                          ),
                        );
                      }
                      messageController.clear();
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      hintText: "Type a message...",
                      suffixIcon: IconButton(
                        onPressed: () async {
                          log("==============token==============:${user.token}:=========================");
                          String msg = messageController.text;
                          String senderEmail =
                              AuthService.authService.currentUser!.email ?? "";
                          if (msg.isNotEmpty) {
                            FireStoreService.fireStoreService.sentChat(
                              chatModal: ChatModal(
                                msg: msg,
                                sender: senderEmail,
                                receiver: user.email,
                                time: Timestamp.now(),
                              ),
                            );
                            messageController.clear();
                            Notifications.notifications.sendNotification(
                              title:
                                  AuthService.authService.currentUser!.email ??
                                      "",
                              body: msg,
                              token: user.token,
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
