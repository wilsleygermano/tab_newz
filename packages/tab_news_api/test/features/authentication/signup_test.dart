import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tab_news_api/data/model/models.dart';
import 'package:tab_news_api/features/authentication/signup.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group("[SIGNUP GROUP TEST]", () {
    late http.Client httpClient;
    late SignUp signup;
    late Map<String, dynamic> dummyResponse;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      signup = SignUp(httpClient: httpClient);
      dummyResponse = {
        "id": "933757f5-cb0c-45bf-9a79-7e608baf83cd",
        "username": "aerwrsd",
        "description": "",
        "features": ["read:activation_token"],
        "tabcoins": 0,
        "tabcash": 0,
        "created_at": "2023-11-20T17:58:11.986Z",
        "updated_at": "2023-11-20T17:58:11.986Z"
      };
    });

    group("Constructor test: ", () {
      test("Should return a SignUp class", () {
        expect(signup, isA<SignUp>());
      });
    });

    group("Sign user up test:", () {
      test("Should sign a user up", () async {
        // Arrange
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(jsonEncode(dummyResponse));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        // Act
        final result = await signup(
            email: "email", password: "password", username: "username");

        // Assert
        expect(result, isA<UserModel>());
        expect(result.id, isNotEmpty);
        expect(result.username, isNotEmpty);
        expect(result.description, isEmpty);
        expect(result.features, isNotEmpty);
        expect(result.createdAt, isNotEmpty);
        expect(result.updatedAt, isNotEmpty);
        expect(result.tabCoins, 0);
        expect(result.tabCash, 0);
      });
    });

    test(
        "Should throw a SignupFailure when status code is not 200 and body is not empty",
        () async {
      // Arrange
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(400);
      when(() => response.body).thenReturn(jsonEncode(dummyResponse));
      when(() => httpClient.get(any())).thenAnswer((_) async => response);

      // Assert
      expect(
          () => signup(
              email: "email", password: "password", username: "username"),
          throwsA(isA<SignupFailure>()));
    });
  });
}
