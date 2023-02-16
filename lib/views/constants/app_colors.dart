
import 'package:flutter/material.dart' show Colors,immutable;
import 'package:instagram_clone_with_firebase/extension/string/as_html_color_to_app_color.dart';

@immutable
class AppColors {
  static final loginButtonColor ='#cfc9c2'.htmlColorToColor();
  static const loginButtonTextColor=Colors.black;
  static final googleColor  ='#4285F4'.htmlColorToColor();
  static final  facebookColor='#3b5998'.htmlColorToColor();
  
  const AppColors._();
}
