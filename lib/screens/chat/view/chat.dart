import 'package:chat_app/controllers/chat_controller.dart';
import 'package:chat_app/helper/extentions.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/euth_service.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:chat_app/services/notiFication_sevice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:chatview/chatview.dart';

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
    final ChatController chatController = ChatController(
      initialMessageList: [
        Message(
          id: '1',
          message: "Hello!",
          createdAt: DateTime.now(),
          sentBy: "user1",
        ),
      ],
      scrollController: ScrollController(),
      otherUsers: [],
      currentUser: ChatUser(id: "user1", name: user.name),
    );

    // ChatController controller = Get.put(ChatController());
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
      body: ChatView(
        chatController: ChatController(
          initialMessageList: [],
          scrollController: ScrollController(),
          otherUsers: [],
          currentUser: ChatUser(id: "user1", name: "name"),
        ),
        chatViewState: ChatViewState.hasMessages,
      ),
    );
  }
}

/* GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          controller.closeemoji();
        },
        child: Padding(
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
                  stream: FireStoreService.service.fetchChats(
                    sender: AuthService.authServices.currentUser!.email ?? "",
                    receiver: user.email,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data;
                      List<QueryDocumentSnapshot<Map<String, dynamic>>>
                          allData = data!.docs;

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
                              itemBuilder: (context, index) {
                                if (allChats[index].receiver == user.email) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
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
                                                      FireStoreService.service
                                                          .deleteChat(
                                                        sender: AuthService
                                                                .authServices
                                                                .currentUser!
                                                                .email ??
                                                            "",
                                                        receiver: user.email,
                                                        id: allData[index].id,
                                                      );
                                                      Get.back();
                                                    },
                                                    icon: const Icon(
                                                        Icons.delete),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      Clipboard.setData(
                                                        ClipboardData(
                                                          text: allChats[index]
                                                              .msg,
                                                        ),
                                                      ).then(
                                                        (value) => Get.snackbar(
                                                          "Copied",
                                                          "Copied to clipboard",
                                                          backgroundColor:
                                                              Colors.black,
                                                          colorText:
                                                              Colors.white,
                                                        ),
                                                      );
                                                    },
                                                    icon:
                                                        const Icon(Icons.copy),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      Get.back();
                                                      editMsgController.text =
                                                          allChats[index].msg;
                                                      Get.bottomSheet(
                                                        Container(
                                                          height: 350,
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              TextField(
                                                                focusNode:
                                                                    controller
                                                                        .focusNode,
                                                                onTap: () {
                                                                  controller
                                                                      .closeemoji();
                                                                },
                                                                onSubmitted:
                                                                    (value) {
                                                                  FireStoreService
                                                                      .service
                                                                      .editChat(
                                                                    sender: AuthService
                                                                            .authServices
                                                                            .currentUser!
                                                                            .email ??
                                                                        "",
                                                                    receiver: user
                                                                        .email,
                                                                    id: allData[
                                                                            index]
                                                                        .id,
                                                                    msg: value,
                                                                  );
                                                                },
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                                controller:
                                                                    editMsgController,
                                                                decoration:
                                                                    InputDecoration(
                                                                  label: const Text(
                                                                      "Edit Message"),
                                                                  prefixIcon:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      controller
                                                                          .openemoji();
                                                                    },
                                                                    icon: Obx(
                                                                      () {
                                                                        return Icon(
                                                                          controller.isVisible.value
                                                                              ? Icons.keyboard
                                                                              : Icons.emoji_emotions,
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  suffixIcon:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      Get.back();
                                                                      controller
                                                                          .closeemoji();
                                                                      FireStoreService
                                                                          .service
                                                                          .editChat(
                                                                        sender:
                                                                            AuthService.authServices.currentUser!.email ??
                                                                                "",
                                                                        receiver:
                                                                            user.email,
                                                                        id: allData[index]
                                                                            .id,
                                                                        msg: editMsgController
                                                                            .text,
                                                                      );
                                                                    },
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .send),
                                                                  ),
                                                                  border:
                                                                      const OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          10),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              10.h,
                                                              Obx(
                                                                () {
                                                                  return controller
                                                                          .isVisible
                                                                          .value
                                                                      ? SizedBox(
                                                                          height:
                                                                              200,
                                                                          child:
                                                                              EmojiPicker(
                                                                            onEmojiSelected:
                                                                                (category, emoji) {
                                                                              editMsgController.text = editMsgController.text + emoji.emoji;
                                                                            },
                                                                          ),
                                                                        )
                                                                      : const SizedBox
                                                                          .shrink();
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    icon: const Icon(Icons.edit,
                                                        color: Colors.blue),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  allChats[index].msg,
                                                ),
                                                // 5.w,
                                                // Align(
                                                //   alignment:
                                                //       Alignment.bottomRight,
                                                //   child: Visibility(
                                                //     child: Icon(
                                                //       Icons.done_all,
                                                //       color: allChats[index]
                                                //                   .status ==
                                                //               "seen"
                                                //           ? Colors.green
                                                //           : Colors.red,
                                                //     ),
                                                //   ),
                                                // )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  FireStoreService.service.seenChat(
                                    id: allData[index].id,
                                    receiver: user.email,
                                    sent: AuthService
                                            .authServices.currentUser!.email ??
                                        '',
                                  );
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: GestureDetector(
                                          onDoubleTap: () {

                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              allChats[index].msg,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                }
                              },
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
                      focusNode: controller.focusNode,
                      onTap: () {
                        controller.closeemoji();
                      },
                      // onSubmitted: (value) async {
                      //   if (value.isNotEmpty) {
                      //     String senderEmail =
                      //         AuthService.authServices.currentUser!.email ?? "";
                      //     FireStoreService.service.sentChat(
                      //       chatModal: ChatModal(
                      //         msg: value,
                      //         sender: senderEmail,
                      //         receiver: user.email,
                      //         time: Timestamp.now(),
                      //         status: 'unseen',
                      //       ),
                      //     );
                      //   }
                      //   messageController.clear();
                      // },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        hintText: "Type a message...",
                        prefixIcon: IconButton(
                          onPressed: () {
                            controller.openemoji();
                          },
                          icon: Obx(() {
                            return Icon(
                              controller.isVisible.value
                                  ? Icons.keyboard
                                  : Icons.emoji_emotions,
                            );
                          }),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            String msg = messageController.text;
                            String senderEmail =
                                AuthService.authServices.currentUser!.email ??
                                    "";
                            if (msg.isNotEmpty) {
                              FireStoreService.service.sentChat(
                                chatModal: ChatModal(
                                  msg: msg,
                                  sender: senderEmail,
                                  receiver: user.email,
                                  time: Timestamp.now(),
                                  status: 'unseen',
                                ),
                              );
                              messageController.clear();
                              controller.closeemoji();
                              Notifications.notifications.sendNotification(
                                title: AuthService.authServices.currentUser!
                                        .displayName ??
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
              Obx(
                () {
                  return controller.isVisible.value
                      ? SizedBox(
                          height: 250,
                          child: EmojiPicker(
                            onEmojiSelected: (category, emoji) {
                              messageController.text =
                                  messageController.text + emoji.emoji;
                            },
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),*/
