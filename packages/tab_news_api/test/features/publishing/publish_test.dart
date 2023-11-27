import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tab_news_api/features/publishing/publish.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group("[PUBLISH GROUP TEST]", () {
    late http.Client httpClient;
    late Publish publish;
    late Map<String, dynamic> dummyPostBody;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      publish = Publish(httpClient: httpClient);
      dummyPostBody = {
        'title': "Dummy Title",
        'body': "Dummy body",
        'status': "published",
      };
    });

    group("Constructor Test", () {
      test("Should return a Publish class", () {
        expect(publish, isA<Publish>());
      });
    });

    group("Publish Content", () {
      test("Should successfully publish a content", () async {
        // Arrange
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(jsonEncode(dummyPostBody));
        when(() => httpClient.post(any(),
            headers: any(named: "headers"),
            body: any(named: "body"))).thenAnswer((_) async => response);

        // Act
        final result = publish.call;

        // Assert
        // Assert
        expect(
            () => result(
                title: "Dummy Title",
                body: "Dummy body",
                sessionId: "dummy_session_id",
                status: PublishStatus.published),
            returnsNormally);
      });

      test("Should throw a PublishFailure", () async {
        // Arrange
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn(jsonEncode(dummyPostBody));
        when(() => httpClient.post(any(),
            headers: any(named: "headers"),
            body: any(named: "body"))).thenAnswer((_) async => response);

        // Act
        final result = publish.call;

        // Assert
        expect(
            () => result(
                title: "Dummy Title",
                body: "Dummy body",
                sessionId: "dummy_session_id",
                status: PublishStatus.published),
            throwsA(isA<PublishFailure>()));
      });
    });
  });
}
