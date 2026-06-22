import 'package:flutter/material.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class ChangeThemeState extends SettingsState {}
