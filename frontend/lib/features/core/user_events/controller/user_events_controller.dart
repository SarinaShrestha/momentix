import 'package:flutter/material.dart';
import 'package:frontend/repository/authentication_repository/event_repository/user_events_repositry.dart';

class UserEventsController extends ChangeNotifier {
  final UserEventsRepository _eventsRepository = UserEventsRepository();
  List<Map<String, dynamic>> _events = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Map<String, dynamic>> get events => _events;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadUserEvents() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _events = await _eventsRepository.fetchUserEvents();
    } catch (e) {
      _errorMessage = "Error loading events";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
