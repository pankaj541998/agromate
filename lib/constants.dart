// ignore_for_file: prefer_interpolation_to_compose_strings
enum Roles {
  Admin,
  Landholder,
  Agronomist,
  Manager,
  Farmer,
}

class ApiConstant {
  static const String base = "https://agromate.website/laravel/api/";
  static const String registerAPI = base + 'stt';
  static const String addStock = base + 'stockmanager';
  static const String updateStock = base + 'update/stockmanager';
  static const String deleteStock = base + 'delete/stockmanager';
  static const String addClass = base + 'class';
  static const String deleteClass = base + 'delete/class';
  static const String testAPI = base + 'test';

  static const String modeAPI = base + 'mode'; //add new mode of application
  static const String modeDeleteAPI =
      base + 'delete/{id}/mode'; //delete mode of application

  static const String addProgramAPI = base + 'program'; //add new crop program
  static const String editProgramAPI = base + 'update/program';
  static const String addProgramTasksAPI = base + 'programtask'; //add new task
  static const String editProgramTasksAPI = base + 'update/programtask';

  //users table
  static const String getUserList = base + 'userlist'; //get
  static const String addUserAPI = base + 'newuser'; //post

  //mapbox
  static const String getFarm = base + 'get/farm';
  static const String addFarm = base + 'farm';
  static const String updateFarm = base + 'update/farm';

  static const String profileUpdateAPI = base + 'update_user';
}
