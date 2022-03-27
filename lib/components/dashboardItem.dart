import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  final String label;
  final String count;
  final IconData icon;
  final Color color;
  final bool isLoading;

  const DashboardItem({
    required this.label,
    required this.count,
    required this.icon,
    required this.color,
    required this.isLoading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white,),
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        icon,
                        size: 30,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Expanded(
                        child: Text(
                          label,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis,),
                        ),
                      )
                    ],
                  ),
                  Text(
                    count,
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ],
              ),
      ),
    );
  }
}
