import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:riverpod_app/controller/controller.dart';
import 'package:riverpod_app/view/loading_widget.dart';

final controller = ChangeNotifierProvider((ref) => Controller());

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    ref.read(controller).getData();
    super.initState();
  }

  Widget build(BuildContext context) {
    var read = ref.read(controller);
    var watch = ref.watch(controller);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Riverpod",
          style: TextStyle(color: Colors.orange),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: LoadingWidget(
        isLoading: watch.isLoading,
        child: Padding(

          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: OutlinedButton(
                      onPressed: () => read.notSavedButton(),
                      child: Text("Kullanıcılar (${watch.users.length})"),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 6,
                    child: OutlinedButton(
                      onPressed: () => read.SavedButton(),
                      child: Text("Kaydedilenler (${watch.saved.length})"),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: PageView(
                  controller: watch.pageController,
                  children: [
                    notSaved(watch),
                    Saved(watch),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView Saved(Controller watch) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: watch.saved.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: 15.allBR),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(watch.saved[index].avatar!),
              radius: 20,
            ),
            title: Text(
              "${watch.saved[index].firstName ?? " "} ${watch.saved[index].lastName ?? " "}",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              "${watch.saved[index].email ?? ""}",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black12),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 15,
        );
      },
    );
  }

  ListView notSaved(Controller watch) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: watch.users.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: 15.allBR),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(watch.users[index].avatar!),
              radius: 20,
            ),
            title: Text(
              "${watch.users[index].firstName ?? " "} ${watch.users[index].lastName ?? " "}",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              "${watch.users[index].email ?? ""}",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black12),
            ),
            trailing: IconButton(
                onPressed: () => watch.addSaved(watch.users[index]),
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                )),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 15,
        );
      },
    );
  }
}
