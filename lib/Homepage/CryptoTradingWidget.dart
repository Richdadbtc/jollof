import 'package:flutter/material.dart';

class CryptoTradingWidget extends StatelessWidget {
  const CryptoTradingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Tips and Tricks',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Crypto price cards
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCryptoCard(
                  'Bitcoin',
                  'BTC',
                  '\$30,000.78',
                  '+1.09%',
                  Colors.amber,
                ),
                _buildCryptoCard(
                  'Cronos',
                  'BTC',
                  '\$30',
                  '+0.5%',
                  Colors.deepOrange,
                ),
              ],
            ),
          ),

          // Trading post card
          Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Monkey NFT image placeholder
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.amber.shade300,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: const Center(
                    child: Text('NFT Image Placeholder'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            '2 mins ago',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.favorite_border),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.share),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const Text(
                        'New trading pairs: Trade CDCETH with PYUSD, USDT and USD and any other thing here...',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom navigation
          const Spacer(),
          BottomNavigationBar(
            selectedItemColor: Colors.amber,
            unselectedItemColor: Colors.grey,
            currentIndex: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.show_chart),
                label: 'Invest',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics),
                label: 'AI Advisor',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline),
                label: 'Help',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCryptoCard(
      String name,
      String symbol,
      String price,
      String change,
      Color iconColor,
      ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.currency_bitcoin,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              symbol,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  change,
                  style: TextStyle(
                    color: change.startsWith('+') ? Colors.green : Colors.red,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}