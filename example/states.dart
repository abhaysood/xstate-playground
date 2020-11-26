import 'package:xstate_playground/xstate.dart';

import 'events.dart';

class Pending extends State {
  @override
  String key = 'pending';

  @override
  String on(Event event) {
    if (event is RejectEvent) {
      return 'rejected';
    } else if (event is ResolveEvent) {
      return 'resolved';
    } else {
      return key;
    }
  }
}

class Resolved extends State {
  @override
  String key = 'resolved';

  @override
  String on(Event event) {
    return key;
  }
}

class Rejected extends State {
  @override
  String key = 'rejected';

  @override
  String on(Event event) {
    if (event is RetryEvent) {
      return 'pending';
    } else {
      return key;
    }
  }
}
