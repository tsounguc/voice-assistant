import 'package:flutter/material.dart';
import 'package:venus/pallete.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String headerText;
  final String descriptionText;
  const FeatureBox({
    super.key,
    required this.color,
    required this.headerText,
    required this.descriptionText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0).copyWith(left: 15, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headerText,
              style: const TextStyle(
                  fontFamily: 'Cera Pro', color: Pallete.blackColor, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              descriptionText,
              style: const TextStyle(
                fontFamily: 'Cera Pro',
                color: Pallete.blackColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
