abstract class TabEvent {}

class LoadChatRooms extends TabEvent {
  final int tabIndex;

  LoadChatRooms(this.tabIndex);
}

