import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jollof/Homepage/ChoosePlanScreen.dart';
import 'package:jollof/QuestionnaireScreen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:math';
import '../KYC/LocationSelectionScreen.dart';
import 'HelpScreen.dart';
import 'InvestScreen.dart';
import 'AIAdvisorScreen.dart';


class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    InvestScreen(),
    AIAdvisorScreen(),
    Text('Help Screen'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Invest',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.moving),
            label: 'AI Advisor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer_rounded),
            label: 'Help',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}


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
                _buildWelcomeCard(context),
                SizedBox(height: 20),
                _buildCardRow(),
                SizedBox(height: 20),
                _buildQuickActions(),
                SizedBox(height: 20),
                _buildPortfolioSection(),
                SizedBox(height: 20),
                _buildFixreturnSection(),
                SizedBox(height: 20),
                _buildExploreSection(),
                SizedBox(height: 20),
                _buildTipsAndTricksSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/profile_pic.jpeg'),
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FaIcon(FontAwesomeIcons.gift, size: 15),
            SizedBox(width: 5,),
            Icon(Icons.notifications_outlined, size: 20),
          ],
        ),
      ],
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LocationSelectionScreen()),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircularPercentIndicator(
              radius: 30.0,
              lineWidth: 8.0,
              percent: 0.05,
              center: Text("5%"),
              progressColor: Colors.amber,
              backgroundColor: Colors.grey[200]!,
              circularStrokeCap: CircularStrokeCap.round,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to Jollof",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "The first step is to set up your account. It only takes 2 minutes.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
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
        image: DecorationImage(
          image: AssetImage('assets/badground-card.png'),
          fit: BoxFit.cover,
        ),
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
        backgroundImage: AssetImage('assets/bitcoin.png'),
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
    return FixedReturnsWidget();
  }

  Widget _buildExploreSection() {
    return ExploreSection();
  }

  Widget _buildTipsAndTricksSection() {
    return TipsAndTricksWidget();
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

class FixedReturnsWidget extends StatefulWidget {
  const FixedReturnsWidget({Key? key}) : super(key: key);

  @override
  _FixedReturnsWidgetState createState() => _FixedReturnsWidgetState();
}

class _FixedReturnsWidgetState extends State<FixedReturnsWidget> {
  int _activeIndex = 0;
  final List<Map<String, dynamic>> _packages = [
    {'duration': '6 months package', 'amount': 499.00, 'percentage': 25},
    {'duration': '12 months package', 'amount': 999.00, 'percentage': 50},
  ];

  void _handlePrev() {
    setState(() {
      _activeIndex = (_activeIndex > 0) ? _activeIndex - 1 : _packages.length - 1;
    });
  }

  void _handleNext() {
    setState(() {
      _activeIndex = (_activeIndex < _packages.length - 1) ? _activeIndex + 1 : 0;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Fixed Returns (Zero Risk)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: _handlePrev,
                ),
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Stack(
                    children: [
                      CustomPaint(
                        painter: CircleProgressPainter(
                          percentage: _packages[_activeIndex]['percentage'] / 100,
                          color: Colors.pink, progress: 20,
                        ),
                        child: Center(
                          child: Text(
                            '${_packages[_activeIndex]['percentage']}%',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: _handleNext,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'You invested',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              _packages[_activeIndex]['duration'],
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Text(
              '\$${_packages[_activeIndex]['amount'].toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleProgressPainter extends CustomPainter {
  final double percentage;
  final Color color;

  CircleProgressPainter({required this.percentage, required this.color, required double progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    final backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    final foregroundPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final sweepAngle = 2 * pi * percentage;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

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