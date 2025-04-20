import 'package:aviz/ui/main/bloc/main_bloc.dart';

extension NavItemIndexExtension on int {
  NavItem get navItem => NavItem.values[this];
}
