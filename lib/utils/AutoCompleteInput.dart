import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AutoCompleteInput extends StatefulWidget {
  const AutoCompleteInput({super.key, required this.label, required this.onSelected, required this.icon, this.initialValue = ''});

  final String label;
  final Function(String) onSelected;
  final IconData icon;
  final String initialValue;

  @override
  State<AutoCompleteInput> createState() => _AutoCompleteInputState();
}

class _AutoCompleteInputState extends State<AutoCompleteInput> {
  List<String> _kOptions = <String>[];

  Future<void> handleAutoComplete(String search) async {
    final response = await http
        .get(Uri.parse('https://geocode.search.hereapi.com/v1/geocode?q=$search&apiKey=QW4BvtPi8MZbVJzPO-Aq8OkiE9aD5wEVdowrUVDpq_M'));
    if (response.statusCode == 200) {
      final utf8Json = utf8.decode(response.bodyBytes); // Décodez les données JSON avec l'encodage UTF-8
      final Map<String, dynamic> data = json.decode(utf8Json);
      var items = data['items'];
      _kOptions = items.map<String>((dynamic item) {
        return item['title'] as String; // Ajout d'une conversion explicite
      }).toList();
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<Iterable<String>> handleOnChanged(TextEditingValue textEditingValue) async {
    if (textEditingValue.text == '') {
      return const Iterable<String>.empty();
    }
    await handleAutoComplete(textEditingValue.text);
    return _kOptions;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) =>
          handleOnChanged(textEditingValue),
      onSelected: (String selection) => widget.onSelected(selection),
      initialValue: TextEditingValue(text: widget.initialValue),
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        return TextField(
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon),
            border: const OutlineInputBorder(),
            labelText: widget.label,
          ),
          onChanged: (value) {
            handleOnChanged(TextEditingValue(text: value));
          },
        );
      },
    );
  }
}
