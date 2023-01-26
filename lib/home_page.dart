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
      body: LoadingWidget(
        isLoading: watch.isLoading,
        child: Column(
          children: [
            const Text("Users"),
            ListView.separated(
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
                    title:Text(
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
                          color: Colors.grey.shade50
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 15,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

