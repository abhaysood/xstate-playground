import 'package:xstate_playground/xstate.dart';

import 'events.dart';
import 'states.dart';

void main() async {
  final machine = Machine()
    ..id = 'ticket'
    ..initialStateKey = 'pending'
    ..states = {
      'pending': Pending(),
      'resolved': Resolved(),
      'rejected': Rejected(),
    };

  final service = Interpreter(machine)
    ..onTransition((state) => print(state.key));

  service.start();

  service.send(RejectEvent());

  service.stop();
}
