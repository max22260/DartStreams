import 'dart:async';
import 'Cake.dart';
import 'Order.dart';

void main() {
  // ! create stream controller
  final controller = StreamController();

  //? create order
  final order = Order(type: 'chocolate');

  //??? streamTransformer from handlers that handle sink

  final baker = StreamTransformer.fromHandlers(handleData: (cakeType, sink) {
    if (cakeType == 'chocolate') {
      sink.add(Cake());
    } else {
      sink.addError('error !! -> I can\'t bake that type of cake  !!! ');
    }
  });

  //* add order to stream  (order request)
  controller.sink.add(order);

  //! map and transform and listen to the event
  controller.stream.map((order) => order.type).transform(baker).listen(
      (cake) => print('heres your cake $cake'),
      onError: (error) => print(error));
}
