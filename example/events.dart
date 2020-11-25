import 'package:xstate_playground/xstate.dart';

class RejectEvent extends Event {
  @override
  String value = 'REJECT';
}

class ResolveEvent extends Event {
  @override
  String value = 'RESOLVE';
}
