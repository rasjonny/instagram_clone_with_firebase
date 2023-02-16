import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone_with_firebase/views/constants/app_colors.dart';
import 'package:instagram_clone_with_firebase/views/constants/strings.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 44,
      child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
        FaIcon(FontAwesomeIcons.google,
        color:AppColors.googleColor),const SizedBox(width: 10,),
        const Text(Strings.google),
      ],),
    );
  }
}
