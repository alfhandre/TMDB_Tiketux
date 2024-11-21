import 'package:flutter/material.dart';

class DefaultFloatingActionButton extends StatelessWidget {
  const DefaultFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 24),
      child: FloatingActionButton(
        backgroundColor: Colors.white.withOpacity(0.5),
        onPressed: () {
          Navigator.of(context).pop();
        },
        elevation: 1,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
