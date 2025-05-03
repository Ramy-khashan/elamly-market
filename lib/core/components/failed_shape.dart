import 'package:flutter/material.dart';

class FailedShape extends StatelessWidget {
  const FailedShape({super.key, required this.msg, required this.onTapRefresh});
  final String msg;
  final VoidCallback onTapRefresh;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            msg,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(onPressed: onTapRefresh, icon: const Icon(Icons.refresh))
        ],
      ),
    );
  }
}
