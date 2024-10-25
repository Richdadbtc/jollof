import 'package:flutter/material.dart';
import 'package:jollof/ExplainerScreen.dart';

class QuestionnaireScreen extends StatelessWidget {
  final int questionIndex;

  QuestionnaireScreen({required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Let us know you', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            child: Text('Skip', style: TextStyle(color: Colors.amber)),
            onPressed: () {
              // Handle skip action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress bar and step count
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: (questionIndex + 1) / 6,  // Adjust this to your progress
                      strokeWidth: 6,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                      backgroundColor: Colors.grey[200],
                    ),
                    Text(
                      '${((questionIndex + 1) / 6 * 100).round()}%',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(width: 260),
                Text('${questionIndex + 1}/6',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: getQuestionWidget(questionIndex, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget getQuestionWidget(int index, BuildContext context) {
    switch (index) {
      case 0:
        return QuestionOne();
      case 1:
        return QuestionTwo();
      case 2:
        return QuestionThree();
      case 3:
        return QuestionFour();
      case 4:
        return QuestionFive();
      case 5:
        return QuestionSix();
      default:
        return Container();
    }
  }
}

// Below are your Question screens (no changes needed unless you want to style more)
class QuestionOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QuestionTemplate(
      question: 'Considering your financial goals, which statement aligns most with your preference?',
      options: [
        'I\'m seeking higher returns and am willing to accept higher risks.',
        'I value a balance between returns and stability.',
        'I prioritize capital preservation and am risk-averse.',
      ],
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuestionnaireScreen(questionIndex: 1)),
        );
      },
    );
  }
}

// Define QuestionTwo class
class QuestionTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QuestionTemplate(
      question: 'How do you generally feel about the idea of your investment value fluctuating in the short term?',
      options: [
        'I\'m comfortable with some ups and downs.',
        'I prefer stability and am willing to accept minimal fluctuations.',
        'I\'m open to moderate changes but cautious about significant swings.',
      ],
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuestionnaireScreen(questionIndex: 2)),
        );
      },
    );
  }
}

// Define QuestionThree class
class QuestionThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QuestionTemplate(
      question: 'What would be your reaction if your investment portfolio experienced a temporary decline?',
      options: [
        'I would stay invested and wait for the market to recover.',
        'I might consider adjusting my portfolio slightly to minimize losses.',
        'I would be concerned and might consider a more conservative approach.',
      ],
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuestionnaireScreen(questionIndex: 3)),
        );
      },
    );
  }
}

// Define QuestionFour class
class QuestionFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QuestionTemplate(
      question: 'When it comes to investing, what is your preferred timeline for achieving financial goals?',
      options: [
        'I have a longer-term perspective and can weather market fluctuations.',
        'I have a balanced outlook with both short and medium-term goals.',
        'I prefer shorter-term goals with quicker returns.',
      ],
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuestionnaireScreen(questionIndex: 4)),
        );
      },
    );
  }
}

class QuestionFive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QuestionTemplate(
      question: 'How would you describe your knowledge and experience with investment markets?',
      options: [
        'I\'m well-versed and actively follow market trends.',
        'I have a moderate understanding and keep an eye on key developments.',
        'I\'m relatively new and prefer straightforward, low-risk options.',
      ],
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuestionnaireScreen(questionIndex: 5)),
        );
      },
    );
  }
}

// Define QuestionSix class
class QuestionSix extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QuestionTemplate(
      question: 'In the face of market uncertainty, what is your inclination regarding investment decisions?',
      options: [
        'I am open to making adjustments based on market conditions.',
        'I prefer a steady course and may make minimal changes.',
        'I tend to avoid making hasty decisions and would stay the course.',
      ],
      onNext: () {
        // Handle completion of the questionnaire
        // For example, navigate to a results or summary screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ExplainerScreen()), // Replace with your final screen
        );
      },
    );
  }
}




class QuestionTemplate extends StatefulWidget {
  final String question;
  final List<String> options;
  final VoidCallback onNext;

  QuestionTemplate({required this.question, required this.options, required this.onNext});

  @override
  _QuestionTemplateState createState() => _QuestionTemplateState();
}

class _QuestionTemplateState extends State<QuestionTemplate> {
  int? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            widget.question,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...widget.options.asMap().entries.map((entry) {
          return RadioListTile<int>(
            title: Text(entry.value,),
            value: entry.key,
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value;
              });
            },
          );
        }).toList(),
        Spacer(),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: Icon(Icons.arrow_forward),
              onPressed: selectedOption != null ? widget.onNext : null,
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(), backgroundColor: Colors.amber,
                padding: EdgeInsets.all(16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
