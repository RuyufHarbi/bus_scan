import 'package:flutter/material.dart';
import '../../widgets/sidebar.dart';
class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
          children: [
            SideBar(context: context),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 90),
                                  Center(child: Text('Name:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                                  Center(
                                    child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.blue,
                                            ), color: Colors.blue[200],
                                            borderRadius: BorderRadius.all(Radius.circular(20))
                                        ),
                                        child: Text('Haya Im Alanazi', style: TextStyle(fontSize: 18 ))
                                    ),
                                  ),
                                  SizedBox(height: 10),

                                  Center(child: Text('ID:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                                  Center( child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.blue,
                                          ), color: Colors.blue[200],
                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      child:   Text('444701541', style: TextStyle(fontSize: 18))
                                  ),
                                  ),
                                  SizedBox(height: 10),

                                  Center(child: Text('Password:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                                  Center(
                                    child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.blue,
                                            ), color: Colors.blue[200],
                                            borderRadius: BorderRadius.all(Radius.circular(20))
                                        ),
                                        child: Text('********', style: TextStyle(fontSize: 18))
                                    ),
                                  ),
                                  SizedBox(height: 10),

                                  Center(child: Text('Phone Number:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                                  Center(
                                    child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.blue,
                                            ), color: Colors.blue[200],
                                            borderRadius: BorderRadius.all(Radius.circular(20))
                                        ),
                                        child:Text('0554656812', style: TextStyle(fontSize: 18))

                                    ),
                                  ),
                                  SizedBox(height: 100),

                                  // Action Buttons


                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text('Edit', style: TextStyle(fontSize: 16,color: Colors.black)),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue[200], // Edit button color
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text('Sign Out', style: TextStyle(fontSize: 16,color: Colors.black)),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue[200], // Sign Out button color
                                      ),
                                    ),
                                  )],
                              ),
                            ),
                          )
                        ])
                )
            )]
      ),
    );

  }
  Widget infoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.label),
          SizedBox(width: 10),
          Text('$label: $value', style: TextStyle(fontSize: 18))
        ],
      ),
    );
  }
}