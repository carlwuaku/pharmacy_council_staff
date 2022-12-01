import 'package:flutter/material.dart';
import 'package:pharmacy_council_staff/models/RoutineInspectionModel.dart';
import 'package:pharmacy_council_staff/providers/RoutineInspectionProvider.dart';
import 'package:pharmacy_council_staff/screens/addRoutineInspection.dart';
import 'package:pharmacy_council_staff/widgets/LogoutButton.dart';
import 'package:pharmacy_council_staff/widgets/routine_inspection_tile.dart';
import 'package:provider/provider.dart';

import 'RoutineInspectionDetails.dart';

class RoutineInspectionListScreen extends StatefulWidget {
  static const routeName = 'routine_inspections';
  bool isMultiSelection = false;

  @override
  State<RoutineInspectionListScreen> createState() =>
      _RoutineInspectionListScreenState();
}

class _RoutineInspectionListScreenState
    extends State<RoutineInspectionListScreen> {
  // List<RoutineInspectionModel> items = [];
  // late Future<List<RoutineInspectionModel>> items;
  List<RoutineInspectionModel> selectedItems = [];

  // Future<void> getInspections() async {
  //   items = await RoutineInspectionProvider().getData();
  // }

  bool isItemSelected(RoutineInspectionModel routineInspectionModel) {
    bool isSelected = false;
    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i].id == routineInspectionModel.id) {
        isSelected = true;
        break;
      }
    }
    return isSelected;
  }

  void toggleMultiSelection(RoutineInspectionModel routineInspectionModel) {
    //TODO:
    //trigger multiselection toolbar
    //if multiselection was false, turn it on and select the current item
    if (!widget.isMultiSelection) {
      //toggle the multiselect bar
      selectedItems = [];
      widget.isMultiSelection = true;
      setState(() {
        // add it
        selectedItems.add(routineInspectionModel);
      });
    }
  }

  void removeSelectedItem(RoutineInspectionModel routineInspectionModel) {
    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i].id == routineInspectionModel.id) {
        selectedItems.remove(selectedItems[i]);
        break;
      }
    }
  }

  void itemSelected(RoutineInspectionModel routineInspectionModel) {
    //if multiselect, do the selection function
    if (widget.isMultiSelection) {
      bool isSelected = isItemSelected(routineInspectionModel);

      // selectedItems.contains(routineInspectionModel);

      setState(() {
        //if already in selection, take it out, else add it
        if (isSelected) {
          removeSelectedItem(routineInspectionModel);
          //if it was the last item disable the multiselect
          if (selectedItems.isEmpty) {
            widget.isMultiSelection = false;
          }
        } else {
          selectedItems.add(routineInspectionModel);
        }
      });
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return RoutineInspectionDetailsScreen(
            routineInspectionModel: routineInspectionModel);
      }));
    }
  }

  @override
  void initState() {
    super.initState();
    // items = RoutineInspectionProvider().getData();
  }

  @override
  Widget build(BuildContext context) {
    // print("calling build");
    // print(selectedItems);

    //just call the database and check the numb o
    return WillPopScope(
      onWillPop: () async {
        //if selection, clear it
        if (selectedItems.isNotEmpty) {
          clearSelection();
          return false;
        }
        return true;
      },
      child: Scaffold(
          appBar: getAppBar(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(
                  context, AddRoutineInspectionScreen.routeName);
            },
            child: const Icon(Icons.add),
          ),
          body: Consumer<RoutineInspectionProvider>(
            builder: (context, provider, child) => FutureBuilder(
              future: provider.isInitComplete,
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: provider.inspections.length,
                          itemBuilder: (context, index) {
                            if (provider.inspections.isEmpty) {
                              return const Center(
                                child: Text(
                                    "No inspections yet. Click the + button to fill the forms"),
                              );
                            } else {
                              final item = provider.inspections[index];
                              RoutineInspectionModel routineInspectionModel =
                                  item;
                              //check if selected
                              final isSelected =
                                  isItemSelected(routineInspectionModel);
                              // selectedItems.contains(routineInspectionModel);
                              return RoutineInspectionTile(
                                routineInspectionModel: routineInspectionModel,
                                longPressCallback: toggleMultiSelection,
                                itemPressedCallback: itemSelected,
                                isSelected: isSelected,
                              );
                            }
                          },
                        ),
            ),
          )),
    );
  }

  void clearSelection() {
    setState(() {
      selectedItems = [];
      widget.isMultiSelection = false;
    });
  }

  // void refreshData() {
  //   items = RoutineInspectionProvider().getData();
  // }

  AppBar getAppBar() {
    return selectedItems.isNotEmpty
        ? AppBar(
            title: Text(
              "${selectedItems.length} Selected",
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    final result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Delete Selected"),
                          content: Text(
                              "Are you sure you want to delete the selected inspection reports?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Yes'),
                            ),
                          ],
                        );
                      },
                    );
                    if (!result) {
                      return;
                    }
                    List<String> ids = [];
                    for (int i = 0; i < selectedItems.length; i++) {
                      ids.add(selectedItems[i].id.toString());
                    }
                    RoutineInspectionProvider().deleteData(ids);
                    clearSelection();
                    // refreshData();
                  },
                  icon: Icon(Icons.delete))
            ],
          )
        : AppBar(
            title: const Text("Routine Inspections"),
            actions: [const Icon(Icons.search), LogoutButton()],
          );
  }
}
