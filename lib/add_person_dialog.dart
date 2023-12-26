import 'package:flutter/material.dart';
import 'package:hive_test/hive_service.dart';
import 'package:hive_test/person.dart';

class AddPersonDialog extends StatefulWidget {
  const AddPersonDialog({super.key});

  @override
  _AddPersonDialogState createState() => _AddPersonDialogState();
}

class _AddPersonDialogState extends State<AddPersonDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final HiveStorage<Person> localStorage = HiveStorage<Person>();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => AlertDialog(
        // ... rest of your AlertDialog widget
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isNotEmpty &&
                  ageController.text.isNotEmpty) {
                try {
                  final newPerson = Person(
                    name: nameController.text,
                    age: int.parse(ageController.text),
                  );
                  await localStorage.addToBoxWithKey(null, newPerson);
                  Navigator.of(context)
                      .pop(newPerson); // Now safe to use context
                } catch (error) {
                  // Handle errors
                }
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
