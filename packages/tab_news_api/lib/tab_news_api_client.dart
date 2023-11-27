import 'package:tab_news_api/features/authentication/authentication_client.dart';
import 'package:tab_news_api/features/content/content.dart';
import 'package:tab_news_api/features/publishing/publish.dart';
import 'package:tab_news_api/features/voting/voting.dart';
import 'data/model/models.dart';
import 'features/user_profile/user_profile.dart';

class TabNewsAPiClient {
  final _auth = AuthenticationClient();
  final _content = Content();
  final _publisher = Publish();
  final _voting = Voting();
  final _userProfile = UserProfile();

  /// Login a user
  /// [email] is the email of the user
  /// [password] is the password of the user
  /// Returns a [SessionModel] with the session id of the user
  ///
  Future<SessionModel> login({
    required String email,
    required String password,
  }) async {
    return await _auth.login(email: email, password: password);
  }

  /// Recover a user password. User must access the email to recover the password
  /// [email] is the email of the user
  /// [username] is the username of the user
  ///
  Future<void> passwordRecovery({
    required String email,
    required String username,
  }) async {
    return await _auth.passwordRecovery(
      email: email,
      username: username,
    );
  }

  /// Sign up a new user
  /// [email] is the email of the user
  /// [username] is the username of the user
  /// [password] is the password of the user
  /// [passwordConfirmation] is the password confirmation of the user
  ///
  Future<UserModel> signUp({
    required String email,
    required String username,
    required String password,
    required String passwordConfirmation,
  }) async {
    return await _auth.signUp(
      email: email,
      username: username,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }

  Future<List<NewsModel>> getNews({int? page = 1}) async {
    return await _content.getNews(page: page);
  }

  /// Get the selected news [NewsModel]
  /// [ownerName] is the owner of the news
  /// [newsSlug] is the slug of the news
  /// Only the selected news is returned
  Future<NewsModel> getSelectedNews({
    required String ownerName,
    required String newsSlug,
  }) async {
    return await _content.getSelectedNews(
      ownerName: ownerName,
      newsSlug: newsSlug,
    );
  }

  /// Get the comments [List<NewsModel>] of a news
  /// [ownerName] is the owner of the news
  /// [newsSlug] is the slug of the news
  /// All the comments of a news are returned

  Future<List<NewsModel>> getComments({
    required String ownerName,
    required String newsSlug,
  }) async {
    return await _content.getComments(
      ownerName: ownerName,
      newsSlug: newsSlug,
    );
  }

  /// Publish, edit or delete a content
  /// [title] is the title of the content
  /// [body] is the body of the content
  /// [sessionId] is the session id of the user
  /// [status] is the status of the content and can be [PublishStatus.published], [PublishStatus.deleted] or [PublishStatus.draft]
  ///
  Future<void> publish({
    required String title,
    required String body,
    required String sessionId,
    required PublishStatus status,
  }) async {
    return await _publisher.call(
      title: title,
      body: body,
      sessionId: sessionId,
      status: status,
    );
  }

  /// Vote in a content
  /// [sessionId] is the session id of the user
  /// [authorId] is the author id of the content
  /// [newsSlug] is the slug of the content
  /// [status] is the status of the vote and can be [VotingStatus.upVote] or [VotingStatus.downVote]
  ///
  Future<void> vote({
    required String sessionId,
    required String authorId,
    required String newsSlug,
    required VotingStatus status,
  }) async {
    return await _voting.call(
      sessionId: sessionId,
      authorId: authorId,
      newsSlug: newsSlug,
      status: status,
    );
  }

  /// Get the user profile [UserModel]
  /// [sessionId] is the session id of the user
  Future<UserModel> getUserProfile({
    required String sessionId,
  }) async {
    return await _userProfile.getUserProfile(
      sessionId: sessionId,
    );
  }

  /// Edit the user profile [UserModel]
  /// [sessionId] is the session id of the user
  /// [oldUserName] is the old username of the user
  /// [newEmail] is the new email of the user
  /// [newUsername] is the new username of the user
  ///
  Future<UserModel> editUserProfile({
    required String sessionId,
    required String oldUserName,
    String? newEmail,
    String? newUsername,
  }) async {
    return await _userProfile.editUserProfile(
      sessionId: sessionId,
      oldUserName: oldUserName,
      newEmail: newEmail,
      newUsername: newUsername,
    );
  }
}
