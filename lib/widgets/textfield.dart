import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    this.hint,
    this.isPassword = false,
    this.readOnly = false,
    this.heading,
    this.height,
    this.obscureText = false,
    this.prefix,
    this.suffix,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.onPasswordToggle,
    this.validator,
    this.textInputAction,
    this.keyboardType,
    this.helperText,
    this.controller,
    this.maxLines,
    this.inputDecoration,
  });

  final String? heading;
  final String? hint;
  final String? helperText;
  final bool obscureText;
  final bool isPassword;
  final bool readOnly;

  final Widget? prefix;
  final int? maxLines;

  final Widget? suffix;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final double? height;
  final VoidCallback? onPasswordToggle;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final InputDecoration? inputDecoration;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.heading != null) ...[
          Text(
            widget.heading!,
            style: theme.textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          cursorColor: theme.primaryColor,
          style: theme.textTheme.titleSmall,
          onSaved: widget.onSaved,
          textInputAction: widget.textInputAction,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          obscureText: widget.isPassword ? widget.obscureText : false,
          decoration: InputDecoration(
            errorStyle: theme.textTheme.bodySmall!.copyWith(color: Colors.red),
            hintText: widget.hint,
            hintStyle: theme.textTheme.bodySmall!
                .copyWith(color: Theme.of(context).disabledColor),
            helperText: widget.helperText,
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
