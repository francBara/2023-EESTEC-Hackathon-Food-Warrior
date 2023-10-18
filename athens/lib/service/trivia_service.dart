import 'package:athens/model/trivia/trivia.dart';
import 'package:athens/model/trivia/trivia_solution.dart';
import 'package:athens/service/skeleton/authentication.dart';
import 'package:athens/service/skeleton/backend.dart';

class TriviaProxy {
  static Future<Trivia> getDailyTrivia() async {
    return Trivia(await Backend.get('getDailyTrivia'));
  }

  static Future<TriviaSolution> submitAnswer(Trivia trivia, int answerIndex) async {
    Map<String, dynamic> triviaSolution = await Backend.post(
      'submitTriviaAnswer',
      {
        'triviaId': trivia.id,
        'answerIndex': answerIndex,
        'user_token': await Authentication.getAuthToken()
      },
    );

    if (triviaSolution['correctAnswerIndex'] == answerIndex) {
      Authentication.user.points.value = Authentication.user.points.value + trivia.availablePoints;
    }
    return TriviaSolution(triviaSolution);
  }
}
