import 'package:example_workshop/config/constants.dart';
import 'package:flutter/material.dart';

class InfiniteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InfiniteListState();
  
}

class _InfiniteListState extends State<InfiniteList> {

  List<String> items = [];
  bool loading = false;
  bool allLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if(items.isNotEmpty) {
            return Stack(
              children: [
                ListView.separated(
                  itemBuilder: (context, index) {
                    if(index < items.length) {
                      return ListTile(
                        title: Text(items[index])
                      );
                    } else {
                      return SizedBox(
                        width: constraints.maxWidth,
                        height: 50,
                        child: const Center(
                          child: Text(Constants.nothingMoreToLoad),
                          )
                      );
                    }
                  },

                  separatorBuilder: (context, index) 
                  {
                    return const Divider(height: 2);
                  },

                  itemCount: items.length + (allLoaded ? 1 : 0),
                ),
                if(loading)...[
                  // BottomProgressBar(constraints: constraints)
                ]
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator()
            );
          }
        },),
    );
  }

}