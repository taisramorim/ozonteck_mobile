import 'package:flutter/material.dart';

class IconsHome extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;

  const IconsHome({
    super.key,
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: UniqueKey(),
      child: SizedBox(
        height: 100,
        width: 100,
        child: InkWell(
          onTap: onTap,
          child: Material(
            color: Theme.of(context).colorScheme.primary,
            shape: const CircleBorder(),
            child: Icon(iconData, color: Colors.white),
          ),
        ),
      ),
    );
  }
}