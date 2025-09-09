import 'package:flutter/material.dart';

class FlutterFlowIconButton extends StatelessWidget {
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final double buttonSize;
  final Widget icon;
  final VoidCallback? onPressed;

  const FlutterFlowIconButton({
    Key? key,
    required this.borderColor,
    required this.borderRadius,
    required this.borderWidth,
    required this.buttonSize,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onPressed,
        child: Container(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: borderWidth),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Center(child: icon),
        ),
      ),
    );
  }
}