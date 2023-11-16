import 'package:get/get.dart';

// Controller for the home view
class HomeController extends GetxController {
  // Dropdown items for the academic year selection
  List<String> dropDownItems = ['2023-2024', '2024-2025'];
  // Selected academic year
  String? selectedValue;
  // Selected class and section combination
  String? selectedClassAndSection;
  // Default selected values for class and section dropdowns
  String selectedLeftValue = 'Play School';
  String selectedRightValue = 'Section A';
  // State for tracking whether class and section are selected
  RxBool? isSelectedClassAndSection = false.obs;
  // Variables to store the selected class and section
  String classes = "";
  String section = "";

  // List of classes and sections for dropdowns
  List<String> leftList = [
    'Play School',
    'KG',
    'Class 1',
    'Class 2',
    'Class 3',
    'Class 4',
    'Class 5'
  ];
  List<String> rightList = [
    'Section A',
    'Section B',
    'Section C',
    'Section D',
    'Section E',
    'Section F',
    'Section G'
  ];

  // List of available values (not used in the provided code)
  List<String>? values;

  // Sample timetable data
  Map<String, dynamic> timetableData = {
    "periods": 4,
    "timetable": [
      {
        "period": 1,
        "startTime": 540,
        "subject": "Math",
        "staff": "Mr. Johnson"
      },
      {"break": "Morning Break", "startTime": 660, "endTime": 690},
      {
        "period": 2,
        "startTime": 720,
        "subject": "English",
        "staff": "Ms. Smith"
      },
      {"break": "Lunch Break", "startTime": 840, "endTime": 900},
      {
        "period": 3,
        "startTime": 930,
        "subject": "Science",
        "staff": "Dr. Davis"
      },
      {"break": "Afternoon Break", "startTime": 1050, "endTime": 1080},
      {
        "period": 4,
        "startTime": 1110,
        "subject": "History",
        "staff": "Mrs. Brown"
      }
    ]
  };

  // Function to format time from minutes
  String getTime(int minutes) {
    int hour = minutes ~/ 60;
    int minute = minutes % 60;
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  // Function to get a description for periods and breaks
  String getPeriodDescription(Map<String, dynamic> entry) {
    if (entry.containsKey("period")) {
      return '${entry["period"]} Period';
    } else if (entry.containsKey("break")) {
      return '${entry["break"]} Break';
    } else {
      return '';
    }
  }

  @override
  void onInit() {
    // Set the initial selected value for the academic year dropdown
    selectedValue = dropDownItems.first;
    super.onInit();
  }

  // Function to handle changes in the academic year dropdown
  void changeDropdownValue(value) {
    selectedValue = value;
    update();
  }

  // Function to handle changes in the class dropdown
  void changeClassAndSectionValue(newValue) {
    selectedLeftValue = newValue;
    update();
  }

  // Function to handle changes in the section dropdown
  void changeSection(value) {
    selectedRightValue = value!;
    update();
  }
}
