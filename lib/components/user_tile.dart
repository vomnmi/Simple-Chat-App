import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            const Icon(
              Icons.person,
              color: Colors.white,
            ),
            const Gap(5),
            Text(
              text,
              style: GoogleFonts.roboto(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
