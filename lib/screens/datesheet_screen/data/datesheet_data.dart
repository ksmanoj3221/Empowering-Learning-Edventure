class DataSheet {
  final int date;
  final String monthName;
  final String subjectName;
  final String dayName;
  final String time;

  DataSheet(
      this.date, this.monthName, this.subjectName, this.dayName, this.time);
}

List<DataSheet> dateSheet = [
  DataSheet(11, 'MAR', 'Hindi', 'Monday', '9:00am'),
  DataSheet(12, 'MAR', 'English', 'Tuesday', '10:00am'),
  DataSheet(13, 'MAR', 'Mathematics', 'Wednesday', '9:30am'),
  DataSheet(14, 'MAR', 'Marathi', 'Thursday', '11:00am'),
];