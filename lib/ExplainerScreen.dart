import 'package:flutter/material.dart';

class ExplainerScreen extends StatefulWidget {
  @override
  _ExplainerScreenState createState() => _ExplainerScreenState();
}

class _ExplainerScreenState extends State<ExplainerScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  final List<Widget> _pages = [
    ExplainerPage(
      image: 'assets/budget_icon.png',
      text: 'Jollof Helps novice and others invest and profit from crypto like a pro using automated AI trading Algorithms.',
    ),
    ExplainerPage(
      image: 'assets/savings_icon.png',
      text: 'Jollof AI Trading BOT automatically trades cryptocurrencies based on smart contracts.',
    ),
    ExplainerPage(
      image: 'assets/investment_icon.png',
      text: 'You receive a fixed monthly return on their investment, regardless of market fluctuations.',
    ),
    ExplainerPage(
      image: 'assets/credit_icon.png',
      text: 'Jollof uses AI to analyze market trends and build a diversified portfolio of promising cryptocurrencies.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explainer'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: _pages,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DotsIndicator(
                  dotsCount: _pages.length,
                  position: _currentPage,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage < _pages.length - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Icon(
                      Icons.arrow_forward,
                      color: Colors.black),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber, // Background color
                    foregroundColor: Colors.white,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExplainerPage extends StatelessWidget {
  final String image;
  final String text;

  const ExplainerPage({Key? key, required this.image, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 200),
          SizedBox(height: 32),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class DotsIndicator extends StatelessWidget {
  final int dotsCount;
  final int position;

  const DotsIndicator({Key? key, required this.dotsCount, required this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(dotsCount, (index) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: position == index ? Colors.amber : Colors.grey,
          ),
        );
      }),
    );
  }
}