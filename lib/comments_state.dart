part of 'comments_cubit.dart';

@immutable
sealed class CommentsState {}

final class CommentsInitial extends CommentsState {}


class CommentLoading extends CommentsState {}

class CommentLoaded extends CommentsState {
  final List<Comment> comments;

  CommentLoaded(this.comments);
}

class CommentError extends CommentsState {
  final String message;

  CommentError(this.message);
}

