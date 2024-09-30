import 'package:flutter/material.dart';

class LangHolder extends StatelessWidget {
  final VoidCallback ontap;
  final String label;
  final String image;
  final bool isSelected;

  const LangHolder({
    Key? key,
    required this.ontap,
    required this.label,
    required this.image,
    this.isSelected = false, // Default is false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue.shade100
              : Colors.white, // Change color if selected
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(image, width: 40, height: 40), // Flag image
                const SizedBox(width: 15),
                Text(label, style: const TextStyle(fontSize: 16)),
              ],
            ),
            if (isSelected)
              const Icon(
                Icons.check, // Tick icon if selected
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }
}
