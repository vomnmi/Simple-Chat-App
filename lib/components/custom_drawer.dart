import 'package:chat_application/extensions/widget_extension.dart';
import 'package:chat_application/pages/settings.dart';
import 'package:chat_application/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: Center(
                child: Image.asset(
                  'assets/icons/chat.png',
                  height: 58,
                  width: 58,
                ),
              )),
              ListTile(
                title: Text(
                  'H O M E',
                  style: GoogleFonts.roboto(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                leading: Icon(Icons.home,
                    color: Theme.of(context).colorScheme.secondary),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'S E T T I N G S',
                  style: GoogleFonts.roboto(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                leading: Icon(Icons.settings,
                    color: Theme.of(context).colorScheme.secondary),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()));
                },
              ),
            ],
          ),
          ListTile(
            title: Text(
              'L O G  O U T',
              style: GoogleFonts.roboto(
                  color: Theme.of(context).colorScheme.secondary),
            ),
            leading: Icon(Icons.logout,
                color: Theme.of(context).colorScheme.secondary),
            onTap: logout,
          ).paddingOnly(bottom: 15),
        ],
      ),
    );
  }
}
