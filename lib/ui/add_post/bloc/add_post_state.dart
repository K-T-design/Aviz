part of 'add_post_bloc.dart';

class AddPostState extends Equatable {
  final int step;
  final Category? selectedCategory;
  final Post post;

  // Status
  final GetInitialCategoriesStatus getInitialCategoriesStatus;
  final GetSubCategoriesStatus getSubCategoriesStatus;
  final SendPostDataStatus sendPostDataStatus;

  const AddPostState({
    required this.step,
    required this.selectedCategory,
    required this.post,
    required this.getInitialCategoriesStatus,
    required this.getSubCategoriesStatus,
    required this.sendPostDataStatus,
  });

  factory AddPostState.initial() {
    return AddPostState(
      step: 1,
      selectedCategory: null,
      post: Post(
        chatAvailable: true,
        callAvailable: false,
        hasElevator: true,
        hasParking: true,
        hasBasement: true,
      ),
      getInitialCategoriesStatus: GetInitialCategoriesInitial(),
      getSubCategoriesStatus: GetSubCategoriesInitial(),
      sendPostDataStatus: SendPostDataInitial(),
    );
  }

  AddPostState copyWith({
    int? step,
    Category? selectedCategory,
    Post? post,
    GetInitialCategoriesStatus? getInitialCategoriesStatus,
    GetSubCategoriesStatus? getSubCategoriesStatus,
    SendPostDataStatus? sendPostDataStatus,
  }) {
    return AddPostState(
      step: step ?? this.step,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      post: post ?? this.post,
      getInitialCategoriesStatus:
          getInitialCategoriesStatus ?? this.getInitialCategoriesStatus,
      getSubCategoriesStatus:
          getSubCategoriesStatus ?? this.getSubCategoriesStatus,
      sendPostDataStatus: sendPostDataStatus ?? this.sendPostDataStatus,
    );
  }

  @override
  List<Object?> get props => [
        step,
        selectedCategory,
        post,
        getInitialCategoriesStatus,
        getSubCategoriesStatus,
        sendPostDataStatus,
      ];
}

// GetInitialCategoriesEvent
sealed class GetInitialCategoriesStatus extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GetInitialCategoriesInitial extends GetInitialCategoriesStatus {}

final class GetInitialCategoriesLoading extends GetInitialCategoriesStatus {}

final class GetInitialCategoriesSuccess extends GetInitialCategoriesStatus {
  final List<Category> categories;

  GetInitialCategoriesSuccess({
    required this.categories,
  });

  @override
  List<Object?> get props => [categories];
}

final class GetInitialCategoriesError extends GetInitialCategoriesStatus {}

// GetSubCategoriesEvent
sealed class GetSubCategoriesStatus extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GetSubCategoriesInitial extends GetSubCategoriesStatus {}

final class GetSubCategoriesLoading extends GetSubCategoriesStatus {}

final class GetSubCategoriesSuccess extends GetSubCategoriesStatus {
  final List<Category> subCategories;

  GetSubCategoriesSuccess({
    required this.subCategories,
  });

  @override
  List<Object?> get props => [subCategories];
}

final class GetSubCategoriesError extends GetSubCategoriesStatus {}

// SendPostDataEvent
sealed class SendPostDataStatus extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SendPostDataInitial extends SendPostDataStatus {}

final class SendPostDataLoading extends SendPostDataStatus {}

final class SendPostDataSuccess extends SendPostDataStatus {
  final Post post;

  SendPostDataSuccess({required this.post});
}

final class SendPostDataError extends SendPostDataStatus {}
