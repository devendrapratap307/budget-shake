import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/tab/tab_bloc.dart';
import '../../blocs/tab/tab_event.dart';
import '../../blocs/tab/tab_state.dart';

class ChatTab extends StatelessWidget {
  final int tabIndex;

  const ChatTab({required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    context.read<TabBloc>().add(LoadChatRooms(tabIndex));

    return BlocBuilder<TabBloc, TabState>(
      builder: (context, state) {
        if (state is TabLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TabLoaded) {
          return ListView.builder(
            itemCount: state.chatRooms.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.chatRooms[index]),
                onTap: () {
                  // Handle chat room selection
                  // Navigate to the chat room route
                  Navigator.pushNamed(
                    context,
                    '/chat-room',
                    arguments: {
                      'roomName': state.chatRooms[index], // Pass room name as an argument
                      'tabIndex': tabIndex,          // Pass the tab index as well
                    },
                  );
                },
              );
            },
          );
        } else if (state is TabError) {
          return Center(child: Text(state.message));
        }

        return const Center(child: Text('No content available'));
      },
    );
  }
}
