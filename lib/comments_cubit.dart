import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test_api/comment_model.dart';
import 'package:meta/meta.dart';

part 'comments_state.dart';

class CommentCubit extends Cubit<CommentsState> {

  CommentCubit() : super(CommentsInitial());

  Future<void> fetchComments() async {
    try {
      emit(CommentLoading());
      final response = await Dio().get('https://jsonplaceholder.typicode.com/comments');
      List<Comment> comments = (response.data as List).map((json) => Comment.fromJson(json)).toList();
      emit(CommentLoaded(comments));
    } catch (e) {
      emit(CommentError('Failed to fetch comments'));
    }
  }
}

