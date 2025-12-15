import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  int _selectedChatIndex = 0;

  bool get isDesktop => MediaQuery.of(context).size.width >= 900;

  final List<_ChatPreview> _chats = const [
    _ChatPreview(
      title: '12.A Osztály',
      lastMessage: 'Holnap dolgozat lesz?',
    ),
    _ChatPreview(
      title: 'Osztálykirándulás 2025',
      lastMessage: 'Indulás reggel 7-kor',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (isDesktop) {
      return Row(
        children: [
          _buildChatList(context),
          Expanded(child: _buildChatView(context)),
        ],
      );
    }

    // mobil nézet
    return _buildChatList(context);
  }

  // ---------------- CHAT LIST ----------------
  Widget _buildChatList(BuildContext context) {
    return Container(
      width: isDesktop ? 320 : null,
      decoration: BoxDecoration(
        color: AppColors.inputBackground(context),
        boxShadow: isDesktop
            ? const [BoxShadow(color: Colors.black26, blurRadius: 6)]
            : null,
      ),
      child: ListView.builder(
        itemCount: _chats.length,
        itemBuilder: (context, index) {
          final chat = _chats[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  AppColors.primary(context).withValues(alpha: 0.2),
              child: Icon(Icons.group, color: AppColors.primary(context)),
            ),
            title: Text(
              chat.title,
              style: TextStyle(color: AppColors.text(context)),
            ),
            subtitle: Text(
              chat.lastMessage,
              style: TextStyle(
                color: AppColors.text(context).withValues(alpha: 0.6),
              ),
            ),
            selected: index == _selectedChatIndex,
            selectedTileColor:
                AppColors.primary(context).withValues(alpha: 0.15),
            onTap: () {
              if (isDesktop) {
                setState(() => _selectedChatIndex = index);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(chat: chat),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  // ---------------- CHAT VIEW ----------------
  Widget _buildChatView(BuildContext context) {
    final chat = _chats[_selectedChatIndex];

    return Column(
      children: [
        // header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.inputBackground(context),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
          ),
          child: Row(
            children: [
              Text(
                chat.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text(context),
                ),
              ),
            ],
          ),
        ),

        // messages placeholder
        Expanded(
          child: Center(
            child: Text(
              'Üzenetek helye',
              style: TextStyle(color: AppColors.text(context)),
            ),
          ),
        ),

        // input
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Üzenet írása...',
                    filled: true,
                    fillColor: AppColors.inputBackground(context),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.send, color: AppColors.primary(context)),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------- MOBILE CHAT SCREEN ----------------
class ChatScreen extends StatelessWidget {
  final _ChatPreview chat;

  const ChatScreen({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chat.title),
      ),
      body: Column(
        children: const [
          Expanded(child: Center(child: Text('Üzenetek helye'))),
        ],
      ),
    );
  }
}

// ---------------- MODEL (PLACEHOLDER) ----------------
class _ChatPreview {
  final String title;
  final String lastMessage;

  const _ChatPreview({
    required this.title,
    required this.lastMessage,
  });
}