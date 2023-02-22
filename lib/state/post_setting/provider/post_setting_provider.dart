import 'package:instagram_clone_with_firebase/state/post_setting/models/post_setting.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../notifier/post_setting_notifier.dart';

final postSettingProvider = StateNotifierProvider<PostSettingNotifier,Map<PostSetting,bool>>((ref)=>PostSettingNotifier());