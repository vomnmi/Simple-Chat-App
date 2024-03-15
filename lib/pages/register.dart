// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_application/components/custom_textfield.dart';
import 'package:chat_application/extensions/widget_extension.dart';
import 'package:chat_application/generated/locale_keys.g.dart';
import 'package:chat_application/services/auth/auth_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class Register extends StatelessWidget {
  Register({
    super.key,
    required this.onTap,
  });
  bool isTextFieldVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwConfirmController = TextEditingController();

  final void Function()? onTap;
  // Register Method
  void register(BuildContext context) {
    //get Auth service
    final auth = AuthService();

    //if Passwords match, creating the account

    if (_pwController.text == _pwConfirmController.text) {
      try {
        auth.signUpWithEmailPassword(_emailController.text, _pwController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  title: Text(e.toString()),
                )));
      }
      // If not match
    } else {
      showDialog(
          context: context,
          builder: ((context) => const AlertDialog(
                title: Text("Passwords don't match!"),
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
        body: SingleChildScrollView(
          child: Center(
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
                  LocaleKeys.Welcome_to_Chat_App.tr(),
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Column(
                  children: [
                    CustomTextField(
                      hintText: LocaleKeys.Email.tr(),
                      obscure: false,
                      controller: _emailController,
                    ),
                    const Gap(10),
                    CustomTextField(
                      hintText: LocaleKeys.Password.tr(),
                      obscure: false,
                      controller: _pwController,
                    ),
                    const Gap(10),
                    CustomTextField(
                      hintText: LocaleKeys.Confirm_Password.tr(),
                      obscure: true,
                      controller: _pwConfirmController,
                    )
                  ],
                ).paddingAll(15),
                const Gap(14),
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
                  onPressed: () => register(context),
                  child: Text(
                    LocaleKeys.Register.tr(),
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                    ),
                  ).paddingVertical(15),
                ).expandedHorizontally().paddingHorizontal(15),
                const Gap(30),
                RichText(
                    text: TextSpan(
                        text: LocaleKeys.Already_Registered.tr(),
                        style: GoogleFonts.roboto(
                          color: Colors.grey.shade400,
                          fontSize: 12,
                        ),
                        children: [
                      WidgetSpan(
                          child: GestureDetector(
                        onTap: onTap,
                        child: Text(" ${LocaleKeys.Sign_In.tr()}!",
                            style: GoogleFonts.roboto(
                              color: Colors.grey.shade900,
                              fontSize: 12,
                            )),
                      ))
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
