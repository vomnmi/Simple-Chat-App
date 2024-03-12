// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_application/components/custom_textfield.dart';
import 'package:chat_application/extensions/widget_extension.dart';
import 'package:chat_application/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class Register extends StatelessWidget {
  Register({
    super.key,
  });
  bool isTextFieldVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwConfirmController = TextEditingController();

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
                height: isTextFieldVisible ? 82 : 150,
                child: Image.asset(
                  'assets/icons/chat.png',
                  width: 82,
                  height: 82,
                ),
              ),
              Text(
                'Welcome to Chat App',
                style: GoogleFonts.domine(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Column(
                children: [
                  CustomTextField(
                    hintText: 'Email',
                    obscure: false,
                    controller: _emailController,
                  ),
                  const Gap(10),
                  CustomTextField(
                    hintText: 'Password',
                    obscure: false,
                    controller: _pwController,
                  ),
                  const Gap(10),
                  CustomTextField(
                    hintText: 'Confirm Password',
                    obscure: true,
                    controller: _pwConfirmController,
                  )
                ],
              ).paddingAll(15),
              const Gap(15),
              ElevatedButton(
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
                onPressed: () {},
                child: Text(
                  'Register',
                  style: GoogleFonts.domine(
                    color: Colors.white,
                  ),
                ).paddingVertical(15),
              ).expandedHorizontally().paddingHorizontal(15),
              const Gap(30),
              RichText(
                  text: TextSpan(
                      text: 'Already Registered?',
                      style: GoogleFonts.domine(
                        color: Colors.grey.shade400,
                        fontSize: 12,
                      ),
                      children: [
                    WidgetSpan(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ));
                      },
                      child: Text(' Sign In!',
                          style: GoogleFonts.domine(
                            color: Colors.grey.shade900,
                            fontSize: 12,
                          )),
                    ))
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
