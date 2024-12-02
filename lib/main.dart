import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Group Chat',
      home: GroupChatScreen(),
    );
  }
}

class GroupChatScreen extends StatefulWidget {
  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  final List<Map<String, dynamic>> messages = [
    {'text': 'Hi there!', 'sender': 'user'},
    {'text': 'Hello!', 'sender': 'other'},
    {'text': 'How are you?', 'sender': 'user'},
    {'text': 'Doing great, thanks!', 'sender': 'other'},
    {'text': 'What about you?', 'sender': 'other'},
    {'text': 'I am good too.', 'sender': 'user'},
    {'text': 'What’s new?', 'sender': 'other'},
    {'text': 'Nothing much!', 'sender': 'user'},
    {'text': 'Alright, cool!', 'sender': 'other'},
    {'text': 'I am good too.', 'sender': 'user'},
    {'text': 'What’s new?', 'sender': 'other'},
    {'text': 'Nothing much!', 'sender': 'user'},
    {'text': 'Alright, cool!', 'sender': 'other'},
    {'text': 'How are you?', 'sender': 'user'},
    {'text': 'Doing great, thanks!', 'sender': 'other'},
    {'text': 'What about you?', 'sender': 'other'},
    {'text': 'I am good too.', 'sender': 'user'},
    {'text': 'What’s new?', 'sender': 'other'},
    {'text': 'Nothing much!', 'sender': 'user'},
    {'text': 'Alright, cool!', 'sender': 'other'},
    {'text': 'I am good too.', 'sender': 'user'},
    {'text': 'What’s new?', 'sender': 'other'},
    {'text': 'Nothing much!', 'sender': 'user'},
    {'text': 'Alright, cool!', 'sender': 'other'},
  ];

  final ScrollController _scrollController = ScrollController();
  late int visibleStartIndex = 0;
  late int visibleEndIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_calculateVisibleIndexes);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _calculateVisibleIndexes() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size.height;
    final itemHeight = 60.0; // Approximate height of each item
    final offset = _scrollController.offset;

    setState(() {
      visibleStartIndex = (offset / itemHeight).floor();
      visibleEndIndex = ((offset + size) / itemHeight).ceil();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat'),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            _calculateVisibleIndexes();
          }
          return false;
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: messages.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final message = messages[index];
            final alignment = message['sender'] == 'user'
                ? Alignment.centerLeft
                : Alignment.centerRight;

            final color = _getColorByVisiblePosition(index);

            return Align(
              alignment: alignment,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  message['text'],
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getColorByVisiblePosition(int index) {
    if (index < visibleStartIndex) {
      return Colors.red;
    } else if (index > visibleEndIndex) {
      return Colors.green;
    } else {
      final relativePosition = (index - visibleStartIndex) /
          (visibleEndIndex - visibleStartIndex + 1);
      if (relativePosition < 0.33) {
        return Colors.red;
      } else if (relativePosition < 0.66) {
        return Colors.blue;
      } else {
        return Colors.green;
      }
    }
  }
}
