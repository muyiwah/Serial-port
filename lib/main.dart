import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:process_run/process_run.dart';
import 'package:serial_port_app/io_port_page.dart';
import 'package:process_run/which.dart';

import 'manag_port.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,

        scaffoldBackgroundColor: Colors.grey[300],
        // splashColor: Colors.bl,
        primaryColor: Color(0xFF12181b),
        appBarTheme: AppBarTheme(
          color: Color(0xFF12181b),
        ),
        // scaffoldBackgroundColor: Colors.black,
      ),
      title: 'Flutter Serial App',
      // home: ScorePage(),
      home: PortsPage(),
    );
  }
}

class PortsPage extends StatefulWidget {
  const PortsPage({super.key});

  @override
  State<PortsPage> createState() => _PortsPageState();
}

class _PortsPageState extends State<PortsPage> {
  List<String> availablePorts = ["COM1", "COM2"];

  @override
  void initState() {
    super.initState();
    initPorts();
  }

  var shell = Shell();
  var muyi;
  void initPorts() async {
    print(SerialPort.availablePorts);
    await shell.run('''

echo "hello world"
// $SerialPort.availablePorts

''');
    setState(
      () => {
        availablePorts.addAll(SerialPort.availablePorts),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(247, 13, 16, 20),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.all(20),
        constraints: BoxConstraints(),
        child: Scrollbar(
            child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text(
                  "Available Ports",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            for (final port in availablePorts)
              Builder(
                builder: (context) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(20, 3, 10, 3),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      textColor: Colors.white,
                      title: Text(port),
                      leading: const Icon(Icons.settings),
                      iconColor: Colors.green[500],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IOPortPage(
                              portName: port,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
          ],
        )),
      ),
    );
  }
}
