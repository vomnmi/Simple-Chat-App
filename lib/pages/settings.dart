import 'package:chat_application/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('Settings'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.secondary),
        child: Row(
          children: [
            Text(
              'Dark mode',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Switch(
              activeTrackColor: Colors.white,
              value: Provider.of<ThemeProvider>(
                context,
                listen: false,
              ).isDarkMode,
              onChanged: (value) => Provider.of<ThemeProvider>(
                context,
                listen: false,
              ).toggleTheme(),
            ),
          ],
        ),
      ),
    );
  }
}
