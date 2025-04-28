import 'dart:io';

//import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelverse_clone/apis/storage_api.dart';
import 'package:pixelverse_clone/apis/tweet_api.dart';
import 'package:pixelverse_clone/core/enums/tweet_type_enum.dart';
import 'package:pixelverse_clone/core/utils.dart';
import 'package:pixelverse_clone/features/auth/controller/auth_controller.dart';
import 'package:pixelverse_clone/models/tweet_model.dart';
//import 'package:pixelverse_clone/models/user_model.dart';


final tweetControllerProvider = StateNotifierProvider<TweetController, bool>(
  (ref) {
    return TweetController(
      ref: ref,
      tweetAPI: ref.watch(tweetAPIProvider),
      storageAPI: ref.watch(storageAPIProvider),
      // notificationController:
      //     ref.watch(notificationControllerProvider.notifier),
    );
  },
);

final getTweetsProvider = FutureProvider((ref) {
  final tweetController = ref.watch(tweetControllerProvider.notifier);
  return tweetController.getTweets();
});

final getLatestTweetProvider = StreamProvider((ref) {
  final tweetAPI = ref.watch(tweetAPIProvider);
  return tweetAPI.getLatestTweet();
});
class TweetController extends StateNotifier<bool> {
  final TweetAPI _tweetAPI;
  final StorageAPI _storageAPI;
  final Ref _ref;
  TweetController({
    required Ref ref,
    required TweetAPI tweetAPI,
    required StorageAPI storageAPI,
  }): _ref = ref,
      _tweetAPI = tweetAPI,
      _storageAPI = storageAPI,
      super(false);

  Future<List<Tweet>> getTweets() async {
    final tweetList = await _tweetAPI.getTweets();
    return tweetList.map((tweet) => Tweet.fromMap(tweet.data)).toList();
  }

  void shareTweet({
    //theoreticallly should be okay for images empty list, and if empty, only text tweet
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {
    if (text.isEmpty) {
      showSnackBar(context, 'Please add text');
      return;
    }

    if (images.isNotEmpty) {
      _shareImageTweet(
        images: images, 
        text: text, 
        context: context,
        );
    } else {
      _shareTextTweet(
        text: text, 
        context: context,
        );
    }
  }

  void _shareImageTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) async {
    state = true;
    final hashtags = _getHashtagsFromText(text);
    String link = _getLinkFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;
    final imageLinks = await _storageAPI.uploadImage(images);
    Tweet tweet = Tweet(
      text: text,
      hashtags: hashtags,
      link: link,
      imageLinks: imageLinks,
      uid: user.uid,
      tweetType: TweetType.image,
      tweetedAt: DateTime.now(),
      likes: const [],
      commentIds: const [],
      id: '',
      reshareCount: 0,
    );
    final res = await _tweetAPI.shareTweet(tweet);
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message), (r) => null); //{
        // state = false;
        // showSnackBar(context, 'Tweet shared successfully');
        // Navigator.pop(context);
      //},
    //);
  }

  void _shareTextTweet({
    required String text,
    required BuildContext context,
  }) async {
    state = true;
    final hashtags = _getHashtagsFromText(text);
    String link = _getLinkFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;
    Tweet tweet = Tweet(
      text: text,
      hashtags: hashtags,
      link: link,
      imageLinks: const [],
      uid: user.uid,
      tweetType: TweetType.text,
      tweetedAt: DateTime.now(),
      likes: const [],
      commentIds: const [],
      id: '',
      reshareCount: 0,
    );
    final res = await _tweetAPI.shareTweet(tweet);
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message), (r) => null); //{
        // state = false;
        // showSnackBar(context, 'Tweet shared successfully');
        // Navigator.pop(context);
      //},
    //);
  }

  String _getLinkFromText(String text) {
    // Kevin Zheng YouTube www.youtube.com
    // [Kevin, Zheng, YouTube, www.youtube.com]
    // return www.youtube.com
    String link = '';
    List<String> wordsInSentence = text.split(' ');
    for (String word in wordsInSentence) {
      if (word.startsWith('https://') || word.startsWith('www.')) {
        link = word;
      }
    }
    return link;
  }

  List<String> _getHashtagsFromText(String text) {
    // #Kevin #Zheng YouTube www.youtube.com
    // [#Kevin, #Zheng, YouTube, www.youtube.com]
    // return [#Kevin, #Zheng]
    List<String> hashtags = [];
    List<String> wordsInSentence = text.split(' ');
    for (String word in wordsInSentence) {
      if (word.startsWith('#')) {
        hashtags.add(word);
      }
    }
    return hashtags;
  }
}
