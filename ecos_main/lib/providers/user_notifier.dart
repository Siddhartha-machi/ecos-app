import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecos_main/common/models/user_models.dart';
import 'package:ecos_main/repositories/user_data_service.dart';

class UserNotifier extends StateNotifier<AsyncValue<List<User>>> {
  final UserDataService userService;

  UserNotifier(this.userService) : super(const AsyncValue.loading()) {
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    state = const AsyncValue.loading();
    try {
      final users = await userService.fetchAll();
      state = AsyncValue.data(users);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> createUser(User user) async {
    try {
      final newUser = await userService.createItem(user);
      state = AsyncValue.data([...state.value ?? [], newUser]);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateUser(String id, User user) async {
    try {
      final updatedUser = await userService.updateItem(id, user);
      state = AsyncValue.data(
        state.value!.map((u) => u.id == id ? updatedUser : u).toList(),
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      final success = await userService.deleteItem(id);
      if (success) {
        state = AsyncValue.data(state.value!.where((u) => u.id != id).toList());
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
