import 'package:xstate_playground/xstate.dart';

import 'actions.dart';
import 'events.dart';
import 'states.dart';

void main() async {
  final machine = Machine()
    ..id = 'ticket'
    ..initialStateKey = 'pending'
    ..states = {
      'pending': Pending()
        ..events = [RejectEvent(), ResolveEvent()]
        ..exit = [ResultAction()],
      'resolved': Resolved()..entry = [ResolvedAction()],
      'rejected': Rejected()
        ..events = [RetryEvent()]
        ..exit = [ReopenedAction()]
        ..entry = [RejectedAction()],
    };

  final service = Interpreter(machine)
    ..onTransition((state) => print('[Main]: Transitioned to state: ${state.key}'));

  service.start();

  service.send(RejectEvent());
  service.send(RetryEvent());

  service.stop();
}
