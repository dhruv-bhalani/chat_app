import 'package:chat_app/controllers/home_controller.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/routes/routes.dart';
import 'package:chat_app/services/euth_service.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController = HomeController();
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            FutureBuilder(
              future: FireStoreService.fireStoreService.fetchSingleUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error : ${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  DocumentSnapshot<Map<String, dynamic>>? data = snapshot.data;
                  UserModel user = UserModel.fromMap(data: data?.data() ?? {});

                  return UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        AuthService.authService.currentUser!.photoURL ?? "",
                      ),
                    ),
                    accountName: Text(user.name),
                    accountEmail: Text(user.email),
                  );
                }
                return Container();
              },
            ),
            ListTile(
              onTap: () {
                homeController.singOut();
                Get.offNamed('/login');
              },
              leading: const Icon(Icons.logout),
              title: const Text("Log out"),
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Chat App'),
      ),
      body: StreamBuilder(
        stream: FireStoreService.fireStoreService.fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error : ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;
            List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =
                data?.docs ?? [];
            List<UserModel> allUsers = allDocs
                .map(
                  (e) => UserModel.fromMap(data: e.data()),
                )
                .toList();
            return ListView.builder(
              itemCount: allUsers.length,
              itemBuilder: (context, index) {
                var user = allUsers[index];
                return Container(
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    onTap: () {
                      Get.toNamed(Routes.chat, arguments: user);
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.image),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
