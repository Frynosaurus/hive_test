import 'package:flutter/material.dart';
import 'package:hive_test/person.dart';

class PersonTile extends StatefulWidget {
  final Person person;

  const PersonTile({super.key, required this.person});

  @override
  State<PersonTile> createState() => _PersonTileState();
}

class _PersonTileState extends State<PersonTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.person.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              // Add your update logic here
              _showUpdatePopup(context, widget.person);
            },
            child: const Text('Update'),
          ),
          TextButton(
            onPressed: () {
              // Add your delete logic here
              _showDeletePopup(context, widget.person);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  // Function to show update popup
  Future<void> _showUpdatePopup(BuildContext context, Person person) async {
    TextEditingController nameController = TextEditingController();
    nameController.text = person.name;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Person'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Add your update logic here
                  // For simplicity, let's just update the name
                  person.name = nameController.text;
                  Navigator.of(context).pop();
                },
                child: const Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to show delete popup
  Future<void> _showDeletePopup(BuildContext context, Person person) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Person'),
          content: const Text('Are you sure you want to delete this person?'),
          actions: [
            TextButton(
              onPressed: () {
                // Add your delete logic here
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your delete logic here
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
