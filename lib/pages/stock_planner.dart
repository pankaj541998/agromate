import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';

const List<Widget> options = <Widget>[Text('Grid'), Text('Table')];

class StockPlanner extends StatefulWidget {
  const StockPlanner({super.key});

  @override
  State<StockPlanner> createState() => _StockPlannerState();
}

class _StockPlannerState extends State<StockPlanner> {
  var currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final List<bool> _selectedFruits = <bool>[true, false];
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          TopBar(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.arrow_back_ios_rounded),
                      SizedBox(width: screenSize.width * 0.02),
                      Text(
                        'Stock Planner',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: screenSize.width * 0.02),
                      ToggleButtons(
                        onPressed: (int index) {
                          setState(() {
                            // The button that is tapped is set to true, and the others to false.
                            for (int i = 0; i < _selectedFruits.length; i++) {
                              _selectedFruits[i] = i == index;
                            }
                          });
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        selectedBorderColor: Color(0xFF327c04),
                        selectedColor: Colors.white,
                        fillColor: Color(0xFF327c04),
                        color: Colors.black,
                        constraints: const BoxConstraints(
                          minHeight: 30.0,
                          minWidth: 60.0,
                        ),
                        isSelected: _selectedFruits,
                        children: options,
                      ),
                      SizedBox(width: screenSize.width * 0.4),
                      ElevatedButton(onPressed: () {}, child: Text("+ Add")),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Divider(
                    height: 5,
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Chemical'),
                          SizedBox(height: 10),
                          SizedBox(
                              width: 300,
                              height: 50,
                              child: TextDropdown(
                                  // onInput: (input) =>
                                  //     chemical = input,
                                  items: const [
                                    'Ammonia',
                                    'Nitrogen',
                                    'Sulphur'
                                  ],
                                  controller: TextEditingController(),
                                  showDropDown: true)),
                        ],
                      ),
                      SizedBox(width: screenSize.width * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Date'),
                          SizedBox(height: 10),
                          StatefulBuilder(
                            builder: (context, setState) {
                              return InkWell(
                                child: Container(
                                  width: 300,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(child: Text("22/11/22")),
                                        Icon(
                                          Icons.expand_circle_down_rounded,
                                          size: 19,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  var newDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2050));
                                  if (newDate != null) {
                                    setState(() {
                                      var date =
                                          '${newDate.day}-${newDate.month}-${newDate.year}';
                                    });
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  // SizedBox(
                  //     width: 300,
                  //     height: 50,
                  //     child: TextDropdown(
                  //         items: const ['Zambia', 'Malad', 'Cambodia'],
                  //         controller: TextEditingController(),
                  //         showDropDown: true)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TextDropdown extends StatefulWidget {
  const TextDropdown({
    Key? key,
    this.hinttext,
    this.prefix,
    this.errortext,
    this.items,
    required this.controller,
    required this.showDropDown,
    this.onInput,
  }) : super(key: key);
  final String? errortext;
  final TextEditingController controller;
  final String? prefix;
  final String? hinttext;
  final bool showDropDown;
  final List<String>? items;
  final void Function(String)? onInput;
  @override
  State<TextDropdown> createState() => _TextDropdownState();
}

class _TextDropdownState extends State<TextDropdown> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var items =
        widget.items ?? ['Reetik', 'Hemant', 'Salman', 'Kisan', 'Chinmay'];
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: TextFormField(
            onChanged: widget.onInput,
            textAlignVertical: TextAlignVertical.top,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return widget.errortext ?? "Please Enter Data";
              }
              return null;
            },
            controller: controller,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              // prefixIcon: const Icon(Icons.search),
              suffixIcon: widget.showDropDown
                  ? PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.expand_circle_down_rounded,
                      ),
                      onSelected: (String value) {
                        setState(() {
                          controller.text = value;
                        });
                      },
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          )),
                      itemBuilder: (BuildContext context) {
                        return items.map<PopupMenuItem<String>>((String value) {
                          return PopupMenuItem(
                              child: Text(value), value: value);
                        }).toList();
                      },
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
