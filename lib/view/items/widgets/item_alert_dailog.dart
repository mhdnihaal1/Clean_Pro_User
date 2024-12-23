// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> options;
  final Function(int, bool) onOptionSelected;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.options,
    required this.onOptionSelected,
  });

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  late List<Map<String, dynamic>> _options;

  @override
  void initState() {
    super.initState();
    _options = List.from(widget.options);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      title: Text(
        widget.title,
        style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
            _options.length,
            (index) => CustomCheckboxListTile(
                label: _options[index]["text"],
                value: _options[index]["selected"],
                onChanged: (bool value) {
                  setState(() {
                    _options[index]["selected"] = value;
                  });
                  widget.onOptionSelected(index, value);
                })
            ),
      ),
      actions: [
        TextButton(
          child: const Text('CANCEL', style: TextStyle(color: Colors.blue)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('DONE', style: TextStyle(color: Colors.blue)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class CustomCheckboxListTile extends StatelessWidget {
  final bool value;
  final String label;
  final Function(bool) onChanged;

  const CustomCheckboxListTile({
    super.key,
    required this.value,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: (bool? newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
          ),
          Text(label),
        ],
      ),
    );
  }
}
