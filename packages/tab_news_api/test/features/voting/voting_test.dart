import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tab_news_api/features/voting/voting.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group("[VOTING GROUP TEST]", () {
    late http.Client httpClient;
    late Voting vote;
    late Map<String, dynamic> dummyResponse;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      vote = Voting(httpClient: httpClient);
      dummyResponse = {
        "name": "UnprocessableEntityError",
        "message": "Não foi possível adicionar TabCoins nesta publicação.",
        "action":
            "Você precisa de pelo menos 2 TabCoins para realizar esta ação.",
        "status_code": 422,
        "error_id": "79222985-3c40-4daf-bacc-4d1b9c35a105",
        "request_id": "*********-65a2-4357-bfd0-75911fd55f54",
        "error_location_code": "MODEL:BALANCE:RATE_CONTENT:NOT_ENOUGH"
      };
    });

    group("Constructor test: ", () {
      test("Should return a Voting class", () {
        expect(vote, isA<Voting>());
      });
    });

    group("Voting test:", () {
      test("Should vote in a news", () async {
        // Arrange
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(jsonEncode(dummyResponse));
        when(() => httpClient.post(any(),
            headers: any(named: "headers"),
            body: any(named: "body"))).thenAnswer((_) async => response);

        // Act
        final call = vote;
        // Assert
        expect(
            () => call(
                sessionId: "a",
                authorId: "a",
                newsSlug: "a",
                status: VotingStatus.upVote),
            returnsNormally);
      });

      test("Should throw an VotingFailure", () async {
        // Arrange
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn(jsonEncode(dummyResponse));
        when(() => httpClient.post(any(),
            headers: any(named: "headers"),
            body: any(named: "body"))).thenAnswer((_) async => response);

        // Act
        final call = vote;
        // Assert
        expect(
            () => call(
                sessionId: "a",
                authorId: "a",
                newsSlug: "a",
                status: VotingStatus.upVote),
            throwsA(isA<VotingFailure>()));
      });
    });
  });
}
