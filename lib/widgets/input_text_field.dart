import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  const LabelWidget({
    super.key,
    required this.label,
    required this.child,
  });
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
