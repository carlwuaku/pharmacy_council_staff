import 'package:flutter/material.dart';
import 'package:pharmacy_council_staff/models/RoutineInspectionModel.dart';
import 'package:pharmacy_council_staff/screens/RoutineInspectionDetails.dart';

class RoutineInspectionTile extends StatelessWidget {
  final RoutineInspectionModel routineInspectionModel;
  final Function longPressCallback;
  const RoutineInspectionTile(
      {required this.routineInspectionModel, required this.longPressCallback});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(routineInspectionModel.name),
      subtitle: Row(
        children: [
          Text(routineInspectionModel.license_number),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.calendar_today_outlined),
          SizedBox(
            width: 5,
          ),
          Text(routineInspectionModel.date)
        ],
      ),
      trailing: Icon(Icons.spellcheck),
      onLongPress: () {
        longPressCallback();
      },
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return RoutineInspectionDetailsScreen(
              routineInspectionModel: routineInspectionModel);
        }));
      },
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
