// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do/app/resources/color_manager.dart';
import 'package:to_do/app/resources/strings_manager.dart';
import 'package:to_do/app/resources/values_manager.dart';
import 'package:to_do/app/services/notification_helper/notification_helper.dart';
import 'package:to_do/presentation/home/controller/bloc.dart';
import 'package:to_do/presentation/home/controller/states.dart';
import 'package:to_do/presentation/home/view/edit_task.dart';
import 'add_task.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..createDataBase(),
      child: BlocBuilder<HomeBloc, HomeStates>(
        builder: (context, state) {
          return Scaffold(
            key: HomeBloc.get(context).scaffoldKey,
            endDrawer: HomeBloc.get(context).isEdit
                ? EditTask(
                    task: HomeBloc.get(context).taskItem,
                  )
                : const AddTask(),
            floatingActionButton: GestureDetector(
              onTap: () {
                HomeBloc.get(context).openDrawer(isEditOrAdd: false);
              },
              child: Container(
                padding: EdgeInsetsDirectional.symmetric(
                  vertical: MediaQuery.of(context).size.height / AppSize.s36,
                  horizontal: MediaQuery.of(context).size.height / AppSize.s36,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      ColorManager.lightBlue,
                      ColorManager.mintGreen,
                    ],
                  ),
                  borderRadius: BorderRadiusDirectional.circular(AppSize.s30),
                ),
                child: Icon(
                  Icons.add,
                  size: AppSize.s24.w,
                  color: ColorManager.white,
                ),
              ),
            ),
            body: SafeArea(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentDirectional.topEnd,
                    end: AlignmentDirectional.bottomStart,
                    colors: [
                      ColorManager.onion.withOpacity(.2),
                      ColorManager.pink.withOpacity(.2),
                      ColorManager.pink.withOpacity(.2),
                      ColorManager.lightBlue.withOpacity(.2),
                      ColorManager.lightBlue.withOpacity(.2),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s40,
                    ),
                    Text(
                      AppStrings.toDo,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s40,
                    ),
                    Expanded(child: BlocBuilder<HomeBloc, HomeStates>(
                      builder: (context, state) {
                        return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width / AppSize.s40,
                            vertical: MediaQuery.of(context).size.height /
                                AppSize.s40,
                          ),
                          itemBuilder: (context, index) => taskItem(
                            task: HomeBloc.get(context).tasks[index],
                            context: context,
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s40,
                          ),
                          itemCount: HomeBloc.get(context).tasks.length,
                        );
                      },
                    )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget taskItem({
    required BuildContext context,
    required Map task,
  }) {
    String myTime = task["time"].toString().split(" ")[0];
    NotificationHelper notificationHelper = NotificationHelper();
    notificationHelper.scheduledNotification(
      hours: int.parse(myTime.split(":")[0]),
      minutes: int.parse(myTime.split(":")[1]),
      task: task,
    );
    return InkWell(
      onTap: () {
        HomeBloc.get(context).getTask(task: task);
        HomeBloc.get(context).openDrawer(isEditOrAdd: true);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / AppSize.s30,
          vertical: MediaQuery.of(context).size.width / AppSize.s30,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(
            AppSize.s10,
          ),
          color: ColorManager.white,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(int.parse("0x${task["color"]}")),
              radius: AppSize.s8.w,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / AppSize.s20,
            ),
            Expanded(
              child: Text(
                "${task["title"]}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${task["date"]}",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s120,
                ),
                Text(
                  "${task["time"]}",
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
