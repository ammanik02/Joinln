import 'package:flutter/material.dart';

class CreatePlanScreen extends StatefulWidget {
  const CreatePlanScreen({super.key});

  @override
  State<CreatePlanScreen> createState() => _CreatePlanScreenState();
}

class _CreatePlanScreenState extends State<CreatePlanScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  bool _isOpen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Plan'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Text(
              'Where are you going?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
             const SizedBox(height: 12),
             TextField(
              controller: _destinationController,
              decoration: const InputDecoration(
                hintText: 'e.g. Blue Bottle Coffee, Central Park',
                prefixIcon: Icon(Icons.location_on),
              ),
             ),
             const SizedBox(height: 24),
             const Text(
              'What do you want to do?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
             const SizedBox(height: 12),
             TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Describe your plan...',
              ),
             ),
             const SizedBox(height: 24),
             SwitchListTile(
              title: const Text('Open to Requests'),
              subtitle: const Text('Allow nearby users to request to join'),
              value: _isOpen,
              onChanged: (val) {
                setState(() => _isOpen = val);
              },
             ),
             const SizedBox(height: 48),
             SizedBox(
               width: double.infinity,
               child: ElevatedButton(
                 onPressed: () {
                   // Mock Save
                   Navigator.pop(context);
                 },
                 child: const Text('Post Plan'),
               ),
             ),
          ],
        ),
      ),
    );
  }
}
