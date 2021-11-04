import 'package:example_workshop/config/constants.dart';
import 'package:example_workshop/utils/mock_helper.dart';
import 'package:example_workshop/widgets/bottom_progress_bar.dart';
import 'package:example_workshop/widgets/update_name_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class InfiniteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InfiniteListState();
  
}

class _InfiniteListState extends State<InfiniteList> {

  final ScrollController _scrollController = ScrollController();
  List<String> items = [];
  bool loading = false;
  bool allLoaded = false;

  @override
  void initState() {
    super.initState();
    mockFetch();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        mockFetch();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if(items.isNotEmpty) {
            return Stack(
              children: [
                ListView.separated(
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if(index < items.length) {
                      return Slidable(

                        child: 
                          ListTile(
                            title: Text(items[index])
                          ), 
                        
                        actionPane: SlidableStrechActionPane(),

                        actions: [
                          IconSlideAction(
                            caption: "CHANGE",
                            color: Colors.blue,
                            icon: Icons.update,
                            onTap: () => openUpdateItemPopup(index),
                          )
                        ],

                        secondaryActions: [
                          IconSlideAction(
                            caption: "DELETE",
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () => deleteElement(index),
                          )
                        ]); 
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
                  BottomProgressBar(constraints: constraints)
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

  mockFetch() async {
    if(allLoaded) return;

    setState(() => loading = true);

    List<String> newData = await MockHelper.mockList(items);

    if(newData.isNotEmpty) items.addAll(newData);

    setState(() => {
      loading = false,
      allLoaded = newData.isEmpty    
    });
  }

  openUpdateItemPopup(index) {
    showDialog(
      context: context, 
      builder: (BuildContext context) => 
        UpdateNamePopup(
          index: index,
          itemTitle: items[index],
          updateElement: updateElement,
        )
    );
  }

  updateElement(index, newTitle) {
    setState(() => items[index] = newTitle);
  }

  deleteElement(index) {
    setState(() => items.removeAt(index));
  }

}