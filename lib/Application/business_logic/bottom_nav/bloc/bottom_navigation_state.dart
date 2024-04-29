part of 'bottom_navigation_bloc.dart';

@immutable
class BottomNavigationState {
  final int index;

  const BottomNavigationState({required this.index});
}

final class BottomNavigationInitial extends BottomNavigationState {
  const BottomNavigationInitial() : super(index: 0);
}
