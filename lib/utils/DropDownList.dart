import 'package:flutter/material.dart';

class DropDownList extends StatefulWidget {
  final Function(String) onChanged;
  const DropDownList({super.key, required this.list, required this.onChanged, required this.prefixIcon});

  final List<String> list;
  final IconData? prefixIcon;

  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  late String dropdownValue;
  @override
  void initState() {
    super.initState();
    // Vérifiez que la liste n'est pas vide pour éviter une erreur
    dropdownValue = widget.list.isNotEmpty ? widget.list[0] : "";
  }

  void handleDropdownChanged(String value) {
    setState(() {
      dropdownValue = value;
      widget.onChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
        borderRadius:
            BorderRadius.circular(4.0), // ajustez le rayon selon vos besoins
      ),
      child: DropdownButtonFormField<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        ),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
            widget.onChanged(value);
          });
        },
        items: widget.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
