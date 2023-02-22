import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone_with_firebase/state/image_upload/models/file_types.dart';
import 'package:instagram_clone_with_firebase/state/image_upload/models/thumbnail_request.dart';
import 'package:instagram_clone_with_firebase/state/image_upload/providers/image_upload_provider.dart';
import 'package:instagram_clone_with_firebase/state/post_setting/models/post_setting.dart';
import 'package:instagram_clone_with_firebase/state/post_setting/provider/post_setting_provider.dart';
import 'package:instagram_clone_with_firebase/views/components/thumbnail_view.dart';
import 'package:instagram_clone_with_firebase/views/constants/strings.dart';

class CreateNewPostView extends StatefulHookConsumerWidget {
  const CreateNewPostView({
    required this.file,
    required this.fileType,
    super.key,
  });
  final File file;
  final FileType fileType;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateNewPostViewState();
}

class _CreateNewPostViewState extends ConsumerState<CreateNewPostView> {
  @override
  Widget build(BuildContext context) {
    final thumbnailRequest =
        ThumbnailRequest(file: widget.file, fileType: widget.fileType);
    final postController = useTextEditingController();
    final isPostButtonEnabled = useState(false);
    final postSettings = ref.watch(postSettingProvider);
    useEffect(() {
      void listener() {
        isPostButtonEnabled.value = postController.text.isNotEmpty;
      }

      postController.addListener(listener);
      return () {
        postController.removeListener(listener);
      };
    }, [postController]);
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.createNewPost),
        actions: [
          IconButton(
            onPressed: isPostButtonEnabled.value
                ? () async {
                    final userId = ref.read(userIdProvider);
                    if (userId == null) {
                      return;
                    }
                    final message = postController.text;
                    final isUploaded = await ref
                        .read(imageUploadProvider.notifier)
                        .upload(
                            file: widget.file,
                            fileType: widget.fileType,
                            message: message,
                            postSettings: postSettings,
                            userId: userId);
                    if (isUploaded && mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ThumbnailView(
            thumbnailRequest: thumbnailRequest,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your Text',
              ),
              maxLines: null,
              autofocus: true,
              controller: postController,
            ),
          ),
          ...PostSetting.values.map((postSetting) {
            return ListTile(
              title: Text(postSetting.title),
              subtitle: Text(postSetting.description),
              trailing: Switch(
                  value: postSettings[postSetting] ?? false,
                  onChanged: (isOn) {
                  ref
                        .read(postSettingProvider.notifier)
                        .settings(postSetting, isOn);
                  }),
            );
          })
        ],
      )),
    );
  }
}
