import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/firebase_options.dart';
import 'dart:developer' as devtools show log;

import 'package:instagram_clone_with_firebase/state/auth/providers/is_logged_in_provider.dart';
import 'package:instagram_clone_with_firebase/state/providers/is_loading_providers.dart';

import 'package:instagram_clone_with_firebase/views/components/loading/loading_screen.dart';
import 'package:instagram_clone_with_firebase/views/main/main_view.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blueGrey,
            indicatorColor: Colors.blueGrey),
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: Consumer(builder: ((context, ref, child) {
          ref.listen<bool>(isLoadingProvider, (previous, next) {
            if (next) {
              LoadingScreen().show(context: context, text: 'Loading...');
            } else {
              LoadingScreen().hide();
            }
          });
          final isLoggedIn = ref.watch(isLoggedInProvider);
          if (isLoggedIn) {
            return const MainView();
          } else {
            return const MainView();
          }
        })),
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
