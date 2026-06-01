import 'package:flutter/material.dart';

class CreateJob extends StatelessWidget {
  final String heroTag;
  final String title;
  final VoidCallback onpressed;
  const CreateJob({
    super.key,
    required this.heroTag,
    required this.title,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      elevation: 0,
      heroTag: heroTag,
      backgroundColor: const Color(0xFF2D8D7C),
      onPressed: onpressed,
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(title, style: TextStyle(color: Colors.white)),
    );
  }
}
