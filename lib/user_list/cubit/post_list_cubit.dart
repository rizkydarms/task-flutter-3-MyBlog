// feed_list_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/post.dart';

// States
abstract class FeedListState {}

class FeedListInitial extends FeedListState {}
class FeedListLoading extends FeedListState {}
class FeedListSuccess extends FeedListState {
  final List<Feed> feeds;
  FeedListSuccess(this.feeds);
}
class FeedListError extends FeedListState {
  final String errorMessage;
  FeedListError(this.errorMessage);
}

class FeedListCubit extends Cubit<FeedListState> {
  FeedListCubit() : super(FeedListInitial());
  
  List<Feed> _feeds = [];

  Future<void> fetchFeed() async {
    try {
      emit(FeedListLoading());
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _feeds = data.map((json) => Feed.fromJson(json)).toList();
        emit(FeedListSuccess(_feeds));
      } else {
        emit(FeedListError('Failed to load feeds'));
      }
    } catch (e) {
      emit(FeedListError(e.toString()));
    }
  }

  Future<void> removeData(int id) async {
    try {
      _feeds.removeWhere((feed) => feed.id == id);
      emit(FeedListSuccess(_feeds));
    } catch (e) {
      emit(FeedListError('Failed to remove feed'));
    }
  }

  Feed? getFeedById(int id) {
    return _feeds.firstWhere((feed) => feed.id == id);
  }

  Feed? getNextFeed(int currentId) {
    int currentIndex = _feeds.indexWhere((feed) => feed.id == currentId);
    if (currentIndex == -1) return null;
    
    int nextIndex = currentIndex + 1;
    if (nextIndex >= _feeds.length) {
      return _feeds[0]; // Wrap to beginning
    }
    return _feeds[nextIndex];
  }

  Feed? getPreviousFeed(int currentId) {
    int currentIndex = _feeds.indexWhere((feed) => feed.id == currentId);
    if (currentIndex == -1) return null;
    
    int prevIndex = currentIndex - 1;
    if (prevIndex < 0) {
      return _feeds[_feeds.length - 1]; // Wrap to end
    }
    return _feeds[prevIndex];
  }
}