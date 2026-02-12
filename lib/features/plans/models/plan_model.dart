import 'package:cloud_firestore/cloud_firestore.dart';

class PlanModel {
  final String planId;
  final String creatorId;
  final String destinationName;
  final GeoPoint location;
  final DateTime time;
  final String description;
  final bool isOpen;
  final List<String> participants;

  PlanModel({
    required this.planId,
    required this.creatorId,
    required this.destinationName,
    required this.location,
    required this.time,
    required this.description,
    required this.isOpen,
    required this.participants,
  });

  Map<String, dynamic> toMap() {
    return {
      'planId': planId,
      'creatorId': creatorId,
      'destinationName': destinationName,
      'location': location,
      'time': Timestamp.fromDate(time),
      'description': description,
      'isOpen': isOpen,
      'participants': participants,
    };
  }

  factory PlanModel.fromMap(Map<String, dynamic> map) {
    return PlanModel(
      planId: map['planId'] ?? '',
      creatorId: map['creatorId'] ?? '',
      destinationName: map['destinationName'] ?? '',
      location: map['location'] ?? const GeoPoint(0, 0),
      time: (map['time'] as Timestamp).toDate(),
      description: map['description'] ?? '',
      isOpen: map['isOpen'] ?? false,
      participants: List<String>.from(map['participants'] ?? []),
    );
  }
}
