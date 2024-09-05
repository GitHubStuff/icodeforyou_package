import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Spacing extends StatelessWidget {
  const Spacing(
    this.mainAxisExtent, {
    super.key,
    this.crossAxisExtent = double.infinity,
    this.color,
  });

  final double mainAxisExtent;
  final double crossAxisExtent;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Gap(
      mainAxisExtent,
      crossAxisExtent: crossAxisExtent,
      color: color,
    );
  }
}
