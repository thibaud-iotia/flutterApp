import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final Function(String)? onChanged;
  final bool? readOnly;
  final String? currentValue;
  final TextInputType type;
  const InputWidget(
      {super.key,
      required this.labelText,
      required this.icon,
      required this.obscureText,
      this.onChanged,
      this.readOnly = false,
      this.currentValue = "",
      required this.type});

  final String labelText;
  final IconData icon;
  final bool obscureText;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final controller = TextEditingController();

  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    controller.text = widget.currentValue!;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: _obscureText,
      readOnly: widget.readOnly!,
      keyboardType: widget.type,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: Icon(widget.icon),
        labelText: widget.labelText,
        //hide password
        suffixIcon: widget.icon == Icons.lock
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
              )
            : null,
      ),
      onChanged: (value) => widget.onChanged!(value),
      validator: (value) {
        if (value!.isEmpty) {
          return "Ce champ ne peut pas être vide";
        }// if code postal is not a number
        else if (widget.labelText == "Code Postal" && int.tryParse(value) == null) {
          return "Ce champ doit être un nombre";
        } // if date is not xx/xx/xx et contains only numbers
        else if (widget.labelText == "Anniversaire" && value.length != 8) {
          return "Ce champ doit être au format JJ/MM/AA";
        }
        return null;
      },
    );
  }
}
