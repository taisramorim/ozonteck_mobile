import 'package:flutter/material.dart';

class CustomButtonScore extends StatelessWidget{
  final VoidCallback onPressed;
  final IconData icon;
  final Color color;

  const CustomButtonScore({super.key, 
    required this.onPressed,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      )
    );
  }  
}