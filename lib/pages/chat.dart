import 'package:chat_application/components/chat_bubble.dart';
import 'package:chat_application/components/custom_textfield.dart';
import 'package:chat_application/services/auth/auth_service.dart';
import 'package:chat_application/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  const ChatPage(
      {super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  // chat & auth services
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });

    Future.delayed(
      const Duration(milliseconds: 100),
      () => scrollDown(),
    );
  }

  //Scroll controller
  final ScrollController scrollController = ScrollController();

  void scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // sending message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverID, _messageController.text);

      _messageController.clear();
      scrollDown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.receiverEmail),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessagesList(),
          ),
          _buildUserInput(context),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverID, senderID),
        builder: ((context, snapshot) {
          //errors
          if (snapshot.hasError) {
            return const Text('Error');
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          // return ListView

          return ListView(
            controller: scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        }));
  }

  // Building message Item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data["message"], isCurrentUser: isCurrentUser)
        ],
      ),
    );
  }

  Widget _buildUserInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 5),
      child: Row(
        children: [
          Expanded(
              child: CustomTextField(
            focusNode: myFocusNode,
            controller: _messageController,
            hintText: "Type a message",
            obscure: false,
          )),
          const Gap(5),
          IconButton(
            onPressed: sendMessage,
            icon: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
