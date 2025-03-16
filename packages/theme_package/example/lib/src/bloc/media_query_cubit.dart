import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaQueryCubit extends Cubit<MediaQueryData?> {
  MediaQueryCubit() : super(null);

  void refresh(BuildContext context) => emit(MediaQuery.of(context));
}
