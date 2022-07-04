abstract class NationalityPredictingEvent {}

class FetchNationalityPredictingEvent extends NationalityPredictingEvent{
  final String name;

  FetchNationalityPredictingEvent({required this.name});
}

