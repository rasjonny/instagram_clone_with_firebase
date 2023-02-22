import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/auth/providers/auth_state_providers.dart';
import 'package:instagram_clone_with_firebase/state/image_upload/helper/image_picker_helper.dart';
import 'package:instagram_clone_with_firebase/state/image_upload/models/file_types.dart';
import 'package:instagram_clone_with_firebase/state/post_setting/provider/post_setting_provider.dart';
import 'package:instagram_clone_with_firebase/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone_with_firebase/views/components/dialogs/logout_dialog.dart';
import 'package:instagram_clone_with_firebase/views/constants/strings.dart';
import 'package:instagram_clone_with_firebase/views/create_new_post/create_new_post_view.dart';
import 'package:instagram_clone_with_firebase/views/tabs/user_post/user_post_view.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.appName),
          actions: [
            IconButton(
              onPressed: () async {
                final videoFile =
                    await ImagePickerHelper.pickVideoFromGallery();
                if (videoFile == null) {
                  return;
                }
                ref.refresh(postSettingProvider);
                if (!mounted) {
                  return;
                }
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return CreateNewPostView(
                    file: videoFile,
                    fileType: FileType.video,
                  );
                }));
              },
              icon: const FaIcon(FontAwesomeIcons.film),
            ),
            IconButton(
                onPressed: () async {
                  final photoFile =
                      await ImagePickerHelper.pickImageFromGallery();
                  if (photoFile == null) {
                    return;
                  }
                  ref.refresh(postSettingProvider);
                  if (!mounted) {
                    return;
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return CreateNewPostView(
                      file: photoFile,
                      fileType: FileType.image,
                    );
                  }));
                },
                icon: const Icon(Icons.add_photo_alternate)),
            IconButton(
              onPressed: () async {
                final value = await LogoutDialogue()
                    .present(context)
                    .then((value) => value ?? false);
                if (value) {
                  await ref.read(authStateProvider.notifier).logOut();
                }
              },
              icon: const Icon(Icons.logout),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.person,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.search,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.home,
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          UserPostView(),
          UserPostView(),
          UserPostView(),
        ]),
      ),
    );
  }
}
