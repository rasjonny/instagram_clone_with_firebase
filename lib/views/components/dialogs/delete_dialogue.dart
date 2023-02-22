import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_with_firebase/views/components/constants/strings.dart';
import 'package:instagram_clone_with_firebase/views/components/dialogs/alert_dialog_model.dart';

@immutable
class DeleteDialogue extends AlertDialogueModel<bool> {
  DeleteDialogue({required String titleObjectToDelete})
      : super(
          title: '${Strings.delete} $titleObjectToDelete',
          message:
              '${Strings.areYouSureYouWantToDeleteThis}$titleObjectToDelete?',
          buttons: {
            'Delete': true,
            'Cancel': false,
          },
        );
}
