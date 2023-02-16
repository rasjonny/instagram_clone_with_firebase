import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone_with_firebase/views/constants/app_colors.dart';
import 'package:instagram_clone_with_firebase/views/constants/strings.dart';

class FacebookLoginButton extends StatelessWidget {
  const FacebookLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 44,
      child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
        FaIcon(FontAwesomeIcons.facebook,
        color:AppColors.facebookColor),const SizedBox(width: 10,),
        const Text(Strings.facebook),
      ],),
    );
  }
}
