part of 'add_post_bloc.dart';

sealed class AddPostEvent {}

final class GetInitialCategoriesEvent extends AddPostEvent {}

final class GetSubCategoriesEvent extends AddPostEvent {
  final int parentId;

  GetSubCategoriesEvent({required this.parentId});
}

final class SendPostDataEvent extends AddPostEvent {
  final String title;
  final String desc;
  final num price;

  SendPostDataEvent({
    required this.title,
    required this.desc,
    required this.price,
  });
}

final class ChangeStepEvent extends AddPostEvent {
  final int step;

  ChangeStepEvent(this.step);
}

final class SelectCategoryEvent extends AddPostEvent {
  final Category category;

  SelectCategoryEvent({required this.category});
}

final class ToggleHasElevatorEvent extends AddPostEvent {
  final bool hasElevator;

  ToggleHasElevatorEvent(this.hasElevator);
}

final class ToggleHasParkingEvent extends AddPostEvent {
  final bool hasParking;

  ToggleHasParkingEvent(this.hasParking);
}

final class ToggleHasBasementEvent extends AddPostEvent {
  final bool hasBasement;

  ToggleHasBasementEvent(this.hasBasement);
}

final class FillPostInfoEvent extends AddPostEvent {
  final double area;
  final double numOfRooms;
  final double floor;
  final int builtYear;
  final String address;

  FillPostInfoEvent({
    required this.area,
    required this.numOfRooms,
    required this.floor,
    required this.builtYear,
    required this.address,
  });
}

final class ToggleChatAvailableEvent extends AddPostEvent {
  final bool chatAvailable;

  ToggleChatAvailableEvent(this.chatAvailable);
}

final class ToggleCallAvailableEvent extends AddPostEvent {
  final bool callAvailable;

  ToggleCallAvailableEvent(this.callAvailable);
}

final class SetLatLongEvent extends AddPostEvent {
  final GeoPoint geoPoint;

  SetLatLongEvent({required this.geoPoint});
}

final class SetInitialStateEvent extends AddPostEvent {}
