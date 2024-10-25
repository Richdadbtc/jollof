import 'package:flutter/material.dart';
import 'package:jollof/Homepage/AIAdvisorScreen.dart';
import 'package:jollof/Homepage/JollofHomeScreen.dart';

class InvestorQuizScreen extends StatelessWidget {
  const InvestorQuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: Text(
          'Investor Quiz',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/verification_bot.png', // Replace with your bot image
                height: 120,
                width: 120,
              ),
              SizedBox(height: 40),
              Text(
                'Set up your investor profile.',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'We require some additional details about your risk tolerance to tailor your strategies. It\'ll only take less than a minute.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    'Continue',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Navigate to the first quiz screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizScreen1()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: Text(
          'Investor Quiz 1/3',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset('assets/verification_bot.png', height: 120, width: 120),
              SizedBox(height: 40),
              Text(
                'What investment goal aligns best with your preferences?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              OptionTile('Prioritizing capital preservation and avoiding significant risks.'),
              OptionTile('Seeking higher returns with a willingness to accept higher risks.'),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizScreen2()),
                    );
                  },
                  child: Text('Next'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: Text(
          'Investor Quiz 2/3',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset('assets/verification_bot.png', height: 120, width: 120),
              SizedBox(height: 40),
              Text(
                'How would you describe your reaction to fluctuating investments in the short term?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              OptionTile('I am comfortable with some ups and downs.'),
              OptionTile('I prefer stability and am willing to accept minimal fluctuations.'),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizScreen3()),
                    );
                  },
                  child: Text('Next'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: Text(
          'Investor Quiz 3/3',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset('assets/verification_bot.png', height: 120, width: 120),
              SizedBox(height: 40),
              Text(
                'In the event of a market downturn, what would you prefer?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              OptionTile('Stay invested and wait for the market to recover.'),
              OptionTile('Consider using a STOP PLUS to minimize risk exposure.'),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResultScreen()),
                    );
                  },
                  child: Text('Done'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
      ),
      body: Center(
        child: Text(
          'Congratulations, you have completed the quiz!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class OptionTile extends StatelessWidget {
  final String text;

  OptionTile(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        tileColor: Colors.white,
        title: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        trailing: Radio(
          value: true,
          groupValue: false,
          onChanged: (value) {},
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
