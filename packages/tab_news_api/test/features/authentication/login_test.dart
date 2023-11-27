import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tab_news_api/data/model/models.dart';
import 'package:tab_news_api/features/authentication/login.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group("[LOGIN GROUP TEST] - ", () {
    late http.Client httpClient;
    late Login login;
    late Map<String, dynamic> dummyResponse;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      login = Login(httpClient: httpClient);
      dummyResponse = {
        "id": "badasd48d5-4e44-4dfa-a4cd-e8494fe24900",
        "token":
            "7d4adafdsafdsfasfasfadfadsf5b01ce105e2eb21da6efe7f42373f209927e4a25c04fb472d7856d3d54",
        "expires_at": "2023-12-20T17:30:30.570Z",
        "created_at": "2023-11-20T17:30:30.571Z",
        "updated_at": "2023-11-20T17:30:30.571Z"
      };
    });

    group("Constructor test: ", () {
      test("Should return a Login class", () {
        expect(login, isA<Login>());
      });
    });

    group("Log user in test:", () {
      test("Should log a user in", () async {
        // Arrange
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(jsonEncode(dummyResponse));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        // Act
        final result = await login.login(email: "email", password: "password");

        // Assert
        expect(result, isA<SessionModel>());
        expect(result.id, isNotEmpty);
        expect(result.token, isNotEmpty);
        expect(result.expiresAt, isNotEmpty);
        expect(result.createdAt, isNotEmpty);
      });

      test("Should throw a LoginRequestFailure when status code is not 200",
          () async {
        // Arrange
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        // Assert
        expect(() => login.login(email: "email", password: "password"),
            throwsA(isA<LoginRequestFailure>()));
      });
    });
  });
}
