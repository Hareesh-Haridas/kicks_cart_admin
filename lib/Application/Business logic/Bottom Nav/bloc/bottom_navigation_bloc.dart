import 'dart:async';


import 'package:bloc/bloc.dart';


import 'package:meta/meta.dart';


part 'bottom_navigation_event.dart';


part 'bottom_navigation_state.dart';


class BottomNavigationBloc

    extends Bloc<BottomNavigationEvent, BottomNavigationState> {

  BottomNavigationBloc() : super(BottomNavigationInitial()) {

    on<IndexChangerEvent>(indexChangerEvent);

  }


  FutureOr<void> indexChangerEvent(

      IndexChangerEvent event, Emitter<BottomNavigationState> emit) {

    emit(BottomNavigationState(index: event.index));

  }

}

