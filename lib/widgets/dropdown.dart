import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown({
    super.key,
    this.heading,
    required this.value,
    required this.items,
    required this.onChanged,
    this.onSaved,
    this.dropdownIcon = const Icon(Icons.keyboard_arrow_down_rounded),
    this.selectedItemBuilder,
  });

  final String? heading;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final void Function(T?)? onSaved;
  final Widget dropdownIcon;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (heading != null) ...[
          Text(
            heading!,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 6),
        ],
        DropdownButtonFormField<T>(
          value: value,
          icon: dropdownIcon,
          items: items,
          onChanged: onChanged,
          onSaved: onSaved,
          borderRadius: BorderRadius.circular(8),
          dropdownColor: Theme.of(context).cardColor,
          selectedItemBuilder: selectedItemBuilder,
        ),
      ],
    );
  }
}
