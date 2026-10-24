import 'package:flutter/material.dart';
import '../models/api_item.dart';
import '../models/department.dart';
import '../models/president.dart';
import '../models/typical_dish.dart';
import '../models/touristic_attraction.dart';

class EndpointConfig {
  final String key;
  final String title;
  final String path;
  final String description;
  final IconData icon;
  final ApiItem Function(Map<String, dynamic>) parser;

  const EndpointConfig({
    required this.key,
    required this.title,
    required this.path,
    required this.description,
    required this.icon,
    required this.parser,
  });
}

final List<EndpointConfig> endpoints = [
  EndpointConfig(
    key: 'department',
    title: 'Departamentos',
    path: 'Department',
    description: 'Departamentos de Colombia',
    icon: Icons.map,
    parser: Department.fromJson,
  ),
  EndpointConfig(
    key: 'president',
    title: 'Presidentes',
    path: 'President',
    description: 'Presidentes de Colombia',
    icon: Icons.account_balance,
    parser: President.fromJson,
  ),
  EndpointConfig(
    key: 'dish',
    title: 'Platos típicos',
    path: 'TypicalDish',
    description: 'Gastronomía colombiana',
    icon: Icons.restaurant,
    parser: TypicalDish.fromJson,
  ),
  EndpointConfig(
    key: 'attraction',
    title: 'Atractivos turísticos',
    path: 'TouristicAttraction',
    description: 'Lugares para visitar',
    icon: Icons.landscape,
    parser: TouristicAttraction.fromJson,
  ),
];

EndpointConfig? findEndpoint(String key) {
  for (final e in endpoints) {
    if (e.key == key) return e;
  }
  return null;
}