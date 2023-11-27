import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tab_news_api/data/model/user_model.dart';
import 'package:tab_news_api/features/user_profile/user_profile.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group("[USER PROFILE GROUP TEST]", () {
    late http.Client httpClient;
    late UserProfile userProfile;
    late Map<String, dynamic> dummyResponse;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      userProfile = UserProfile(httpClient: httpClient);
      dummyResponse = {
        "id": "497f6eca-6276-4993-bfeb-53cbbbba6f08",
        "username": "string",
        "email": "user@example.com",
        "notifications": true,
        "features": [
          "create:session",
          "read:session",
          "create:content",
          "create:content:text_root",
          "create:content:text_children",
          "update:content",
          "update:user"
        ],
        "tabcoins": 0,
        "tabcash": 0,
        "created_at": "2019-08-24T14:15:22Z",
        "updated_at": "2019-08-24T14:15:22Z"
      };
    });

    group("Constructor test: ", () {
      test("Should return a UserProfile class", () {
        expect(userProfile, isA<UserProfile>());
      });
    });

    group("Get user profile test:", () {
      test("Should get user profile", () async {
        // Arrange
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(jsonEncode(dummyResponse));
        when(() => httpClient.get(any(), headers: any(named: "headers")))
            .thenAnswer((_) async => response);

        // Act
        final result = await userProfile.getUserProfile(sessionId: "a");
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

      test("Should throw a ProfileFailure", () async {
        // Arrange
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn(jsonEncode(dummyResponse));
        when(() => httpClient.get(any(), headers: any(named: "headers")))
            .thenAnswer((_) async => response);

        // Act
        final call = userProfile.getUserProfile(sessionId: "a");
        // Assert
        expect(() => call, throwsA(isA<ProfileFailure>()));
      });
    });
  });
}
