import 'package:xstate_playground/xstate.dart';

class RejectedAction extends Action {
  @override
  String type = 'rejected';

  @override
  void exec(Context context, Event event) {
    print('[Action] type:$type, trigger:${event.value}');
  }
}

class ResolvedAction extends Action {
  @override
  String type = 'resolved';

  @override
  void exec(Context context, Event event) {
    print('[Action] type:$type, trigger:${event.value}');
  }
}

class ResultAction extends Action {
  @override
  String type = 'result';

  @override
  void exec(Context context, Event event) {
    print('[Action] type:$type, trigger:${event.value}');
  }
}

class ReopenedAction extends Action {
  @override
  String type = 'reopen';

  @override
  void exec(Context context, Event event) {
    print('[Action] type:$type, trigger:${event.value}');
  }
}
