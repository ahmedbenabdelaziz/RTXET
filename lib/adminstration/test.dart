import 'package:flutter/material.dart';
class MyTableWidget extends StatefulWidget {
  const MyTableWidget({Key? key}) : super(key: key);

  @override
  _MyTableWidgetState createState() => _MyTableWidgetState();
}

class _MyTableWidgetState extends State<MyTableWidget> {
  late List<List<TextEditingController>> controllersList;
  late List<List<String>> rows;
  int initialRowCount = 6; // Set the initial number of rows here

  @override
  void initState() {
    super.initState();
    // initialize the list of controllers
    controllersList = List.generate(
      initialRowCount,
          (_) => List.generate(5, (_) => TextEditingController()),
    );
    // initialize the rows with empty values
    rows = List.generate(initialRowCount, (_) => List.filled(5, ''));
  }

  @override
  void dispose() {
    // dispose of all the text editing controllers when the widget is removed
    for (final controllers in controllersList) {
      for (final controller in controllers) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    // add a new row of empty text editing controllers and values
                    controllersList.add(List.generate(5, (_) => TextEditingController()));
                    rows.add(List.filled(5, ''));
                  });
                },
                child: const Text('Ajouter une ligne'),
              ),
              Table(
                border: TableBorder.all(),
                columnWidths: const {
                  0: FixedColumnWidth(220),
                  1: FixedColumnWidth(120),
                  2: FixedColumnWidth(300),
                  3: FixedColumnWidth(80),
                  4: FixedColumnWidth(80),
                },
                children: [
                  // build the header row
                  buildRow(rows[0], isHeader: true, pa: true),
                  // build the data rows
                  ...rows
                      .sublist(initialRowCount) // only get the manually added rows
                      .map((row) => buildRow(row))
                      .toList(),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    controllersList.add(List<TextEditingController>.filled(
                      5,
                      TextEditingController(text: ''),
                    ));
                  });
                },
                child: const Text('Add row'),
              ),
              const SizedBox(height: 30),


            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getTableValues();
        },
        child: const Icon(Icons.save),
      ),
    );
  }
  TableRow buildRow(List<String> cells, {bool isHeader = false, bool pa = false}) {
    final controllers = cells.map((cell) => TextEditingController(text: cell)).toList();
    controllersList.add(controllers);

    return TableRow(
      children: [
        ...controllers.asMap().entries.map((entry) {
          final index = entry.key;
          final controller = entry.value;
          return Container(
            padding: pa ? const EdgeInsets.all(12) : EdgeInsets.zero,
            color: isHeader ? Colors.white : Colors.green.withOpacity(0.5),
            child: Center(
              child: isHeader
                  ? Text(
                controller.text,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              )
                  : Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 3),
                      ),
                      textAlign: TextAlign.left,
                      onChanged: (value) {
                        // Update the value of the TextEditingController
                        controller.text = value;
                      },
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter a value' : null,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        controllersList.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
  List<List<String>> getTableValues() {
    final tableValues = <List<String>>[];
    for (int i = 1; i < controllersList.length; i++) {
      final rowValues = <String>[];
      for (final controller in controllersList[i]) {
        rowValues.add(controller.text);
      }
      tableValues.add(rowValues);
    }
    return tableValues;
  }

}
