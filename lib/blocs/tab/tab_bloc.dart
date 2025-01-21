import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outlayshake/blocs/tab/tab_event.dart';
import 'package:outlayshake/blocs/tab/tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabInitial()) {
    on<LoadChatRooms>(_onLoadChatRooms);
  }

  // Handler for LoadChatRooms event
  Future<void> _onLoadChatRooms(LoadChatRooms event, Emitter<TabState> emit) async {
    emit(TabLoading());
    try {
      await Future.delayed(Duration(seconds: 1)); // Simulate loading
      if (event.tabIndex == 0) {
        emit(TabLoaded(["Room 1", "Room 2", "Room 3"]));
      } else if (event.tabIndex == 1) {
        emit(TabLoaded(["Group A", "Group B", "Group C"]));
      } else if (event.tabIndex == 2) {
        emit(TabLoaded(["Self Outlay 1", "Self Outlay 2"]));
      }
    } catch (e) {
      emit(TabError("Failed to load data"));
    }
  }
}
