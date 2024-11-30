import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> newsData = [
      {
        "title": "AI Revolutionizes the Tech Industry",
        "description": "Artificial Intelligence is transforming industries and changing the way we interact with technology.",
        "image": "assets/images/news_image.png"
      },
      {
        "title": "Quantum Computing Breakthrough Achieved",
        "description": "A major step forward in quantum computing could change the future of data processing.",
        "image": "assets/images/news_image.png"
      },
      {
        "title": "5G Networks Expanding Rapidly Across the Globe",
        "description": "5G networks are spreading worldwide, offering faster speeds and new opportunities in tech.",
        "image": "assets/images/news_image.png"
      },
      {
        "title": "Meta Unveils New VR Headset",
        "description": "Meta introduces a new virtual reality headset, pushing the boundaries of immersive technology.",
        "image": "assets/images/news_image.png"
      },
      {
        "title": "Tesla's Full Self-Driving Beta Gets Major Update",
        "description": "Tesla's Full Self-Driving beta receives an important update, improving safety and user experience.",
        "image": "assets/images/news_image.png"
      },
      {
        "title": "SpaceX Plans to Launch 100 Satellites in 2024",
        "description": "SpaceX is planning the launch of 100 satellites to expand its Starlink internet service.",
        "image": "assets/images/news_image.png"
      },
      {
        "title": "Top 10 Programming Languages to Learn in 2024",
        "description": "Discover the top programming languages that will be in demand in 2024 for developers.",
        "image": "assets/images/news_image.png"
      },
      {
        "title": "Breakthrough in Battery Technology Promises Longer Life",
        "description": "New advancements in battery technology are expected to greatly extend the lifespan of devices.",
        "image": "assets/images/news_image.png"
      },
      {
        "title": "Google Announces Next-Gen Pixel Devices",
        "description": "Google reveals new Pixel devices with improved performance, cameras, and AI features.",
        "image": "assets/images/news_image.png"
      },
      {
        "title": "Cybersecurity Threats on the Rise: How to Stay Safe",
        "description": "Cybersecurity experts warn of increasing threats and how to protect yourself in the digital age.",
        "image": "assets/images/news_image.png"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tech News',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 8,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: newsData.length,
        itemBuilder: (context, index) {
          final news = newsData[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  child: Image.asset(
                    news["image"]!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news["title"]!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          news["description"]!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
