import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonsListPage extends ConsumerWidget {
  const PersonsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persons'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to create person page
            },
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Persons List',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('TODO: Implement persons list'),
            // TODO: Add ListView with persons
            // TODO: Add pull-to-refresh functionality
            // TODO: Handle loading and error states
            // TODO: Add search functionality
          ],
        ),
      ),
    );
  }
}
