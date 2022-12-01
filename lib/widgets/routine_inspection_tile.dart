import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_council_staff/models/RoutineInspectionModel.dart';

class RoutineInspectionTile extends StatelessWidget {
  final RoutineInspectionModel routineInspectionModel;
  final Function longPressCallback;
  final Function itemPressedCallback;
  final bool isSelected;
  const RoutineInspectionTile(
      {required this.routineInspectionModel,
      required this.longPressCallback,
      required this.itemPressedCallback,
      this.isSelected = false});
  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).primaryColor;
    final style = isSelected
        ? TextStyle(color: selectedColor, fontWeight: FontWeight.bold)
        : TextStyle();
    return ListTile(
      title: Text(
        routineInspectionModel.name,
        style: style,
      ),
      subtitle: Row(
        children: [
          Expanded(child: Text(routineInspectionModel.license_number)),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.calendar_today_outlined),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              routineInspectionModel.date,
            ),
          )
        ],
      ),
      trailing: isSelected
          ? Icon(
              Icons.check,
              color: Theme.of(context).primaryColor,
            )
          : null,
      onLongPress: () {
        longPressCallback(routineInspectionModel);
      },
      onTap: () => itemPressedCallback(routineInspectionModel),
    );
  }
}
//
// class TaskCheckbox extends StatelessWidget {
//   final bool checkboxState;
//   final Function checkboxChanged;
//   const TaskCheckbox(
//       {required this.checkboxState, required this.checkboxChanged});
//
//   @override
//   Widget build(BuildContext context) {
//     return Checkbox(
//       value: checkboxState,
//       onChanged: (newval) {
//         checkboxChanged(newval);
//       },
//       activeColor: Colors.black54,
//     );
//   }
// }
