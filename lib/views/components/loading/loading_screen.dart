import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram_clone_with_firebase/views/components/loading/loading_screen_controller.dart';

class LoadingScreen {
  LoadingScreenController? _controller;
  LoadingScreen._sharedInstance();
  static final _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen() => _shared;
  void show({required BuildContext context, required String text}) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = _showOverlay(context: context, text: text);
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController _showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final state = Overlay.of(context);
    final _text = StreamController<String>();
    _text.add(text);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final overlay = OverlayEntry(builder: ((context) {
      return Material(
        color: Colors.black.withAlpha(150),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              minWidth: size.width * 0.2,
              maxHeight: size.height * 0.8,
              maxWidth: size.width * 0.8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10),
              color: const Color.fromARGB(255, 246, 224, 224),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<String>(
                    stream: _text.stream,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!,
                          style: const TextStyle(color: Colors.black),
                        );
                      }
                      return Container();
                    }),
                  ),
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }));
    state.insert(overlay);
    return LoadingScreenController(close: (() {
      state.dispose();
      _text.close();
      return true;
    }), update: ((text) {
      _text.add(text);
      return true;
    }));
  }
}
