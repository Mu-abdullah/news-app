import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/component/component.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var search = TextEditingController();
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (BuildContext context, NewsStates state) {},
        builder: (BuildContext context, NewsStates state) {
          NewsCubit cubit = NewsCubit.get(context);
          var list = NewsCubit.get(context).search;
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Search"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: false,
                      style: const TextStyle(color: Colors.deepOrange),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.deepOrange,
                        ),
                        // fillColor: Colors.white,
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.blue)),
                        filled: true,
                        contentPadding: EdgeInsets.only(
                            bottom: 10.0, left: 10.0, right: 10.0),
                        labelText: "Search",
                      ),
                      controller: search,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Search must not empty";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        cubit.getSearch(value);
                      },
                    ),
                    Expanded(
                        child: list.isEmpty
                            ? const Center(child: CircularProgressIndicator())
                            : ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    articleItems(context, list[index]),
                                separatorBuilder: (context, index) =>
                                    myDivider(),
                                itemCount: list.length)),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
