import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_api/comments_cubit.dart';
import 'comment_model.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: BlocBuilder<CommentCubit, CommentsState>(
        builder: (context, state) {
          if (state is CommentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CommentLoaded) {
            return ListView.builder(
              itemCount: state.comments.length,
              itemBuilder: (context, index) {
                Comment comment = state.comments[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(comment.id.toString()),
                  ),
                  title: Text(comment.name),
                  subtitle: Text(comment.email),
                );
              },
            );
          } else if (state is CommentError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No comments yet'));
        },
      ),
    );
  }
}
