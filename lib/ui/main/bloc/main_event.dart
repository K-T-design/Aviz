part of 'main_bloc.dart';

enum NavItem { home, search, add, profile }

sealed class MainEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ChangeNavItem extends MainEvent {
  final NavItem navItem;

  ChangeNavItem({required this.navItem});

  @override
  List<Object?> get props => [navItem];
}
