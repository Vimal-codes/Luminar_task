import 'package:flutter/material.dart';

class AssetCard extends StatelessWidget {
  final String name;
  final String type;
  final String description;
  final bool isAvailable;
  final VoidCallback? onTap;
  final VoidCallback? onEdit; // Callback for edit action

  const AssetCard({
    Key? key,
    required this.name,
    required this.type,
    required this.description,
    required this.isAvailable,
    this.onTap,
    this.onEdit, // Optional edit action
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle tap for navigation or editing
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Asset details
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Asset Name
                          Text(
                            name,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          // Asset Type
                          Text(
                            type,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          // Asset Description
                          Text(
                            description,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // Edit Icon
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: onEdit, // Trigger edit action
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(
                              isAvailable ? Icons.check_circle : Icons.cancel,
                              color: isAvailable ? Colors.green : Colors.red,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              isAvailable ? "Available" : "Unavailable",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: isAvailable ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
