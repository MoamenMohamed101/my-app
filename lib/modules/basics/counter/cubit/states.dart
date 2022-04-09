abstract class Counterstates {}
class Initstates extends Counterstates{}
class Plusstates extends Counterstates{
  var plus;
  Plusstates({this.plus});
}
class Minusstates extends Counterstates{
  var minus;
  Minusstates({this.minus});
}