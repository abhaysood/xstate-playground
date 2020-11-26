class Machine {
  String id;
  String initialStateKey;
  Map<String, State> states;
  Context context;

  String transition(String stateKey, Event event) {
    final state = states[stateKey];
    if (state.events.contains(event.value)) {
      return state.on(event);
    }
    return state.key;
  }
}

abstract class State {
  String key;
  List<Action> entry = [];
  List<Action> exit = [];
  List<Event> events = [];

  String on(Event event);
}

abstract class Event {
  String value;
  Map<String, Object> meta;

// TODO: Implement actions
}

///  The interpreter is responsible for interpreting the state
///  machine/statechart and doing all of the below - that is, parsing and
///  executing it in a runtime environment. An interpreted, running instance
///  of a statechart is called a service.
///
///  - Keep track of the current state, and persist it
///  - Execute side-effects
///  - Handle delayed transitions and events
///  - Communicate with external services
class Interpreter {
  final Machine _machine;
  final List<Function> _transitionCallbacks = [];
  State _currentState;

  Interpreter(this._machine);

  void start() {
    _currentState = _machine.states[_machine.initialStateKey];
    print('Starting machine in state: ${_currentState.key}');
  }

  void send(Event event) {
    print('[Interpreter]: processing event: ${event.value}');
    _currentState.exit.forEach((action) {
      action.exec.call(
        _machine.context,
        event,
      );
    });
    final newState =
        _machine.states[_machine.transition(_currentState.key, event)];
    invokeTransitionCallbacks(newState);
    _currentState = newState;
    _currentState.entry.forEach((action) {
      action.exec.call(_machine.context, event);
    });
  }

  // TODO: Implement batched events
  void sendBatch(List<Event> event) {}

  void stop() {
    _currentState = _machine.states[_machine.initialStateKey];
    _transitionCallbacks.clear();
  }

  void onTransition(Function(State) callback) {
    _transitionCallbacks.add(callback);
  }

  void invokeTransitionCallbacks(State newState) {
    _transitionCallbacks.forEach((callback) {
      callback.call(newState);
    });
  }
}

/// Actions are fire-and-forget "side effects"
abstract class Action {
  /// The action type
  String type;

  /// The action implementation function
  /// Context: The current machine context
  /// Event: The event that caused the transition
  /// TODO: Implement ActionMeta — An object containing meta data about the action (see below)
  void exec(Context context, Event event);
}

abstract class Context {}

abstract class ActionMeta {
  /// The original action object
  Action action;

  /// The resolved machine state, after transition
  State state;
}
