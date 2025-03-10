import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecos_main/repositories/user_data_service.dart';
import 'package:ecos_main/repositories/extension_data_service.dart';
import 'package:ecos_main/repositories/extension_detail_data_service.dart';
import 'package:ecos_main/repositories/comments_data_service.dart';
import 'package:ecos_main/providers/user_notifier.dart';
import 'package:ecos_main/providers/comment_notifier.dart';
import 'package:ecos_main/providers/extension_detail_notifier.dart';
import 'package:ecos_main/providers/extension_notifier.dart';
import 'package:ecos_main/common/models/user_models.dart';
import 'package:ecos_main/common/models/extension_models.dart';

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
