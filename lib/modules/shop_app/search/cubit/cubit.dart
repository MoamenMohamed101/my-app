import 'package:first_app/layout/shop_app/cubit/states.dart';
import 'package:first_app/models/shop_app/search_model.dart';
import 'package:first_app/modules/shop_app/search/cubit/states.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/network/end_points.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit(SearchStates initialState) : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;
  void search(var text) {
    emit(SearchLoadingState());
    Diohelper.postdata(url: Search, data: {'text': text} , token: token)!.then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSucsessState());
    }).catchError((onError) {
      print(onError);
      emit(SearchErrorState());
    });
  }
}
