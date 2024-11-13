import 'package:equatable/equatable.dart';

import '../model/post.dart';

abstract class FeedListState extends Equatable {
  const FeedListState();

  const factory FeedListState.initial() = FeedListInitial;
  const factory FeedListState.loading() = FeedListLoading;
  const factory FeedListState.success(List<Feed> feeds) = FeedListSuccess;
  const factory FeedListState.error(String errorMessage) = FeedListError;

  @override
  List<Object?> get props => [];
}

class FeedListInitial extends FeedListState {
  const FeedListInitial();
}

class FeedListLoading extends FeedListState {
  const FeedListLoading();
}

class FeedListSuccess extends FeedListState {
  final List<Feed> feeds;

  const FeedListSuccess(this.feeds);
}

class FeedListError extends FeedListState {
  final String errorMessage;

  const FeedListError(this.errorMessage);
}