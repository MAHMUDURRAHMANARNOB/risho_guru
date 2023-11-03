import 'package:bloc/bloc.dart';

enum NavigationEvent {
  navigateToWelcome,
  navigateToLogin,
  navigateToRegistration,
  navigateToCourses,
  navigateToStudySection,
  navigateToPackages,
  navigateToCalendar,
  navigateToTools,
}

class NavigationBloc extends Bloc<NavigationEvent, NavigationEvent> {
  NavigationBloc() : super(NavigationEvent.navigateToWelcome);

  @override
  Stream<NavigationEvent> mapEventToState(NavigationEvent event) async* {
    yield event;
  }
}
