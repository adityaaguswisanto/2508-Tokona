import 'package:tokona/packages/packages.dart';

class Droppables {
  static EventTransformer<E> throttle<E>({
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return (events, mapper) {
      return droppable<E>().call(events.throttle(duration), mapper);
    };
  }
}
