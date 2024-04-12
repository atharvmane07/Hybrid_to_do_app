// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// import 'package:to_do_list/data/categories.dart';
// import 'package:to_do_list/models/category.dart';
// import 'package:to_do_list/models/todolist.dart';
// import 'package:to_do_list/widgets/button.dart';
// import 'package:to_do_list/widgets/pin.dart';
// import 'package:to_do_list/widgets/tiles.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<ToDoItem> toDoList = [];
//   List<ToDoItem> toDoListPinned = [];

//   void _removeItem(String documentId) {
//     List<ToDoItem> tempList = [];
//     List<ToDoItem> tempListPinned = [];
//     for (var items in toDoList) {
//       if (items.id != documentId) {
//         tempList.add(items);
//       }
//     }
//     for (var items in toDoListPinned) {
//       if (items.id != documentId) {
//         tempListPinned.add(items);
//       }
//     }
//     setState(() {
//       toDoList = tempList;
//       toDoListPinned = tempListPinned;
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text("Task completed successfully"),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   Future<dynamic> showDia() {
//     String textTitle = '';
//     TextEditingController dateinput = TextEditingController();
//     var _selectedCategory = categories[Categories.Personal]!;
//     int _selectedButtonIndex = 0;
//     bool pin = false;

//     void updatePin(bool contd) {
//       pin = contd;
//     }

//     void _updateSelectedButtonIndex(int index) {
//       setState(() {
//         _selectedButtonIndex = index;
//       });
//     }

//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           title: Row(
//             children: [
//               Text(
//                 'Task',
//                 style: GoogleFonts.poppins(
//                   textStyle: const TextStyle(
//                     fontSize: 20,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               const Spacer(),
//               PinWidget(
//                 updatePin: updatePin,
//               ),
//             ],
//           ),
//           content: SingleChildScrollView(
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               height: 270,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min, // Ensure minimum size
//                 children: [
//                   TextFormField(
//                     decoration: InputDecoration(
//                       hintText: 'Title',
//                       filled: true,
//                       fillColor: const Color(0xFFD9D9D9),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide.none,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                     onChanged: (value) {
//                       textTitle = value;
//                     },
//                     textCapitalization: TextCapitalization.sentences,
//                   ),
//                   const SizedBox(height: 10), // Add some spacing
//                   TextField(
//                     controller: dateinput,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: const Color(0xFFD9D9D9),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide.none,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                         borderSide: BorderSide.none,
//                       ),
//                       icon: const Icon(Icons.calendar_today),
//                       hintText: "Enter Date",
//                     ),
//                     readOnly: true,
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2101),
//                       );

//                       if (pickedDate != null) {
//                         String formattedDate =
//                             DateFormat('yyyy-MM-dd').format(pickedDate);
//                         setState(() {
//                           dateinput.text = formattedDate;
//                         });
//                       }
//                     },
//                   ),
//                   const SizedBox(height: 10), // Add some spacing
//                   ColorChangingButton(
//                     onButtonSelected: _updateSelectedButtonIndex,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.black,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               onPressed: () async {
//                 bool isPined = pin;

//                 setState(() {
//                   _selectedCategory = categories[
//                       _selectedButtonIndex == 0
//                           ? Categories.Personal
//                           : _selectedButtonIndex == 1
//                               ? Categories.Work
//                               : _selectedButtonIndex == 2
//                                   ? Categories.Finance
//                                   : Categories.Other]!;
//                 });

//                 ToDoItem newItem = ToDoItem(
//                   title: textTitle,
//                   category: _selectedCategory,
//                   dateTime: DateTime.parse(dateinput.text),
//                   id: textTitle + DateTime.parse(dateinput.text).toString(),
//                   isPinned: isPined,
//                 );
//                 setState(() {
//                   toDoList.add(newItem);
//                   if (newItem.isPinned) {
//                     toDoListPinned.add(newItem);
//                   }
//                 });

