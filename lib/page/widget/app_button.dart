import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final double? height;
  final double? width;
  final Color? backgroundColor;

  // final Color? textColor;
  final double elevation;

  // final bool isEnable;
  final double radius;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;

  const AppButton(
      {Key? key,
      required this.text,
      this.onPressed,
      this.height,
      this.width,
      this.backgroundColor,
      // this.textColor,
      this.elevation = 0,
      // this.isEnable = true,
      this.radius = 16,
      this.textStyle,
      this.buttonStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48.0,
      width: width ?? context.screenSize.width - 16 * 2,
      child: TextButton(
        style: buttonStyle ??
            ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                )),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.blueGrey;
                    } else {
                      return backgroundColor ?? Colors.blueAccent;
                    }
                  },
                )),
        onPressed: onPressed,
        child: Text(
          text,
          style: onPressed == null
              ? textStyle ?? Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.blueAccent)
              : textStyle ?? Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

extension BuildContextX on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
}
