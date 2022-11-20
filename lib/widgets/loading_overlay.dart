import 'package:flutter/material.dart';
import 'package:king_jobs/config/styles/color.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: thirdColor,
      ),
    );
  }
}
