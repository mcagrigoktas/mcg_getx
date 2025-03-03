import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../get_rx/src/rx_types/rx_types.dart';

typedef WidgetCallback = Widget Function();

/// The [ObxWidget] is the base for all GetX reactive widgets
///
/// See also:
/// - [Obx]
/// - [ObxValue]
abstract class ObxWidget extends StatefulWidget {
  const ObxWidget({Key? key}) : super(key: key);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<Function>.has('builder', build));
  }

  @override
  ObxState createState() => ObxState();

  @protected
  Widget build();
}

class ObxState extends State<ObxWidget> {
  final _observer = RxNotifier();
  late StreamSubscription subs;

  @override
  void initState() {
    super.initState();
    subs = _observer.listen(_updateTree, cancelOnError: false);
  }

  void _updateTree(_) {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    subs.cancel();
    _observer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => RxInterface.notifyChildren(_observer, widget.build);
}

/// The simplest reactive widget in GetX.
///
/// Just pass your Rx variable in the root scope of the callback to have it
/// automatically registered for changes.
///
/// final _name = "GetX".obs;
/// Obx(() => Text( _name.value )),... ;
class Obx extends ObxWidget {
  final WidgetCallback builder;

  const Obx(this.builder, {Key? key}) : super(key: key);

  @override
  Widget build() => builder();
}

/// Obx dinlenecek degisken icinde kullanilmadiginda hata veriyordu. Baska cozumu barsa bak
/// Obx widgeti icinde kullan
ObxListen(dynamic value, [dynamic value2, dynamic valu3]) {}

///Obx gibi fakat bi rxbool degiskeni verdiginde o degisken kullanilmasa bile widget yenilenir
class Oby<T extends RxBool> extends StatelessWidget {
  final WidgetCallback builder;
  final T data;
  const Oby(this.builder, this.data);

  @override
  Widget build(_) {
    return Obx(() {
      ObxListen(data.value);
      return builder();
    });
  }
}

/// Similar to Obx, but manages a local state.
/// Pass the initial data in constructor.
/// Useful for simple local states, like toggles, visibility, themes,
/// button states, etc.
///  Sample:
///    ObxValue((data) => Switch(
///      value: data.value,
///      onChanged: (flag) => data.value = flag,
///    ),
///    false.obs,
///   ),
class ObxValue<T extends RxInterface> extends ObxWidget {
  final Widget Function(T) builder;
  final T data;

  const ObxValue(this.builder, this.data, {Key? key}) : super(key: key);

  @override
  Widget build() => builder(data);
}
