import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';  //视图渲染初始化
import 'package:flutter/gestures.dart'; //手势的初始化
import 'dart:async';

/**
 * ui适配
 */
const double SCREEN_WIDTH = 414;
class InnerWidgetsFlutterBinding  extends WidgetsFlutterBinding {


  double get adapterRatio {
    return ui.window.physicalSize.width / SCREEN_WIDTH;
  }

  static WidgetsBinding ensureInitialized() {
    if (WidgetsBinding.instance == null) InnerWidgetsFlutterBinding();
    return WidgetsBinding.instance;
  }


  @override
  ViewConfiguration createViewConfiguration() {
    return ViewConfiguration(
      size: window.physicalSize / adapterRatio,
      devicePixelRatio: adapterRatio,
    );
  }

  @override
  void initInstances() {
    super.initInstances();
    ui.window.onPointerDataPacket = _handlePointerDataPacket;
  }

  final Queue<PointerEvent> _pendingPointerEvents = Queue<PointerEvent>();
  void _handlePointerDataPacket(ui.PointerDataPacket packet) {
    _pendingPointerEvents.addAll(PointerEventConverter.expand(
        packet.data,
        // 适配事件的转换比率,采用我们修改的
        adapterRatio));
    if (!locked) _flushPointerEventQueue();
  }

  void _flushPointerEventQueue() {
    assert(!locked);
    while (_pendingPointerEvents.isNotEmpty)
      _handlePointerEvent(_pendingPointerEvents.removeFirst());
  }

  final Map<int, HitTestResult> _hitTests = <int, HitTestResult>{};
  void _handlePointerEvent(PointerEvent event) {
    assert(!locked);
    HitTestResult result;
    if (event is PointerDownEvent) {
      assert(!_hitTests.containsKey(event.pointer));
      result = HitTestResult();
      hitTest(result, event.position);
      _hitTests[event.pointer] = result;
      assert(() {
        if (debugPrintHitTestResults) debugPrint('$event: $result');
        return true;
      }());
    } else if (event is PointerUpEvent || event is PointerCancelEvent) {
      result = _hitTests.remove(event.pointer);
    } else if (event.down) {
      result = _hitTests[event.pointer];
    } else {
      return; // We currently ignore add, remove, and hover move events.
    }
    if (result != null) dispatchEvent(event, result);
  }

  @override
  void cancelPointer(int pointer) {
    if (_pendingPointerEvents.isEmpty && !locked)
      scheduleMicrotask(_flushPointerEventQueue);
    _pendingPointerEvents.addFirst(PointerCancelEvent(pointer: pointer));
  }

  @override
  void unlocked() {
    super.unlocked();
    _flushPointerEventQueue();
  }
}