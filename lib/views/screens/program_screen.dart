import 'package:calisthenic_app/configs/app_theme.dart';
import 'package:calisthenic_app/constants/layout_constant.dart';
import 'package:calisthenic_app/constants/route_constant.dart';
import 'package:calisthenic_app/controllers/program_controller.dart';
import 'package:calisthenic_app/controllers/timer_controller.dart';
import 'package:calisthenic_app/models/workout.dart';
import 'package:calisthenic_app/views/components/app_bar_component.dart';
import 'package:calisthenic_app/views/components/day_component.dart';
import 'package:calisthenic_app/views/components/workout_card_component.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgramScreen extends StatelessWidget {
  const ProgramScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBarComponent.getAppBarComponent(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.bottomSheet(
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 8 * LayoutConstant.kScaleFactor,
                      horizontal: LayoutConstant.kHorizontalScreenPadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Download',
                              style: context.theme.textTheme.labelMedium,
                            ),
                            Icon(
                              Icons.download,
                              size: context.theme.iconTheme.size,
                              color: context.theme.iconTheme.color,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: LayoutConstant.kSpaceBetweenElements,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Save as favorite',
                              style: context.theme.textTheme.labelMedium,
                            ),
                            Icon(
                              Icons.favorite_border_rounded,
                              size: context.theme.iconTheme.size,
                              color: context.theme.iconTheme.color,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                backgroundColor: context.theme.scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      LayoutConstant.kCardRadius,
                    ),
                  ),
                ),
                enterBottomSheetDuration: AppTheme.animationDuration,
                exitBottomSheetDuration: AppTheme.animationDuration,
              );
            },
            icon: const Icon(EvaIcons.moreVerticalOutline),
          ),
        ],
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            extendedSizeConstraints: BoxConstraints.tightFor(
              height: 40 * LayoutConstant.kScaleFactor,
              width: Get.width - 2 * LayoutConstant.kHorizontalScreenPadding,
            ),
            backgroundColor: context.theme.primaryColor,
          ),
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            TimerController controller = Get.find();
            controller.count = 10;
            controller.initialCount = 10;
            controller.pauseCount = 0;
            controller.start();
            Get.toNamed(RouteConstant.kRestScreen);
          },
          label: Text(
            'Start',
            style: GoogleFonts.montserrat(
              fontSize: 16 * LayoutConstant.kScaleFactor,
              fontWeight: FontWeight.w500,
              color: const Color(0xffffffff),
            ),
          ),
        ),
      ),
      body: GetBuilder(builder: (ProgramController controller) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: LayoutConstant.kVerticalScreenPadding,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      controller.program!.name,
                      style: context.theme.textTheme.titleLarge,
                    ),
                    SizedBox(
                      width: LayoutConstant.kSpaceBetweenTitleAndElement,
                    ),
                    IconButton(
                      onPressed: controller.program == null
                          ? null
                          : () {
                              Get.toNamed(RouteConstant.kProgramDetailScreen);
                            },
                      icon: const Icon(
                        Icons.help_outline_rounded,
                        size: 32.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: LayoutConstant.kSpaceBetweenTitleAndElement,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: AppTheme.kPhysics,
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8 * LayoutConstant.kScaleFactor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...List.generate(
                        controller.program?.days ?? 0,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: DayComponent(
                            day: index + 1,
                            active: index + 1 == controller.activeDay
                                ? true
                                : false,
                            completed:
                                index + 1 < controller.nextDay ? true : false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
            Expanded(
              child: ListView(
                physics: AppTheme.kPhysics,
                padding: EdgeInsets.only(
                  // top: LayoutConstant.kVerticalScreenPadding,
                  left: LayoutConstant.kHorizontalScreenPadding,
                  right: LayoutConstant.kHorizontalScreenPadding,
                ),
                children: [
                  SizedBox(
                    height: 24 * LayoutConstant.kScaleFactor,
                  ),
                  Text(
                    'Warm Up',
                    style: context.theme.textTheme.headlineMedium,
                  ),
                  SizedBox(
                    height: LayoutConstant.kSpaceBetweenTitleAndElement,
                  ),
                  ...controller
                      .workouts(
                        program: controller.program,
                        workoutType: WorkoutType.warmUp,
                      )
                      .map(
                        (workout) => Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 4 * LayoutConstant.kScaleFactor,
                          ),
                          child: WorkoutCardComponent(workout: workout),
                        ),
                      )
                      .toList(),
                  SizedBox(
                    height: 2 * LayoutConstant.kSpaceBetweenTitleAndElement,
                  ),
                  Text(
                    'Workouts',
                    style: context.theme.textTheme.headlineMedium,
                  ),
                  SizedBox(
                    height: LayoutConstant.kSpaceBetweenTitleAndElement,
                  ),
                  ...controller
                      .workouts(
                        program: controller.program,
                        workoutType: WorkoutType.workout,
                      )
                      .map(
                        (workout) => Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 4 * LayoutConstant.kScaleFactor,
                          ),
                          child: WorkoutCardComponent(workout: workout),
                        ),
                      )
                      .toList(),
                  SizedBox(
                    height: 2 * LayoutConstant.kSpaceBetweenTitleAndElement,
                  ),
                  Text(
                    'Cool Down',
                    style: context.theme.textTheme.headlineMedium,
                  ),
                  SizedBox(
                    height: LayoutConstant.kSpaceBetweenTitleAndElement,
                  ),
                  ...controller
                      .workouts(
                        program: controller.program,
                        workoutType: WorkoutType.coolDown,
                      )
                      .map(
                        (workout) => Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 4 * LayoutConstant.kScaleFactor,
                          ),
                          child: WorkoutCardComponent(workout: workout),
                        ),
                      )
                      .toList(),
                  SizedBox(
                    height: 24 * LayoutConstant.kScaleFactor,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
