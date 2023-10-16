import 'package:flutter/material.dart';
import 'package:via_cep_api/pages/ceps.dart';
import 'package:via_cep_api/pages/main_page.dart';
class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainPage()));
                },
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    width: double.infinity,
                    child: const Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Buscador de Cep"),
                      ],
                    ))),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                 Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (bc)=> const Ceps()));
              },
              child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: const Row(
                    children: [
                      Icon(Icons.location_city),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Ceps"),
                    ],
                  )),
            ),
             const Divider(),
            const SizedBox(
              height: 10,
            ),
            
          ],
        ),
      ),
    );
  }
}
