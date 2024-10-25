import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'investor_quiz_screen.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class AIAdvisorScreen extends StatefulWidget {
  @override
  _AIAdvisorScreenState createState() => _AIAdvisorScreenState();
}

class _AIAdvisorScreenState extends State<AIAdvisorScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    Gemini.init(apiKey: 'AIzaSyA2nxR6JQ9cEqwLyDIpBN50ivvfCRdD4lY');
  }

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'content': _controller.text});
      _isTyping = true;
    });

    try {
      final response = await GeminiChat.sendMessage(_controller.text);
      setState(() {
        _messages.add({'role': 'bot', 'content': response.text});
      });
    } catch (e) {
      setState(() {
        _messages.add({'role': 'bot', 'content': 'Failed to get a response.'});
      });
    } finally {
      setState(() {
        _isTyping = false;
        _controller.clear();
      });
    }
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/profile_pic.jpeg'),
            radius: 20,
          ),
          Text(
            'AI Advisor',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeMessage() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.amber[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset('assets/robot_icon.png', fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Advisor',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Hello Kingsley! 👋\nWhat do you wish to do with Jollof?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String title,
    required String subtitle,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          elevation: 0,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.black87, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Ask me anything...',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ),
          SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(_isTyping ? Icons.hourglass_empty : Icons.send),
              color: Colors.black,
              onPressed: _isTyping ? null : _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessages() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[index];
          final isUser = message['role'] == 'user';

          return Container(
            margin: EdgeInsets.only(
              top: 8,
              bottom: 8,
              left: isUser ? 48 : 0,
              right: isUser ? 0 : 48,
            ),
            child: Row(
              mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                if (!isUser)
                  Container(
                    width: 32,
                    height: 32,
                    margin: EdgeInsets.only(right: 8),
                    child: Image.asset('assets/robot_icon.png'),
                  ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.amber : Colors.grey[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      message['content']!,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildWelcomeMessage(),
            _buildActionButton(
              title: 'Design a portfolio',
              subtitle: 'Invest in your ideas and get them auto rebalanced',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InvestorQuizScreen()),
              ),
            ),
            _buildActionButton(
              title: 'Explore portfolios',
              subtitle: 'Take a look at existing portfolios for investment ideas',
              onPressed: () {},
            ),
            _buildChatMessages(),
            _buildChatInput(),
          ],
        ),
      ),
    );
  }
}

class GeminiChat {
  static sendMessage(String text) {}
}