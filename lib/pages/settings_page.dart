import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final PageController pageController;

  const SettingsPage({Key? key, required this.pageController}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}