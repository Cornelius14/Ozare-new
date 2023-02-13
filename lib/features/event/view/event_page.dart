import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/features/event/bloc/event_bloc.dart';
import 'package:ozare/features/event/view/event_view.dart';
import 'package:ozare/models/models.dart';

class EventPage extends StatelessWidget {
  const EventPage({
    super.key,
    required this.leagueId,
    required this.event,
  });

  final String? leagueId;
  final Event event;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventBloc, EventState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return EventView(
          event: event,
          leagueId: leagueId,
        );
      },
    );
  }
}
