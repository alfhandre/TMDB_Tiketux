import 'package:flutter/material.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/theme.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/utils/text_plus_jakarta_sans.dart';

class CustomButton extends StatefulWidget {
  final void Function() onPressed;
  final String text;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Center(
          child: JakartaSans.regular(
            text: widget.text,
            fontSize: 12,
            color: white,
          ),
        ),
      ),
    );
  }
}

class CustomButtonBorder extends StatefulWidget {
  final void Function() onPressed;
  final String text;
  const CustomButtonBorder(
      {super.key, required this.onPressed, required this.text});

  @override
  State<CustomButtonBorder> createState() => _CustomButtonBorderState();
}

class _CustomButtonBorderState extends State<CustomButtonBorder> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: primary, width: 1),
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Center(
          child: JakartaSans.regular(
            text: widget.text,
            fontSize: 12,
            color: primary,
          ),
        ),
      ),
    );
  }
}

class CustomChip extends StatelessWidget {
  final String text;
  final bool isActive;
  final void Function() onPressed;

  const CustomChip({
    super.key,
    required this.text,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: isActive ? primary : bgChipPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Center(
          child: JakartaSans.regular(
            text: text,
            fontSize: 12,
            color: isActive ? white : primary,
          ),
        ),
      ),
    );
  }
}

class CustomButtonIcon extends StatefulWidget {
  final void Function() onPressed;
  final String text;
  final IconData? icon;
  final Color? colorIcon;
  final Color? bgColor;
  final Color? sideColor;

  const CustomButtonIcon(
      {super.key,
      required this.onPressed,
      required this.text,
      this.icon,
      this.colorIcon,
      this.bgColor,
      this.sideColor});

  @override
  State<CustomButtonIcon> createState() => _CustomButtonIconState();
}

class _CustomButtonIconState extends State<CustomButtonIcon> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.bgColor,
          side: BorderSide(color: widget.sideColor ?? Colors.transparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.icon, size: 24, color: widget.colorIcon),
            const SizedBox(width: 4),
            JakartaSans.regular(text: widget.text, fontSize: 12, color: white),
          ],
        ),
      ),
    );
  }
}
