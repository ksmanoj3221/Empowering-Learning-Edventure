class Question {
  final String questionText;
  final List<Answer> answersList;

  Question(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestions() {
  List<Question> list = [];
  //ADD questions and answer here

  list.add(Question(
    "5 x 5 = ?",
    [
      Answer("20", false),
      Answer("30", false),
      Answer("25", true),
      Answer("45", false),
    ],
  ));

  list.add(Question(
    "10 + 25 = ?",
    [
      Answer("35", true),
      Answer("45", false),
      Answer("30", false),
      Answer("50", false),
    ],
  ));

  list.add(Question(
    "100 - 20 = ?",
    [
      Answer("60", false),
      Answer("70", false),
      Answer("85", false),
      Answer("80", true),
    ],
  ));

  list.add(Question(
    "10 ÷ 2 = ?",
    [
      Answer("5", true),
      Answer("10", false),
      Answer("20", false),
      Answer("1", false),
    ],
  ));

  return list;
}