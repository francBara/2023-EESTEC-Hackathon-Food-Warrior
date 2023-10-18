class TriviaSolution {
  late final int correctAnswerIndex;
  late final String comment;

  TriviaSolution(Map<String, dynamic> triviaSolutionData) {
    correctAnswerIndex = triviaSolutionData['correctAnswerIndex'];
    comment = triviaSolutionData['comment'];
  }
}
