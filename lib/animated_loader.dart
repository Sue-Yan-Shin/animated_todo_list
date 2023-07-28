import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AnimatedLoader extends StatelessWidget {
  const AnimatedLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.deepPurpleAccent,
        size: 75,
      ),
    );
  }
}
