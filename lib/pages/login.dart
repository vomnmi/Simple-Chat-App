import 'dart:async';

import 'package:chat_application/components/custom_textfield.dart';
import 'package:chat_application/extensions/widget_extension.dart';
import 'package:chat_application/generated/locale_keys.g.dart';
import 'package:chat_application/services/auth/auth_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  final void Function()? onTap;
  const Login({
    super.key,
    required this.onTap,
  });

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isTextFieldVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        isTextFieldVisible = true;
      });
    });
  }

  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _pwController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: Text(e.toString()),
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
                height: isTextFieldVisible ? 100 : 250,
                child: Image.asset(
                  'assets/icons/chat.png',
                  width: 100,
                  height: 100,
                ),
              ),
              const Gap(25),
              AnimatedOpacity(
                opacity: isTextFieldVisible ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 500),
                child: AnimatedContainer(
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeInOut,
                  height: isTextFieldVisible ? 0 : 70,
                  child: Text(
                    LocaleKeys.Welcome_to_Chat_App.tr(),
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: isTextFieldVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: LocaleKeys.Email.tr(),
                      obscure: false,
                      controller: _emailController,
                    ),
                    const Gap(10),
                    CustomTextField(
                      hintText: LocaleKeys.Password.tr(),
                      obscure: true,
                      controller: _pwController,
                    ),
                  ],
                ).paddingAll(15),
              ),
              const Gap(15),
              AnimatedOpacity(
                opacity: isTextFieldVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.primary),
                    shape: const MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () => login(context),
                  child: Text(
                    LocaleKeys.Login.tr(),
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                    ),
                  ).paddingVertical(15),
                ).expandedHorizontally().paddingHorizontal(15),
              ),
              const Gap(30),
              AnimatedOpacity(
                opacity: isTextFieldVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: RichText(
                    text: TextSpan(
                        text: LocaleKeys.Not_Registered_Yet.tr(),
                        style: GoogleFonts.roboto(
                          color: Colors.grey.shade400,
                          fontSize: 12,
                        ),
                        children: [
                      WidgetSpan(
                          child: GestureDetector(
                        onTap: widget.onTap,
                        child: Text(" ${LocaleKeys.Create_an_Account.tr()}!",
                            style: GoogleFonts.roboto(
                              color: Colors.grey.shade900,
                              fontSize: 12,
                            )),
                      ))
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
