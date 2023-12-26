import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_test/add_person_dialog.dart';
import 'package:hive_test/person.dart';
import 'package:hive_test/person_tile.dart';
import 'package:hive_test/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(PersonAdapter());
  // Initialize Hive
  await HiveStorage().initHive();

  // Open Hive box
  await HiveStorage().openBox();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const SizedBox(
          width: 500,
          height: 500,
          child: Center(
            child: PersonList(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Show the add person dialog
            final newPerson = await showDialog<Person>(
              context: context,
              builder: (BuildContext context) {
                return const AddPersonDialog();
              },
            );

            // Add the new person to Hive and the list
            if (newPerson != null) {
              await HiveStorage().addToBoxWithKey(newPerson.name, newPerson);
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class PersonList extends StatefulWidget {
  const PersonList({super.key});

  @override
  _PersonListState createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveStorage().getBox().listenable(),
      builder: (context, Box<dynamic> box, child) {
        final List<Person> persons = box.values.toList().cast<Person>();
        return ListView.builder(
          itemCount: persons.length,
          itemBuilder: (context, index) {
            return PersonTile(person: persons[index]);
          },
        );
      },
    );
  }
}
