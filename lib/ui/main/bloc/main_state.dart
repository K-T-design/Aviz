part of 'main_bloc.dart';

class MainState extends Equatable {
  final NavItem navItem;

  const MainState({required this.navItem});

  MainState copyWith({NavItem? navItem}) {
    return MainState(
      navItem: navItem ?? this.navItem,
    );
  }

  factory MainState.initial() {
    return const MainState(navItem: NavItem.home);
  }

  @override
  List<Object> get props => [navItem];
}
