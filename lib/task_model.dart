class TaskModel {
  int? id;
  String title;
  String date;
  bool isCompleted;
  TaskModel({
    this.id,
    required this.title,
    required this.date,
    this.isCompleted = false,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] is int ? map['id'] : null,
      title: map['title'],
      date: map['date'],
      isCompleted: map['isCompleted'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }
}
