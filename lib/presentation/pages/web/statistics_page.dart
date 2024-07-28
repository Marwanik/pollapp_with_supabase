import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pollapp/service/statistics_service.dart';


class StatisticsPage extends ConsumerStatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends ConsumerState<StatisticsPage> {
  late Future<Map<String, Map<String, int>>> statisticsFuture;

  @override
  void initState() {
    super.initState();
    statisticsFuture = StatisticsService().fetchStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics'), backgroundColor: Color(0xFF343A40)),
      body: FutureBuilder<Map<String, Map<String, int>>>(
        future: statisticsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No statistics available.'));
          } else {
            final statistics = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ROOM: 5BY082',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Class President Election',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  buildCountdownTimer(),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: statistics.length,
                      itemBuilder: (context, index) {
                        final questionText = statistics.keys.elementAt(index);
                        final answers = statistics[questionText]!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              questionText,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            ...answers.entries.map((entry) {
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  leading: Icon(
                                    entry.key == 'Candidate 1' ? Icons.check_circle : Icons.radio_button_unchecked,
                                    color: entry.key == 'Candidate 1' ? Colors.green : null,
                                  ),
                                  title: Text(entry.key),
                                  trailing: Text('${entry.value}%'),
                                ),
                              );
                            }).toList(),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement vote submission logic
                      },
                      child: Text('Submit Vote'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFFD7A977),
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildCountdownTimer() {
    final now = DateTime.now();
    final endTime = DateTime(now.year, now.month, now.day + 7, 15, 20, 55); // Adjust the end time as needed
    final duration = endTime.difference(now);
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(days, 'Days'),
        buildTimeCard(hours, 'Hours'),
        buildTimeCard(minutes, 'Minutes'),
        buildTimeCard(seconds, 'Seconds'),
      ],
    );
  }

  Widget buildTimeCard(int time, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Text(
            time.toString().padLeft(2, '0'),
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          Text(unit, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
