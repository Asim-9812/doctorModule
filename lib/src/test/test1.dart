import 'package:flutter/material.dart';

class Snake {
  List<Offset> _body = [];
  Offset _direction = Offset(1, 0);

  void move() {
    Offset newHead = _body.last + _direction;
    _body.add(newHead);
    _body.removeAt(0);
  }

  List<Offset> get body => _body;
  Offset get direction => _direction;

  void setDirection(Offset direction) {
    _direction = direction;
  }
}
