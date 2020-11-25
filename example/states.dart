import 'package:xstate_playground/xstate.dart';

import 'events.dart';

class Pending extends State {
  @override
  String key = 'pending';

  @override
  State on(Event event) {
    if (event is RejectEvent) {
      return Rejected();
    }
    if (event is ResolveEvent) {
      return Resolved();
    } else {
      return this;
    }
  }
}

class Resolved extends State {
  @override
  String key = 'resolved';

  @override
  State on(Event event) {
    return this;
  }
}

class Rejected extends State {
  @override
  String key = 'rejected';

  @override
  State on(Event event) {
    return this;
  }
}
