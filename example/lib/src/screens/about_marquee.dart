part of 'example_homescreen.dart';

Widget _aboutMarquee(BuildContext context) {
  final marqueeKey = GlobalKey();
  return AboutCard(
    title: const Text('Marquee Widget'),
    description: const Text('© Scrolling Marquee on a widget'),
    demoWidgets: [
      AboutContent(
        title: const Text('Marquee Widget'),
        demo: _buildMarquee(context, marqueeKey: marqueeKey),
        size: const Size(300, 108),
      ),
    ],
  );
}

Widget _buildMarquee(BuildContext context, {required GlobalKey marqueeKey}) {
  return BlocProvider<MarqueeCubit>(
    create: (context) => MarqueeCubit(),
    child: Column(
      children: [
        Builder(
          builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<MarqueeCubit>().startMarquee(
                      marqueeKey,
                      direction: MarqueeDirection.ltr,
                    );
                  },
                  child: const Text('L-T-R'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<MarqueeCubit>().startMarquee(
                      marqueeKey,
                      // For readability
                      // ignore: avoid_redundant_argument_values
                      direction: MarqueeDirection.rtl,
                    );
                  },
                  child: const Text('R-T-L'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<MarqueeCubit>().stopMarquee(marqueeKey);
                  },
                  child: const Text('Stop'),
                ),
              ],
            );
          },
        ),
        MarqueeWidget(
          key: marqueeKey,
          duration: const Duration(seconds: 8),
          parent: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
          ),
          child: const Center(
            child: Text(
              'This is a child widget',
              style: TextStyle(fontSize: 32),
            ),
          ),
        ),
      ],
    ),
  );
}
