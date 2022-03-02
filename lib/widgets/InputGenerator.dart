import 'package:flutter/material.dart';

class InputGenerator extends StatefulWidget {
  final String type;
  final String initValue;
  final List<dynamic> options;
  final Function valueChanged; //to pass the value back;
  final String field;
  //TODO
  //use a provider instead
  const InputGenerator(
      {required this.type,
      required this.options,
      required this.valueChanged,
      required this.initValue,
      required this.field});

  @override
  State<InputGenerator> createState() => _InputGeneratorState();
}

class _InputGeneratorState extends State<InputGenerator> {
  var val = '';
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    val = widget.initValue == ''
        ? widget.options[0]['value']
        : val = widget.initValue;
    //auto select the first item
    widget.valueChanged(val);

    _controller = TextEditingController(text: widget.initValue);
  }

  @override
  Widget build(BuildContext context) {
    // print('build called');
    //take the type and generate some widget based on it

    // print('value: ${widget.field} - $val');

    Widget item = TextField(
      key: UniqueKey(),
      controller: _controller,
      onChanged: (value) {
        widget.valueChanged(value);
      },
    );
    switch (widget.type) {
      case 'radio':
        // val = widget.initValue == ''
        //     ? widget.options[0]['value']
        //     : val = widget.initValue;
        //return a radio widget

        List<RadioListTile> items = [];
        for (var curr in widget.options) {
          RadioListTile radioListTile = RadioListTile(
            key: UniqueKey(),
            title: Text(curr['key']),
            value: curr['value'],
            groupValue: val,
            onChanged: (value) {
              setState(() {
                val = value;
              });
              widget.valueChanged(value);
            },
          );
          items.add(radioListTile);
        }
        item = Column(
          children: [...items],
        );
        break;

      // return getRadioOptions();

      case 'select':
        item = DropdownButton<dynamic>(
          key: UniqueKey(),
          value: val,
          items: getOptions(),
          onChanged: (value) {
            setState(() {
              val = value;
            });
            widget.valueChanged(value);
          },
        );
        break;
      case 'textarea':
        break;
      case 'checkbox':
        break;
      case 'text':
        break;
      default:
      //    do nothing. return the textfield
    }
    return item;
  }

  List<DropdownMenuItem> getOptions() {
    List<DropdownMenuItem> items = [];
    for (var curr in widget.options) {
      DropdownMenuItem dropdownMenuItem = DropdownMenuItem(
        child: Text(curr['key']),
        value: curr['value'],
      );
      items.add(dropdownMenuItem);
    }
    return items;
  }
}
