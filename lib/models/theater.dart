part of 'models.dart';

class Theater extends Equatable {
  final String name;

  const Theater(this.name);

  @override
  List<Object> get props => [name];
}

List<Theater> dummyTheaters = [
  const Theater("XXI Cihampelas Walk"),
  const Theater("XXI Bandung Trade Center"),
  const Theater("XXI CSB Cirebon")
];
