import 'package:flutter/material.dart';

class HelpCenterWidget extends StatelessWidget {
  const HelpCenterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      'Help Center',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balance the back button
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hi, how can we help you today?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Search Bar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Quick Links Section
                      const Text(
                        'Quick links',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildQuickLinks(),
                      const SizedBox(height: 24),

                      // Recommended Section
                      const Text(
                        'Recommended',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildRecommended(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickLinks() {
    final quickLinks = [
      {'icon': Icons.chat_bubble_outline, 'text': 'Chat with Jollof chat assistant'},
      {'icon': Icons.phone_outlined, 'text': 'Get in touch'},
      {'icon': Icons.description_outlined, 'text': 'Download a statement'},
      {'icon': Icons.help_outline, 'text': 'Question on my investment'},
    ];

    return Column(
      children: quickLinks
          .map((link) => _buildLinkItem(link['icon'] as IconData, link['text'] as String))
          .toList(),
    );
  }

  Widget _buildRecommended() {
    final recommended = [
      {'icon': Icons.error_outline, 'text': 'I have a problem with a transaction'},
      {'icon': Icons.security_outlined, 'text': 'How to keep my money safe'},
      {'icon': Icons.trending_up, 'text': 'Which investment plan is better for me'},
    ];

    return Column(
      children: recommended
          .map((link) => _buildLinkItem(link['icon'] as IconData, link['text'] as String))
          .toList(),
    );
  }

  Widget _buildLinkItem(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Handle navigation
            print('Navigating to: $text');
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(icon, color: Colors.grey[600]),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey[400]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}