class Booking {
  final String id;
  final String projectId;
  final String projectTitle;
  final String clientId;
  final String clientName;
  final String developerId;
  final String developerName;
  final String description;
  final String status; // pending, accepted, rejected, completed
  final DateTime createdAt;
  final DateTime? completedAt;
  final String budget;
  final String deadline;

  Booking({
    required this.id,
    required this.projectId,
    required this.projectTitle,
    required this.clientId,
    required this.clientName,
    required this.developerId,
    required this.developerName,
    required this.description,
    required this.status,
    required this.createdAt,
    this.completedAt,
    required this.budget,
    required this.deadline,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] ?? '',
      projectId: json['projectId'] ?? '',
      projectTitle: json['projectTitle'] ?? '',
      clientId: json['clientId'] ?? '',
      clientName: json['clientName'] ?? '',
      developerId: json['developerId'] ?? '',
      developerName: json['developerName'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 'pending',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
      budget: json['budget'] ?? '',
      deadline: json['deadline'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'projectTitle': projectTitle,
      'clientId': clientId,
      'clientName': clientName,
      'developerId': developerId,
      'developerName': developerName,
      'description': description,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'budget': budget,
      'deadline': deadline,
    };
  }
}
