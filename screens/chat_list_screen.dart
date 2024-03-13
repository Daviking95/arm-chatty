import 'package:all_flutter_gives/arm_test_code/network_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/onboarding_provider.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onboardingProvider = context.watch<OnboardingProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${AppConstant.userCredential?.email ?? ""}', style: TextStyle(fontSize: 14),),
        actions: [
          InkWell(
            onTap: () {
              onboardingProvider.signOut(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                Icons.login,
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with the actual number of group chats
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  // You can use the group chat's image here
                  child: Icon(Icons.group),
                ),
                title: Text('Group Chat ${index + 1}'),
                subtitle: Text('Last message in the group chat'),
                // You can show the last message here
                onTap: () {
                  // Navigate to the group chat details page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GroupChatDetailsPage()),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class GroupChatDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat Details'),
      ),
      body: Center(
        child: Text('Details of the selected group chat'),
      ),
    );
  }
}
