class APIResponse {
  final bool isRequestSuccess;
  final dynamic data;
  final String? error;
  final bool hasPagination;
  final int? currentPage;
  final String? prevPage;
  final String? nextPage;

  APIResponse({
    required this.isRequestSuccess,
    this.data,
    this.error,
    this.hasPagination = false,
    this.currentPage,
    this.prevPage,
    this.nextPage,
  });
}
