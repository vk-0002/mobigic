import 'package:flutter/material.dart';


import 'main.dart';

class AlphabetsGrid extends StatelessWidget {
  final int rows;
  final int columns;

  const AlphabetsGrid({super.key, required this.rows, required this.columns});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
        body: GridInputWidget(rows: rows, columns: columns),
      ),
    );
  }
}

class GridInputWidget extends StatefulWidget {
  final int rows;
  final int columns;

  const GridInputWidget({super.key, required this.rows, required this.columns});

  @override
  _GridInputWidgetState createState() => _GridInputWidgetState();
}

class _GridInputWidgetState extends State<GridInputWidget> {
  late List<List<TextEditingController>> controllers;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(
      widget.rows,
          (row) => List.generate(
        widget.columns,
            (col) => TextEditingController(),
      ),
    );
  }

  bool validateCharacters() {
    for (var rowControllers in controllers) {
      for (var controller in rowControllers) {
        String text = controller.text;
        if (text.isEmpty) {
          _showValidationDialog('Empty cells are not allowed.');
          return false;
        }
        if (text.length > 1) {
          _showValidationDialog('Each cell should contain a single character.');
          return false;
        }
        if (!text.contains(RegExp(r'[a-zA-Z]'))) {
          _showValidationDialog('Only alphabets are allowed.');
          return false;
        }
      }
    }
    return true;
  }

  void _showValidationDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invalid Input'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: List.generate(widget.rows, (row) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.columns, (col) {
                  return Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.all(4),
                    child: TextField(
                      controller: controllers[row][col],
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '', // Hide the character counter
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  );
                }),
              );
            }),
          ),
          const SizedBox(height: 20),
          Row(
            children: [


              ElevatedButton(
                onPressed: () {
                  Map<String,dynamic> data = {
                    'screen_name':'',

                  };
                  screens.value=data;
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text(
                  'Reset',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              const Spacer(),

              ElevatedButton(
                onPressed: () {
                  if (validateCharacters()) {
                    String inputString = '';
                    for (var rowControllers in controllers) {
                      for (var controller in rowControllers) {
                        inputString += controller.text;
                      }
                    }


                    Map<String,dynamic> data = {
                      'screen_name':'gridSearch',
                      'rows':widget.rows,
                      'columns':widget.columns,
                      'inputString':inputString
                    };

                    screens.value=data;

                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

