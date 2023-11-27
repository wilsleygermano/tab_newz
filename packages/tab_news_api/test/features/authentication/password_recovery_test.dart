import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tab_news_api/features/authentication/password_recovery.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group("[PASSWORD RECOVERY GROUP TEST]", () {
    late http.Client httpClient;
    late PasswordRecovery recover;
    late Map<String, dynamic> dummyResponse;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      recover = PasswordRecovery(httpClient: httpClient);
      dummyResponse = {
        "used": false,
        "expires_at": "2023-11-20T18:43:20.858Z",
        "created_at": "2023-11-20T18:28:20.858Z",
        "updated_at": "2023-11-20T18:28:20.858Z"
      };
    });

    group("Constructor test: ", () {
      test("Should return a PasswordRecovery class", () {
        expect(recover, isA<PasswordRecovery>());
      });
    });

    group("Password recovery test:", () {
      test("Should recover a user password", () async {
        // Arrange
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(jsonEncode(dummyResponse));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        // Act
        final call = recover.passwordRecovery;

        // Assert
        expect(() => call(email: "a", username: "a"), returnsNormally);
      });

      test("Should throw an EmptyParametersFailure", () async {
        // Arrange
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn(jsonEncode(dummyResponse));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        // Act
        final call = recover.passwordRecovery;

        // Assert
        expect(() => call(email: "", username: ""),
            throwsA(isA<EmptyParametersFailure>()));
      });

      test("Should throw a PasswordRecoveryRequestFailure", () async {
        // Arrange
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn(jsonEncode(dummyResponse));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        // Act
        final call = recover.passwordRecovery;

        // Assert
        expect(() => call(email: "a", username: "a"),
            throwsA(isA<PasswordRecoveryRequestFailure>()));
      });
    });
  });
}
