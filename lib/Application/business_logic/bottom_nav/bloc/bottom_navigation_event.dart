part of 'bottom_navigation_bloc.dart';


@immutable

sealed class BottomNavigationEvent {}


class IndexChangerEvent extends BottomNavigationEvent {

  final int index;
  IndexChangerEvent({required this.index});
}

