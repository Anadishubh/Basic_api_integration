import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:api/api_fetch.dart';
import 'package:api/video_player.dart';
import 'model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<InstagramPost>> _futurePosts;

  @override
  void initState() {
    super.initState();
    _futurePosts =
        InstagramData().fetchPosts(); // Replace with your data fetching method
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffb42bfd),
        title: Text(
          'Instagram Clone',
          style: GoogleFonts.kanit(
            textStyle:
                const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      backgroundColor: Colors.white70,
      body: FutureBuilder<List<InstagramPost>>(
        future: _futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  return Card(
                    child: Column(
                      children: [
                        if (post.mediaType == 'IMAGE')
                          Image.network(post.mediaUrl),
                        if (post.mediaType == 'VIDEO')
                          SizedBox(
                            width: double.infinity,
                            height: 178,
                            child: VideoPlayerWidget(
                              videoUrl: post.mediaUrl,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
