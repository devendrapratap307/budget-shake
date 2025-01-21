abstract class TabState {}

class TabInitial extends TabState {}

class TabLoaded extends TabState {
  final List<String> chatRooms;

  TabLoaded(this.chatRooms);
}

class TabLoading extends TabState {}

class TabError extends TabState {
  final String message;

  TabError(this.message);
}

