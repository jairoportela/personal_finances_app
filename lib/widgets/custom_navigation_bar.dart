import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: child);
  }
}

class ButtonNavBar extends StatelessWidget {
  const ButtonNavBar({
    super.key,
    required this.labelText,
    required this.onPressed,
  });
  final String labelText;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return CustomNavigationBar(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(onPressed: onPressed, child: Text(labelText)),
        ),
      ),
    );
  }
}
