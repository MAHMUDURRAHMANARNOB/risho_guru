import 'package:flutter/material.dart';

class Destination {
  const Destination(this.icon, this.label);
  final IconData icon;
  final String label;
}

const List<Destination> destinations = <Destination>[
  Destination(Icons.inbox_rounded, 'Courses'),
  Destination(Icons.article_outlined, 'StudyBoard'),
  Destination(Icons.messenger_outline_rounded, 'HomeWork'),
  Destination(Icons.messenger_outline_rounded, 'Calender'),
  Destination(Icons.group_outlined, 'Packages'),
];
