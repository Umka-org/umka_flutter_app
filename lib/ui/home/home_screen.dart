import 'package:flutter/material.dart';
import 'package:umka_flutter/ui/exam/exam_view.dart';
import 'package:umka_flutter/ui/question_answer/question_answer_view.dart';
import 'package:umka_flutter/ui/tutorial/tutorial_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentView(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'Questions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cast_for_education),
            label: 'Tutorial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Exam',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

Widget _getCurrentView(int index) {
  switch (index) {
    case 1:
      return TutorialView();
    case 2:
      return ExamView();
    default:
      return QuestionAnswerView();
  }
}
