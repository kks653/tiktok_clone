import 'package:flutter/material.dart';

class StfScreen extends StatefulWidget {
  const StfScreen({super.key});

  @override
  State<StfScreen> createState() => _StfScreenState();
}

class _StfScreenState extends State<StfScreen> {
  int clicks = 0;

  void _increase() {
    setState(() {
      clicks++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$clicks",
            style: const TextStyle(fontSize: 48),
          ),
          TextButton(
            onPressed: _increase,
            child: const Text(
              "Plus",
              style: TextStyle(fontSize: 36),
            ),
          ),
        ],
      ),
    );
  }
}
