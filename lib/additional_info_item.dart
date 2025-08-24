import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
  final IconData icons;
  final String text;
  final String value;

  const AdditionalInfo({
    super.key,
    required this.icons,
    required this.text,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Icon(icons, size: 36),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
