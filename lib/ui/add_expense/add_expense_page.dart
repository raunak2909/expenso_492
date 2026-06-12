import 'package:expenso_492/domain/ui_helper/input_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:expenso_492/domain/constants/app_constants.dart';
import 'package:intl/intl.dart';

class AddExpensePage extends StatelessWidget {
  var titleController = TextEditingController();
  var remarkController = TextEditingController();
  var amtController = TextEditingController();

  List<String> mType = ["Debit", "Credit"];
  String selectedType = "Debit";
  int selectedTypeIndex = 0;

  int selectedCatIndex = -1;

  DateTime selectedDate = DateTime.now();
  DateFormat df = DateFormat.yMMMEd();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Expense")),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: mFieldDecor(
                hint: "Enter your title here..",
                label: "Title",
              ),
            ),
            SizedBox(height: 11),
            TextField(
              controller: remarkController,
              decoration: mFieldDecor(
                hint: "Enter your remark here..",
                label: "Remarks",
              ),
            ),
            SizedBox(height: 11),
            TextField(
              controller: titleController,
              decoration: mFieldDecor(
                hint: "Enter your Amount here..",
                label: "Amount",
              ),
            ),
            SizedBox(height: 11),
            /////////type/////// (Drop down/ Radio button)
            DropdownMenu(
              initialSelection: selectedTypeIndex,
              dropdownMenuEntries: List.generate(mType.length, (index) {
                return DropdownMenuEntry(value: index, label: mType[index]);
              }),
              width: double.infinity,
              label: Text("Type"),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                  borderSide: BorderSide(color: Colors.pink.shade200, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
            ),

            /*DropdownButton(items: [
              DropdownMenuItem(value: "Debit",child: Text("Debit"),),
              DropdownMenuItem(value: "Credit",child: Text("Credit"),),
            ], onChanged: (value){

            })*/
            SizedBox(height: 11),

            /////////category////// (Bottom sheet)
            StatefulBuilder(
              builder: (context, ss) {
                return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 16,
                          ),
                          child: GridView.builder(
                            itemCount: AppConstants.mCategories.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                ),
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  selectedCatIndex = index;
                                  ss(() {});
                                  Navigator.pop(context);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      AppConstants.mCategories[index].imgPath,
                                      width: 70,
                                      height: 70,
                                    ),
                                    Text(AppConstants.mCategories[index].name),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(21),
                      border: Border.all(),
                    ),
                    child: Center(
                      child: selectedCatIndex < 0
                          ? Text("Choose a Category")
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppConstants
                                      .mCategories[selectedCatIndex]
                                      .imgPath,
                                  width: 40,
                                  height: 40,
                                ),
                                Text(" -  ${AppConstants
                                    .mCategories[selectedCatIndex]
                                    .name}")
                              ],
                            ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(
              height: 11,
            ),
            /////////date///////// (date picker)
            StatefulBuilder(
              builder: (context, ss) {
                return InkWell(
                  onTap: () {
                    showDatePicker(
                        context: context,
                        firstDate: DateTime.now().substract(Duration(days: 731)),
                        lastDate: DateTime.now());
                  },
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(21),
                      border: Border.all(),
                    ),
                    child: Center(
                      child: Text(df.format(selectedDate))
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
