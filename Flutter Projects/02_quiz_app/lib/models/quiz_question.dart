class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  List<String> getShuffledAnswers() {
    final shuffledList = List.of(answers);
    // This will reorganize the existing list
    shuffledList.shuffle();
    return shuffledList;
  }
}