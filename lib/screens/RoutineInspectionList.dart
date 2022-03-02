import 'package:flutter/material.dart';
import 'package:pharmacy_council_staff/models/RoutineInspectionModel.dart';
import 'package:pharmacy_council_staff/providers/RoutineInspectionProvider.dart';
import 'package:pharmacy_council_staff/screens/addRoutineInspection.dart';
import 'package:pharmacy_council_staff/widgets/task_tile.dart';
import 'package:provider/provider.dart';

class RoutineInspectionListScreen extends StatelessWidget {
  static const routeName = 'routine_inspections';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Routine Inpections"),
          actions: [const Icon(Icons.search)],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddRoutineInspectionScreen.routeName);
          },
          child: const Icon(Icons.add),
        ),
        body: Consumer<RoutineInspectionProvider>(
            builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.inspections.length,
            itemBuilder: (context, index) {
              if (provider.inspections.isEmpty) {
                return const Center(
                  child: Text(
                      "No inspections yet. Click the + button to fill the forms"),
                );
              } else {
                final item = provider.inspections[index];
                RoutineInspectionModel routineInspectionModel = item;
                return RoutineInspectionTile(
                  routineInspectionModel: routineInspectionModel,
                  longPressCallback: () {},
                );
              }
            },
          );
        }));
  }
}
