import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  // placeholder események
  final List<_Event> _events = [
    const _Event(title: 'Matematika dolgozat', date: '2025-12-20'),
    const _Event(title: 'Osztálykirándulás', date: '2025-06-15'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // HEADER + NEW EVENT BUTTON
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Események',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text(context),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _showAddEventDialog,
                icon: const Icon(Icons.add),
                label: const Text('Új esemény'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary(context),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // EVENT LIST
          Expanded(
            child: ListView.builder(
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final event = _events[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: AppColors.inputBackground(context),
                  child: ListTile(
                    title: Text(
                      event.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.text(context),
                      ),
                    ),
                    subtitle: Text(
                      event.date,
                      style: TextStyle(
                        color: AppColors.text(context).withOpacity(0.7),
                      ),
                    ),
                    leading: const Icon(Icons.event),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- ADD EVENT DIALOG ----------------
  void _showAddEventDialog() {
    final titleController = TextEditingController();
    final dateController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Új esemény'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Esemény neve'),
            ),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(labelText: 'Dátum (pl. 2025-12-31)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Mégse'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && dateController.text.isNotEmpty) {
                setState(() {
                  _events.add(_Event(
                    title: titleController.text,
                    date: dateController.text,
                  ));
                });
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary(context),
              foregroundColor: Colors.black,
            ),
            child: const Text('Hozzáadás'),
          ),
        ],
      ),
    );
  }
}

// ---------------- PLACEHOLDER EVENT MODEL ----------------
class _Event {
  final String title;
  final String date;

  const _Event({
    required this.title,
    required this.date,
  });
}