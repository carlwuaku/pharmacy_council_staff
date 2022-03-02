import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_council_staff/constants.dart';
import 'package:pharmacy_council_staff/models/RIData.dart';
import 'package:pharmacy_council_staff/models/RoutineInspectionDataModel.dart';
import 'package:pharmacy_council_staff/models/RoutineInspectionModel.dart';
import 'package:pharmacy_council_staff/providers/RoutineInspectionProvider.dart';
import 'package:pharmacy_council_staff/widgets/InputGenerator.dart';
import 'package:provider/provider.dart';

import '../styles.dart';

class AddRoutineInspectionScreen extends StatefulWidget {
  static const routeName = "add_routine_inspection";

  @override
  State<AddRoutineInspectionScreen> createState() =>
      _AddRoutineInspectionScreenState();
}

class _AddRoutineInspectionScreenState
    extends State<AddRoutineInspectionScreen> {
  RoutineInspectionModel routineInspectionModel =
      RoutineInspectionModel(data: []);

  List<Card> cards = [];

  List<RoutineInspectionDataModel> items = [];

  final PageController _pageController = PageController();

  String currentTitle = "";

  int currentIndex = 0;

  // @override
  void goToPage(int page) {
    print(items[page].toJson());
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  List<Widget> generateCards(BuildContext context) {
    //insert the first page as the details

    for (int i = 0; i < routineInspectionModel.data.length; i++) {
      RoutineInspectionDataModel field = items[i];
      // RoutineInspectionDataModel.fromJson(fieldMap[i]);
      // RoutineInspectionDataModel? prevField = i == 0 ? null : items[i - 1];
      // RoutineInspectionDataModel? nextField =
      //     i == items.length - 1 ? null : items[i + 1];

      Card card = Card(
        child: Padding(
          padding: cardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (i + 1).toString() +
                    "/" +
                    items.length.toString() +
                    " " +
                    field.label,
                style: cardTitleStyle,
              ),
              SizedBox(
                height: 20,
              ),
              InputGenerator(
                  field: field.label,
                  type: field.type,
                  options: field.options,
                  initValue: field.value,
                  valueChanged: (val) {
                    // print(val);
                    setState(() {
                      field.value = val;
                    });

                    context
                        .read<RoutineInspectionProvider>()
                        .setData(routineInspectionModel, field, val);
                    // print(field.toJson());
                    // setState(() {
                    //
                    // });
                    // print(field.toJson());
                  })
            ],
          ),
        ),
      );

      cards.add(card);
    }

    return cards;
  }

  @override
  void initState() {
    List fieldMap = jsonDecode(dataFields);
    items = List<RoutineInspectionDataModel>.from(fieldMap.map((e) {
      return RoutineInspectionDataModel.fromJson(e);
    }));

    routineInspectionModel.data = items;
    generateCards(context);
  }

  @override
  Widget build(BuildContext context) {
    //use the data object to create the card content

    return Scaffold(
      appBar: AppBar(
        title: Text("New Routine Inspection"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: cardPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "License Number",
                      style: cardTitleStyle,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      decoration: kTextFieldDecorator,
                      onChanged: (val) {
                        routineInspectionModel.license_number = val;
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: cardPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date of Inspection",
                      style: cardTitleStyle,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      decoration:
                          kTextFieldDecorator.copyWith(hintText: "YYYY-MM-DD"),
                      onChanged: (val) {
                        routineInspectionModel.date = val;
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: cardPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Facility Name",
                      style: cardTitleStyle,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      decoration: kTextFieldDecorator,
                      onChanged: (val) {
                        routineInspectionModel.name = val;
                      },
                    ),
                  ],
                ),
              ),
            ),
            ...cards,
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  context
                      .read<RoutineInspectionProvider>()
                      .addInspection(routineInspectionModel);

                  Navigator.pop(context);
                },
                child: Text(
                  "Add",
                  style: TextStyle(fontSize: 15),
                ))
          ],
        ),
      ),
    );
  }

  //set the value of the object when value changed
  void setObjectValue(RoutineInspectionDataModel item, dynamic val) {
    item.value = val;
  }
}

// Row(
// children: [
// Expanded(
// flex: 1,
// child: TextButton.icon(
// onPressed: () {
// //go back if we're not on the first one
// if (i >= 1) {
// goToPage(i);
// }
// },
// icon: Icon(Icons.arrow_back),
// label:
// Text(prevField == null ? "Intro" : prevField.label),
// // child: Row(
// //   children: [
// //     const Icon(Icons.arrow_back),
// //     if (prevField == null)
// //       Text("Intro")
// //     else
// //       Text(
// //         prevField.label,
// //         softWrap: true,
// //         overflow: TextOverflow.clip,
// //       )
// //   ],
// // )),
// )),
// Expanded(
// flex: 1,
// child: TextButton.icon(
// onPressed: () {
// print(i);
// //go forward if we're not on the last one
// if (i < items.length) {}
// goToPage(i + 1);
// },
// icon: Icon(Icons.arrow_forward),
// label:
// Text(nextField == null ? "Intro" : nextField.label),
// // child: Row(
// //   children: [
// //     Text(
// //       nextField.label,
// //       softWrap: true,
// //       overflow: TextOverflow.clip,
// //     ),
// //
// //   ],
// // )
// ),
// )
// ],
// )
//get a single card instead of the multiple
// Card getSingleCard() {
//   return Card(
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ListView(
//         children: [
//           TextField(
//             decoration:
//             kTextFieldDecorator.copyWith(labelText: "License Number"),
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           TextField(
//             decoration:
//             kTextFieldDecorator.copyWith(labelText: "Facility Name"),
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           TextField(
//             decoration:
//             kTextFieldDecorator.copyWith(labelText: "Date of Inspection"),
//           ),
//           TextButton.icon(
//               onPressed: () {
//                 goToPage(1);
//               },
//               icon: Icon(Icons.arrow_right_alt_sharp),
//               label: Text("Next"))
//         ],
//       ),
//     ),
//   );
// }

// Widget getInput(String type){
//   switch(type){
//     case "radio":
//       break;
//     case "select":
//       return Radio(value: value, groupValue: groupValue, onChanged: onChanged)
//       break;
//     case "multiline":
//       return TextField(
//
//       );
//     default:
//       return TextField();
//   }
// }
