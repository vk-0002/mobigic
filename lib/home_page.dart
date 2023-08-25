import 'package:flutter/material.dart';
import 'main.dart';


class HomePage extends StatefulWidget {
   const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController rowsController = TextEditingController();
  final TextEditingController columnsController = TextEditingController();

  bool validateInput() {
    if (int.tryParse(rowsController.text) == null ||
        int.tryParse(columnsController.text) == null) {
      return false;
    }

    if (int.parse(rowsController.text) <= 0 ||
        int.parse(columnsController.text) <= 0) {
      return false;
    }

    return true;
  }

  void navigateToGridInput() {
    if (validateInput()) {
      int rows = int.parse(rowsController.text);
      int columns = int.parse(columnsController.text);

      Map<String,dynamic> data = {
        'screen_name':'gridInput',
        'rows':rows,
        'columns':columns
      };

      screens.value=data;

    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please enter valid positive integers for rows and columns.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Row Column Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: rowsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Rows',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.grid_on),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: columnsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Columns',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.grid_on),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: navigateToGridInput,
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

