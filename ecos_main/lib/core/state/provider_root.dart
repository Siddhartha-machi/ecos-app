import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecos_main/features/auth/lib/repositories/user_data_service.dart';
import 'package:ecos_main/core/data/repositories/extension_data_service.dart';
import 'package:ecos_main/core/data/repositories/extension_detail_data_service.dart';
import 'package:ecos_main/core/data/repositories/comments_data_service.dart';
import 'package:ecos_main/features/auth/lib/state/user_notifier.dart';
import 'package:ecos_main/core/state/comment_notifier.dart';
import 'package:ecos_main/core/state/extension_detail_notifier.dart';
import 'package:ecos_main/core/state/extension_notifier.dart';
import 'package:ecos_main/features/auth/lib/models/user_models.dart';
import 'package:ecos_main/core/data/models/extension_models.dart';

// Services
final _userServiceProvider = Provider<UserDataService>(
  (ref) => const UserDataService(),
);

final _extensionServiceProvider = Provider<ExtensionDataService>(
  (ref) => const ExtensionDataService(),
);

final _extensionDetailServiceProvider = Provider<ExtensionDetailDataService>(
  (ref) => const ExtensionDetailDataService(),
);

final _commentsServiceProvider = Provider<CommentDataService>(
  (ref) => const CommentDataService(),
);

// State notifiers

final userNotifierProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<List<User>>>(
  (ref) => UserNotifier(
    ref.read(_userServiceProvider),
  ),
);

final extensionNotifierProvider =
    StateNotifierProvider<ExtensionNotifier, AsyncValue<List<Extension>>>(
  (ref) => ExtensionNotifier(
    ref.read(_extensionServiceProvider),
  ),
);

final extensionDetailNotifierProvider = StateNotifierProvider.family<
    ExtensionDetailNotifier, AsyncValue<ExtensionDetail?>, String>(
  (ref, id) => ExtensionDetailNotifier(
    ref.read(_extensionDetailServiceProvider),
    id,
  ),
);

final commentNotifierProvider =
    StateNotifierProvider<CommentNotifier, AsyncValue<List<Comment>>>(
  (ref) => CommentNotifier(
    ref.read(_commentsServiceProvider),
  ),
);
