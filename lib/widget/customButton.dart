import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.submit,
      required this.label,
      required this.isOred});
  final Function()? submit;
  final bool isOred;
  final String label;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      splashColor: Colors.redAccent,
      onTap: submit,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        alignment: Alignment.center,

        width: size.width / (isOred ? 5 : 3),
        height: size.height / (isOred ? 24 : 18),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
              color: Colors.white,
              fontSize: isOred ? 17 : 23,
              fontWeight: FontWeight.bold),
        ),
        // child: Text(on),
      ),
    );
  }
}
