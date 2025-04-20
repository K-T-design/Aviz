import 'package:aviz/data/repo/post/add_post_repo.dart';
import 'package:aviz/domain/models/category.dart';
import 'package:aviz/domain/models/post.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final AddPostRepo _addPostRepo;

  AddPostBloc(this._addPostRepo)
      : super(AddPostState.initial()) {
    on<GetInitialCategoriesEvent>((event, emit) async {
      emit(state.copyWith(
          getInitialCategoriesStatus: GetInitialCategoriesLoading()));

      final categoriesResult = await _addPostRepo.getCategories(0);

      categoriesResult.when(
        ok: (categories) {
          emit(state.copyWith(
            getInitialCategoriesStatus:
                GetInitialCategoriesSuccess(categories: categories),
          ));
        },
        error: (error) {
          emit(state.copyWith(
              getInitialCategoriesStatus: GetInitialCategoriesError()));
        },
      );
    });

    on<GetSubCategoriesEvent>((event, emit) async {
      emit(state.copyWith(getSubCategoriesStatus: GetSubCategoriesLoading()));

      final categoriesResult = await _addPostRepo.getCategories(event.parentId);

      categoriesResult.when(
        ok: (subCategories) {
          emit(state.copyWith(
            getSubCategoriesStatus:
                GetSubCategoriesSuccess(subCategories: subCategories),
          ));
        },
        error: (error) {
          emit(state.copyWith(getSubCategoriesStatus: GetSubCategoriesError()));
        },
      );
    });

    on<SendPostDataEvent>((event, emit) async {
      emit(state.copyWith(sendPostDataStatus: SendPostDataLoading()));
      emit(state.copyWith(
          post: state.post.copyWith(
        title: event.title,
        description: event.desc,
        price: event.price,
      )));

      final postResult =
          await _addPostRepo.addPost(state.post, state.selectedCategory!.id!);

      postResult.when(
        ok: (post) async {
          emit(state.copyWith(
              sendPostDataStatus: SendPostDataSuccess(post: post)));
          // Todo: Check the functionality: update the latest posts in home page
          // _postRepo.fetchLatestPosts(Pageable());
        },
        error: (error) {
          emit(state.copyWith(sendPostDataStatus: SendPostDataError()));
        },
      );
    });

    on<ChangeStepEvent>((event, emit) async {
      emit(state.copyWith(step: event.step));
    });

    on<SelectCategoryEvent>((event, emit) async {
      emit(state.copyWith(
          selectedCategory: event.category,
          post: state.post.copyWith(
            category: event.category,
          )));
    });

    on<ToggleHasElevatorEvent>((event, emit) async {
      emit(state.copyWith(
          post: state.post.copyWith(hasElevator: event.hasElevator)));
    });

    on<ToggleHasParkingEvent>((event, emit) async {
      emit(state.copyWith(
          post: state.post.copyWith(hasParking: event.hasParking)));
    });

    on<ToggleHasBasementEvent>((event, emit) async {
      emit(state.copyWith(
          post: state.post.copyWith(hasBasement: event.hasBasement)));
    });

    on<FillPostInfoEvent>((event, emit) async {
      emit(state.copyWith(
        post: state.post.copyWith(
          area: event.area,
          numOfRooms: event.numOfRooms,
          floor: event.floor,
          builtYear: event.builtYear,
          address: event.address,
        ),
      ));
    });

    on<ToggleChatAvailableEvent>((event, emit) async {
      emit(state.copyWith(
          post: state.post.copyWith(chatAvailable: event.chatAvailable)));
    });

    on<ToggleCallAvailableEvent>((event, emit) async {
      emit(state.copyWith(
          post: state.post.copyWith(callAvailable: event.callAvailable)));
    });

    on<SetLatLongEvent>((event, emit) async {
      emit(state.copyWith(
        post: state.post.copyWith(
          latitude: event.geoPoint.latitude,
          longitude: event.geoPoint.longitude,
        ),
      ));
    });

    on<SetInitialStateEvent>((event, emit) async {
      final getInitialCategoriesStatus = state.getInitialCategoriesStatus;
      emit(AddPostState.initial().copyWith(
        getInitialCategoriesStatus: getInitialCategoriesStatus,
      ));
    });
  }
}
