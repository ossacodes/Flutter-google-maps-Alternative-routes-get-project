import 'package:flutter/material.dart';

class RouteData {
  final String routeName;
  final String routeDescription;
  final String routeDistance;
  final Color color;

  final String distance;
  final String turn;
  final dynamic route;

  RouteData({
    required this.routeName,
    required this.routeDescription,
    required this.routeDistance,
    required this.color,
    required this.distance,
    required this.turn,
    required this.route,
  });
}
