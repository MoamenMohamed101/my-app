abstract class NewsStates {}

class InitialStates extends NewsStates {}

class ChangeBottomNavStates extends NewsStates {}

class Newgetbusinessloading extends NewsStates {}

class Newgetbusinesssuceere extends NewsStates {}

class Newgetbusinesserror extends NewsStates {
  var error;
  Newgetbusinesserror({this.error});
}

class NewgetSportsloading extends NewsStates {}

class NewgetSportssuceere extends NewsStates {}

class NewgetSportserror extends NewsStates {
  var error;
  NewgetSportserror({this.error});
}

class NewgetScienceloading extends NewsStates {}

class NewgetSciencesuceere extends NewsStates {}

class NewgetScienceerror extends NewsStates {
  var error;
  NewgetScienceerror({this.error});
}

class NewgetSearcheloading extends NewsStates {}

class NewgetSearchesuceere extends NewsStates {}

class NewgetSearcheerror extends NewsStates {
  var error;
  NewgetSearcheerror({this.error});
}