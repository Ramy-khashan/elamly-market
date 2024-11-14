import 'package:elamlymarket/core/components/loading_item.dart';
import 'package:elamlymarket/core/components/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/components/search_bar.dart';
import '../../../core/utils/enums.dart';
import '../controller/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>.value(
      value:context.read<SearchCubit>()..searcForProducts(""),
      child: BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text("Search"),
              centerTitle: true,
              bottom: PreferredSize(
                  preferredSize: Size(double.infinity, 60),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 3),
                    child: SearchBarWidget( 
                      onChange: (val) {
                        context.read<SearchCubit>().searcForProducts(val);
                      },
                    ),
                  )),
            ),
            body: Column(
              children: [
                if (state.searchState == RequestState.loading)
                  Expanded(child: LoadingItem()),
                if (state.searchState == RequestState.loaded)
                  state.products.isEmpty
                      ? Expanded(
                          child: Center(
                            child: Text("Not Exist "  ,  style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic),),
                          ),
                        )
                      : Expanded(
                          child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.all(10),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      childAspectRatio: 2.2 / 3),
                              itemCount: state.products.length,
                              itemBuilder: (context, index) => ProductWidget(
                                    isWithSpace: true,
                                    product: state.products[index],
                                  )),
                        )
              ],
            ));
      }),
    );
  }
}
