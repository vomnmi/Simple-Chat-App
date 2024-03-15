import 'package:chat_application/components/custom_drawer.dart';
import 'package:chat_application/components/user_tile.dart';
import 'package:chat_application/generated/locale_keys.g.dart';
import 'package:chat_application/pages/chat.dart';
import 'package:chat_application/services/auth/auth_service.dart';
import 'package:chat_application/services/chat/chat_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});

  //chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(LocaleKeys.Inbox.tr()),
      ),
      drawer: const CustomDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          //Error
          if (snapshot.hasError) {
            return Text(LocaleKeys.Error.tr());
          }
          //Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text(LocaleKeys.Loading.tr());
          }

          //returning ListView
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display All users except current user
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        receiverEmail: userData["email"],
                        receiverID: userData["uid"],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
