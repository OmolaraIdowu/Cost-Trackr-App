import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield(
      {super.key,
      required this.hint,
      this.isPassword = false,
      this.heading,
      this.height,
      this.obscureText = false,
      this.prefix,
      this.suffix,
      this.onChanged,
      this.onSaved,
      this.onPasswordToggle,
      this.validator,
      this.textInputAction,
      this.keyboardType,
      this.helperText});

  final String? heading;
  final String hint;
  final String? helperText;
  final bool obscureText;
  final bool isPassword;
  final Widget? prefix;
  final Widget? suffix;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final double? height;
  final VoidCallback? onPasswordToggle;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.heading != null) ...[
          Text(
            widget.heading!,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Theme.of(context).primaryColorDark),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          style: Theme.of(context).textTheme.titleSmall,
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ? widget.obscureText : false,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Theme.of(context).disabledColor),
            helperText: widget.helperText,
            helperMaxLines: 3,
            helperStyle: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 8.5,
              color: Theme.of(context).disabledColor,
            ),
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffix ??
                (widget.isPassword
                    ? IconButton(
                        onPressed: widget.onPasswordToggle,
                        icon: SvgPicture.asset(
                          widget.obscureText
                              ? 'assets/icons/visibility_off.svg'
                              : 'assets/icons/visibility.svg',
                          height: 24,
                          width: 24,
                        ),
                      )
                    : null),
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
