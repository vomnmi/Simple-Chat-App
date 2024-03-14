import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser
            ? Theme.of(context).colorScheme.primary
            : Colors.grey.shade500,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Text(
        message,
        style: GoogleFonts.domine(fontSize: 14, color: Colors.white),
      ),
    );
  }
}
