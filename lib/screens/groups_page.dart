import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/group_card.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Csoportjaid',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.text(context),
            ),
          ),

          const SizedBox(height: 16),

          // --- PLACEHOLDER CSOPORTOK ---
          Expanded(
            child: ListView(
              children: const [
                GroupCard(
                  name: '12.A Osztály',
                  description: 'Fő osztálycsoport',
                ),
                GroupCard(
                  name: 'Osztálykirándulás 2025',
                  description: 'Szervezés és információk',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
