import 'package:flutter/foundation.dart';
import 'package:instagram_clone_with_firebase/views/components/constants/strings.dart';
import 'package:instagram_clone_with_firebase/views/components/dialogs/alert_dialog_model.dart';

@immutable
class LogoutDialogue extends AlertDialogueModel<bool> {
  LogoutDialogue()
      : super(
          title: Strings.logout,
          message: Strings.areYouSureYouWantToLogoutOfTheApp,
          buttons: {
            'Logout': true,
            'Cancel': false,
          },
        );
}
