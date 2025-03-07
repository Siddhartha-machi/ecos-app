import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecos_main/common/models/extension_models.dart';
import 'package:ecos_main/repositories/comments_data_service.dart';

class CommentNotifier extends StateNotifier<AsyncValue<List<Comment>>> {
  final CommentDataService commentService;

  CommentNotifier(this.commentService) : super(const AsyncValue.loading()) {
    fetchComments();
  }

  Future<void> fetchComments() async {
    state = const AsyncValue.loading();
    try {
      final comments = await commentService.fetchAll();
      state = AsyncValue.data(comments);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> createComment(Comment comment) async {
    try {
      final newComment = await commentService.createItem(comment);
      state = AsyncValue.data([...state.value ?? [], newComment]);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateComment(String id, Comment comment) async {
    try {
      final updatedComment = await commentService.updateItem(id, comment);
      state = AsyncValue.data(
        state.value!.map((u) => u.id == id ? updatedComment : u).toList(),
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteComment(String id) async {
    try {
      final success = await commentService.deleteItem(id);
      if (success) {
        state = AsyncValue.data(state.value!.where((c) => c.id != id).toList());
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
