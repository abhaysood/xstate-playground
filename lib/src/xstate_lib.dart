class Machine {
  String id;
  String initialStateKey;
  Map<String, State> states;

  State transition(String stateKey, Event event) {
    return states[stateKey].on(event);
  }
}

abstract class State {
  String key;

  State on(Event event);
}

abstract class Event {
  String value;
  Map<String, Object> meta;
}

class Interpreter {
  final Machine _machine;
  final List<Function> _transitionCallbacks = [];
  State _currentState;

  Interpreter(this._machine);

  void start() {
    _currentState = _machine.states[_machine.initialStateKey];
  }

  void send(Event event) {
    final newState = _machine.states[_currentState.key].on(event);
    invokeCallbacks(newState);
    _currentState = newState;
  }

  void stop() {
    _currentState = _machine.states[_machine.initialStateKey];
    _transitionCallbacks.clear();
  }

  void onTransition(Function(State) callback) {
    _transitionCallbacks.add(callback);
  }

  void invokeCallbacks(State newState) {
    _transitionCallbacks.forEach((element) {
      element.call(newState);
    });
  }
}
