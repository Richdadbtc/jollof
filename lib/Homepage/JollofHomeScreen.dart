import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 20),
                _buildCardRow(),
                SizedBox(height: 20),
                _buildQuickActions(),
                SizedBox(height: 20),
                _buildPortfolioSection(),
                SizedBox(height: 20),
                _buildFixreturnSection(),  // FixedReturnsWidget is included here
                SizedBox(height: 20),
                _buildExploreSection(),
                SizedBox(height: 20),
                _buildTipsAndTricksSection(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/profile_pic.png'),
        ),
        Text(
          'Hello, Chris Uche',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter-SemiBold',
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: FaIcon(FontAwesomeIcons.gift, size: 15),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.notifications_outlined, size: 20),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCardRow() {
    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildJollofCard(const Color(0xfffed606)),
          SizedBox(width: 16),
          _buildJollofCard(Colors.green),
        ],
      ),
    );
  }

  Widget _buildJollofCard(Color cardColor) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0, 6), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Cash balance', style: TextStyle(color: Colors.black54, fontFamily: 'Inter-SemiBold')),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('Card Details', style: TextStyle(color: Colors.black54, fontFamily: 'Inter-SemiBold')),
              ),
            ],
          ),
          Text(
            '\$4,000.06',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter-Bold',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Manage', style: TextStyle(color: Colors.black54, fontFamily: 'Inter-SemiBold')),
              Text(
                'Jollof',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter-Bold',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildQuickActionItem(Icons.add, 'Add money'),
        _buildQuickActionItem(Icons.arrow_upward, 'Withdraw'),
        _buildQuickActionItem(Icons.explore, 'Discover'),
        _buildQuickActionItem(Icons.more_horiz, 'More'),
      ],
    );
  }

  Widget _buildQuickActionItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 24),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildPortfolioSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('My Portfolio', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Inter-SemiBold')),
            TextButton(
              onPressed: () {},
              child: Text('Portfolio builder', style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
        SizedBox(height: 10),
        _buildPortfolioItem('Bitcoin', 'BTC', '\$100.76', '+\$0.60 (0.58%)', Colors.orange),
        _buildPortfolioItem('Ethereum', 'ETH', '\$170.76', '+\$0.60 (0.58%)', Colors.blue),
      ],
    );
  }

  Widget _buildPortfolioItem(String name, String symbol, String amount, String change, Color color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(
          symbol.isNotEmpty ? symbol[0] : name[0],
          style: TextStyle(color: Colors.white, fontFamily: 'Inter-Bold'),
        ),
      ),
      title: Text(name),
      subtitle: Text(change, style: TextStyle(color: Colors.green)),
      trailing: Text(amount, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter-SemiBold')),
    );
  }

  Widget _buildFixreturnSection() {
    return FixedReturnsWidget();  // This is where the FixedReturnsWidget is included
  }

  Widget _buildExploreSection() {
    return ExploreSection();  // Use the ExploreSection widget here
  }

  Widget _buildTipsAndTricksSection() {
    return Text("Tips and Tricks");
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Invest'),
        BottomNavigationBarItem(icon: Icon(Icons.moving), label: 'AI Advisor'),
        BottomNavigationBarItem(icon: Icon(Icons.question_answer_rounded), label: 'Help'),
      ],
      currentIndex: 0,
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        // Handle navigation
      },
    );
  }
}

// The Explore Section Widget (from the earlier example)
class ExploreSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Explore',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter-SemiBold',
                ),
              ),
              TextButton(
                onPressed: () {
                  // Handle "See all" action
                },
                child: Text('See all', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
        _buildExploreItem(
            'Bitcoin', 'BTC', '\$200.76', '-1.38%', Colors.red, Colors.orange),
        _buildExploreItem('Ethereum', 'ETH', '\$100.76', '+1.38%', Colors.green,
            Colors.blue),
        _buildExploreItem('Cardano', 'ADA', '\$24.76', '+1.38%', Colors.green,
            Colors.lightBlue),
      ],
    );
  }

  Widget _buildExploreItem(String name, String symbol, String amount,
      String percentageChange, Color changeColor, Color logoColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: logoColor,
              child: Text(
                symbol[0],
                style: TextStyle(color: Colors.white, fontFamily: 'Inter-Bold'),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),
                Text(
                  percentageChange,
                  style: TextStyle(color: changeColor),
                ),
              ],
            ),
            Text(
              amount,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: 'Inter-SemiBold'),
            ),
          ],
        ),
      ),
    );
  }
}

// Sample FixedReturnsWidget implementation
class FixedReturnsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fixed Returns',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Inter-SemiBold'),
          ),
          SizedBox(height: 8),
          Text(
            'Earn up to 12% annually on fixed return investments. Zero risk!',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              // Handle invest now action
            },
            child: Text('Invest Now'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
          ),
        ],
      ),
    );
  }
}

// Tips and Tricks Widget
class TipsAndTricksWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tips and Tricks',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter-SemiBold',
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Boost your crypto knowledge and unlock exclusive rewards',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(height: 12),
          _buildCircularProgress(),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handle view all tips action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[200],
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Center(
              child: Text(
                'View all tips',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularProgress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildProgressIndicator(50, 'Growth on your investment', Colors.purple),
        _buildProgressIndicator(30, 'Value on your portfolio', Colors.orange),
        _buildProgressIndicator(20, 'Fixed ROI', Colors.green),
      ],
    );
  }

  Widget _buildProgressIndicator(int percentage, String label, Color color) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(
                value: percentage / 100,
                strokeWidth: 6,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(color),
              ),
            ),
            Text(
              '$percentage%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