//                 Navigator.of(context).pop();
//               },
//               child: const Text('Submit'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget showDialogBox() {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(
//             height: 90,
//           ),
//           Image.asset('assets/emptyimg.png'),
//           const SizedBox(
//             height: 60,
//           ),
//           Text(
//             'Create your first to-do list...',
//             style: GoogleFonts.poppins(
//               textStyle: const TextStyle(
//                 fontSize: 20,
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           ElevatedButton.icon(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.black,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             onPressed: () {
//               showDia();
//             },
//             icon: const Icon(
//               Icons.add,
//               color: Colors.white,
//             ),
//             label: Text(
//               'New List',
//               style: GoogleFonts.poppins(
//                 textStyle: const TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(120.0),
//           child: AppBar(
//             leading: SizedBox(
//               height: 20,
//               width: 20,
//               child: Image.asset(
//                 'assets/appBarLogo.png',
//               ),
//             ),
//             title: Text(
//               'DooIt',
//               style: GoogleFonts.poppins(
//                 textStyle: const TextStyle(
//                   fontSize: 25,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             elevation: 0,
//             backgroundColor: Colors.white,
//             bottom: TabBar(
//               indicatorPadding: const EdgeInsets.symmetric(horizontal: 16.0),
//               unselectedLabelColor: Colors.grey,
//               indicatorSize: TabBarIndicatorSize.tab,
//               indicator: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.black,
//               ),
//               tabs: [
//                 Tab(
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       "All List",
//                       style: GoogleFonts.poppins(
//                         textStyle: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Tab(
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       "Pinned",
//                       style: GoogleFonts.poppins(
//                         textStyle: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             toDoList.isEmpty
//                 ? showDialogBox()
//                 : Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: ListView.separated(
//                       itemBuilder: (context, index) => tiles(
//                         title: toDoList[index].title,
//                         category: toDoList[index].category,
//                         date: toDoList[index].dateTime,
//                         onRemove: () => _removeItem(toDoList[index].id),
//                       ),
//                       separatorBuilder: ((context, index) => const SizedBox(
//                             height: 20,
//                           )),
//                       itemCount: toDoList.length,
//                     ),
//                   ),
//             toDoListPinned.isEmpty
//                 ? showDialogBox()
//                 : Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: ListView.separated(
//                       itemBuilder: (context, index) => tiles(
//                         title: toDoListPinned[index].title,
//                         category: toDoListPinned[index].category,
//                         date: toDoListPinned[index].dateTime,
//                         onRemove: () => _removeItem(toDoListPinned[index].id),
//                       ),
//                       separatorBuilder: ((context, index) => const SizedBox(
//                             height: 20,
//                           )),
//                       itemCount: toDoListPinned.length,
//                     ),
//                   ),
//           ],
//         ),
//         floatingActionButton: toDoList.isEmpty
//             ? null
//             : FloatingActionButton(
//                 onPressed: () {
//                   showDia();
//                 },
//                 child: const Icon(Icons.add),
//               ),
//       ),
//     );
//   }
// }

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:to_do_list/data/categories.dart';
import 'package:to_do_list/models/category.dart';
import 'package:to_do_list/models/todolist.dart';
import 'package:to_do_list/widgets/button.dart';
import 'package:to_do_list/widgets/pin.dart';
import 'package:to_do_list/widgets/tiles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ToDoItem> toDoList = [];
  List<ToDoItem> toDoListPinned = [];

  void _removeItem(String documentId) {
    List<ToDoItem> tempList = [];
    List<ToDoItem> tempListPinned = [];
    for (var items in toDoList) {
      if (items.id != documentId) {
        tempList.add(items);
      }
    }
    for (var items in toDoListPinned) {
      if (items.id != documentId) {
        tempListPinned.add(items);
      }
    }
    setState(() {
      toDoList = tempList;
      toDoListPinned = tempListPinned;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Task completed successfully"),
      duration: Duration(seconds: 2),
    ));
  }

  Future<void> showDia() async {
    String textTitle = '';
    TextEditingController dateinput = TextEditingController();
    var _selectedCategory = categories[Categories.Personal]!;
    int _selectedButtonIndex = 0;
    bool pin = false;
    void updatePin(bool contd) {
      pin = contd;
    }

    void _updateSelectedButtonIndex(int index) {
      setState(() {
        _selectedButtonIndex = index;
      });
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Title',
                      filled: true,
                      fillColor: const Color(0xFFD9D9D9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      textTitle = value;
                    },
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: dateinput,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFD9D9D9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      icon: const Icon(Icons.calendar_today),
                      hintText: "Enter Date",
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        setState(() {
                          dateinput.text = formattedDate;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  ColorChangingButton(
                    onButtonSelected: _updateSelectedButtonIndex,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                bool isPined = pin;

                setState(() {
                  if (_selectedButtonIndex == 0) {
                    _selectedCategory = categories[Categories.Personal]!;
                  } else if (_selectedButtonIndex == 1) {
                    _selectedCategory = categories[Categories.Work]!;
                  } else if (_selectedButtonIndex == 2) {
                    _selectedCategory = categories[Categories.Finance]!;
                  } else if (_selectedButtonIndex == 3) {
                    _selectedCategory = categories[Categories.Other]!;
                  }
                });

                ToDoItem newItem = ToDoItem(
                  title: textTitle,
                  category: _selectedCategory,
                  dateTime: DateTime.parse(dateinput.text),
                  id: textTitle + DateTime.parse(dateinput.text).toString(),
                  isPinned: isPined,
                );

                setState(() {
                  toDoList.add(newItem);
                  if (newItem.isPinned) {
                    toDoListPinned.add(newItem);
                  }
                });

                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Widget showDialogBox() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 90,
          ),
          Image.asset('assets/emptyimg.png'),
          const SizedBox(
            height: 60,
          ),
          Text(
            'Create your first to-do list...',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              showDia();
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: Text(
              'New List',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: AppBar(
            leading: SizedBox(
              height: 20,
              width: 20,
              child: Image.asset(
                'assets/appBarLogo.png',
              ),
            ),
            title: Text(
              'DooIt',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            bottom: TabBar(
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              tabs: [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "All List",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Pinned",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            toDoList.isEmpty
                ? showDialogBox()
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView.separated(
                      itemBuilder: (context, index) => tiles(
                        title: toDoList[index].title,
                        category: toDoList[index].category,
                        date: toDoList[index].dateTime,
                        onRemove: () => _removeItem(toDoList[index].id),
                      ),
                      separatorBuilder: ((context, index) => const SizedBox(
                            height: 20,
                          )),
                      itemCount: toDoList.length,
                    ),
                  ),
            toDoListPinned.isEmpty
                ? showDialogBox()
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView.separated(
                      itemBuilder: (context, index) => tiles(
                        title: toDoListPinned[index].title,
                        category: toDoListPinned[index].category,
                        date: toDoListPinned[index].dateTime,
                        onRemove: () => _removeItem(toDoListPinned[index].id),
                      ),
                      separatorBuilder: ((context, index) => const SizedBox(
                            height: 20,
                          )),
                      itemCount: toDoListPinned.length,
                    ),
                  ),
          ],
        ),
        floatingActionButton: toDoList.isEmpty
            ? null
            : FloatingActionButton(
                onPressed: () {
                  showDia();
                },
                child: const Icon(Icons.add),
              ),
      ),
    );
  }
}


