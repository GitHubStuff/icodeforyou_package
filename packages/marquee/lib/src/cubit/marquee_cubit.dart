import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'marquee_state.dart';

class MarqueeCubit extends Cubit<MarqueeCubitState> {
  MarqueeCubit()
      : super(
          MarqueeCubitState(
            activeMarqueeKeys: {},
            direction: MarqueeDirection.rtl,
            isOneShot: false,
          ),
        );

  void startMarquee(
    GlobalKey key, {
    MarqueeDirection direction = MarqueeDirection.rtl,
    bool isOneShot = false,
  }) {
    emit(
      MarqueeCubitState(
        activeMarqueeKeys: {...state.activeMarqueeKeys, key},
        direction: direction,
        isOneShot: isOneShot,
      ),
    );
  }

  void stopMarquee(GlobalKey key) {
    final updatedKeys = {...state.activeMarqueeKeys}..remove(key);
    emit(
      MarqueeCubitState(
        activeMarqueeKeys: updatedKeys,
        direction: state.direction,
        isOneShot: state.isOneShot,
      ),
    );
  }
}
