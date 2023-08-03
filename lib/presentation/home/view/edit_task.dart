// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do/app/common/widget.dart';
import 'package:to_do/app/resources/color_manager.dart';
import 'package:to_do/app/resources/strings_manager.dart';
import 'package:to_do/app/resources/values_manager.dart';
import 'package:to_do/presentation/home/controller/bloc.dart';
import 'package:to_do/presentation/home/controller/states.dart';

class EditTask extends StatelessWidget {
  EditTask({
    super.key,
    required this.task,
  });

  Map task;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / AppSize.s20,
          vertical: MediaQuery.of(context).size.height / AppSize.s60,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [
              ColorManager.white,
              ColorManager.white,
              ColorManager.babyBlue
            ],
          ),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(AppSize.s10),
            topStart: Radius.circular(
              AppSize.s10,
            ),
          ),
        ),
        width: MediaQuery.of(context).size.width / AppSize.s1_3,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: HomeBloc.get(context).formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.updateTask.toUpperCase(),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s20,
                ),
                Text(
                  AppStrings.color,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s60,
                ),
                SizedBox(
                    height: AppSize.s50.h,
                    child: BlocBuilder<HomeBloc, HomeStates>(
                      builder: (context, state) {
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => colorPickerItem(
                              context: context,
                              index: index,
                              backgroundColor:
                                  HomeBloc.get(context).colorPicker[index]),
                          separatorBuilder: (context, index) => SizedBox(
                            width:
                                MediaQuery.of(context).size.width / AppSize.s40,
                          ),
                          itemCount: HomeBloc.get(context).colorPicker.length,
                        );
                      },
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s60,
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return AppStrings.isRequired;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text(
                      AppStrings.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  style: Theme.of(context).textTheme.headlineSmall,
                  controller: HomeBloc.get(context).titleController,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s20,
                ),
                Text(
                  AppStrings.description,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s200,
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return AppStrings.isRequired;
                    }
                    return null;
                  },
                  controller: HomeBloc.get(context).descriptionController,
                  maxLines: 5,
                  minLines: 5,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorManager.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppSize.s10,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s20,
                ),
                Text(
                  AppStrings.date,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                BlocBuilder<HomeBloc, HomeStates>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            HomeBloc.get(context).date,
                            style: Theme.of(context).textTheme.displayMedium,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            HomeBloc.get(context)
                                .showDatePickerFunction(context: context);
                          },
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: ColorManager.black,
                          ),
                        )
                      ],
                    );
                  },
                ),
                Container(
                  color: ColorManager.darkGrey,
                  width: double.infinity,
                  height: AppSize.s1,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s20,
                ),
                Text(
                  AppStrings.time,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                BlocBuilder<HomeBloc, HomeStates>(builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: Text(
                          HomeBloc.get(context).time,
                          style: Theme.of(context).textTheme.displayMedium,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          HomeBloc.get(context)
                              .showTimePickerFunction(context: context);
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: ColorManager.black,
                        ),
                      )
                    ],
                  );
                }),
                Container(
                  color: ColorManager.darkGrey,
                  width: double.infinity,
                  height: AppSize.s1,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s10,
                ),
                BlocBuilder<HomeBloc, HomeStates>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(
                                AppSize.s26,
                              ),
                              color: ColorManager.red,
                            ),
                            child: MaterialButton(
                              height: AppSize.s60.h,
                              onPressed: () {
                                HomeBloc.get(context)
                                    .deleteFromDataBase(id: task["id"]);
                                Navigator.pop(context);
                              },
                              child: Text(
                                AppStrings.delete,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width:
                              MediaQuery.of(context).size.width / AppSize.s40,
                        ),
                        Expanded(
                          child: SharedWidget.defualtButton(
                            label: AppStrings.update,
                            onPressed: () {
                              if (HomeBloc.get(context)
                                      .formKey
                                      .currentState!
                                      .validate() &&
                                  HomeBloc.get(context).date.isNotEmpty &&
                                  HomeBloc.get(context).time.isNotEmpty) {
                                HomeBloc.get(context).upDateDataBase(
                                  title: HomeBloc.get(context)
                                      .titleController
                                      .text,
                                  date: HomeBloc.get(context).date,
                                  description: HomeBloc.get(context)
                                      .descriptionController
                                      .text,
                                  color: HomeBloc.get(context)
                                      .colorPicker[
                                          HomeBloc.get(context).slectedColor]
                                      .value
                                      .toRadixString(16),
                                  time: HomeBloc.get(context).time,
                                  id: task["id"],
                                );
                                Navigator.pop(context);
                              }
                            },
                            context: context,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget colorPickerItem({
    required Color backgroundColor,
    required int index,
    required BuildContext context,
  }) {
    return InkWell(onTap: () {
      HomeBloc.get(context).changeSelectedColor(index);
    }, child: BlocBuilder<HomeBloc, HomeStates>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(AppSize.s5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: HomeBloc.get(context).slectedColor == index
                ? Border.all(color: backgroundColor)
                : null,
          ),
          child: CircleAvatar(
            backgroundColor: backgroundColor,
            radius: AppSize.s16.w,
          ),
        );
      },
    ));
  }
}
