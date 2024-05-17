import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:async';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Shield',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const ChatPage(title: 'DoctorShield - Assistant'),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.title});

  final String title;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({
          "text": _controller.text,
          "isUser": "true",
        });
      });
      _controller.clear();
      _generateRandomReply();
    }
  }

  void _generateRandomReply() async {
    // Generate a random delay
    final random = math.Random();
    final delay = random.nextInt(500) + 500; // Random delay between 500ms and 1000ms

    // Simulate a delay
    await Future.delayed(Duration(milliseconds: delay));

    // Simulate a random reply
    final randomReplies = [
      "Would you like to get a quote?",
      "Tell me about your classification.",
      "What is the limit of your liability?",
      "What is the start date of your insurance?",
      "What is the end date of your insurance?",
      "This is the quote value XXXXSGD.",
      "Would you like to continue?"
    ];
    final reply = randomReplies[random.nextInt(randomReplies.length)];

    // Update the UI after the delay
    if (mounted) {
      setState(() {
        _messages.add({
          "text": reply,
          "isUser": "false",
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUserMessage = message["isUser"] == "true";
                return Row(
                  mainAxisAlignment: isUserMessage ? MainAxisAlignment.start : MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: isUserMessage ? Colors.blueAccent : Colors.green,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        message["text"]!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Send a message',
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
