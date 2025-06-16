import 'package:ecommerce_app/constants/global_variable.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({ super.key, required this.onTap,required this.text});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onTap,
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 50),
       
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,  
    ),
    backgroundColor: GlobalVariables.secondaryColor,
      
    ),

    
    child: Text(text,
    style: const TextStyle(color: GlobalVariables.backgroundColor,)));
  }
}
