import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yamabico/feature/posts/presentation/index_screen.dart';
import 'package:yamabico/feature/user/presentation/user_detail_screen.dart';

class AudioPost extends StatelessWidget {
  final int index;
  final bool isVisibleAvatar;
  final AudioData audioData;

  const AudioPost({
    super.key,
    required this.index,
    this.isVisibleAvatar = true,
    required this.audioData,
  });

  // TODO: userDetailへの遷移はルーティングを通して遷移させる
  void _navigateToUserDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailScreen(
          user: audioData.user,
          userPosts: [audioData],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemState = Provider.of<ItemState>(context);

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          isVisibleAvatar
              ? GestureDetector(
                  onTap: () => _navigateToUserDetail(context),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 13.0),
                    child: Avatar(
                      url: audioData.user.avatarUrl,
                      width: 70,
                      height: 60,
                    ),
                  ),
                )
              : const SizedBox(),
          Content(
            title: audioData.title,
            name: audioData.user.name,
            time: audioData.playTime,
            count: audioData.count,
            date: audioData.date,
          ),
          IconButton(
            icon: itemState.isPlaying(index)
                ? const Icon(Icons.pause_circle_filled)
                : const Icon(Icons.play_circle_filled),
            color: const Color.fromRGBO(124, 122, 122, 1.0),
            iconSize: 40,
            onPressed: () => itemState.onPressedPlayButton(index),
          ),
        ],
      ),
    );
  }
}

class ItemState extends ChangeNotifier {
  final Map<int, bool> _playedMap = {};

  bool isPlaying(int index) {
    return _playedMap[index] ?? false;
  }

  void onPressedPlayButton(int index) {
    _playedMap[index] = !isPlaying(index);
    _playedMap.forEach((key, value) {
      if (key != index) {
        _playedMap[key] = false;
      }
    });
    notifyListeners();
  }
}

// 投稿者アバター
class Avatar extends StatelessWidget {
  final String? url;
  final double width;
  final double height;

  const Avatar({
    super.key,
    this.url,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircleAvatar(
        backgroundImage: NetworkImage(url!),
      ),
    );
  }
}

// 投稿内容
class Content extends StatelessWidget {
  final String title;
  final String name;
  final String time;
  final String count;
  final String date;
  const Content({
    super.key,
    required this.title,
    required this.name,
    required this.time,
    required this.count,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 5.0),
            alignment: Alignment.centerLeft,
            child: Text(title),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(flex: 3, child: Contributor(name: name)),
                Flexible(
                  flex: 2,
                  child: SizedBox(
                    width: 65,
                    child: PlayTime(time: time),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(flex: 3, child: TotalPlay(count: count)),
              Expanded(flex: 2, child: PostDate(date: date)),
            ],
          ),
        ],
      ),
    );
  }
}

// アイコン＋投稿者名
class Contributor extends StatelessWidget {
  final String name;

  const Contributor({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 3.0),
          child: Icon(Icons.record_voice_over, size: 15),
        ),
        Expanded(
          child: Text(
            name,
            softWrap: true,
            style: const TextStyle(fontSize: 15),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// アイコン＋再生時間
class PlayTime extends StatelessWidget {
  final String time;

  const PlayTime({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(237, 237, 237, 1.0),
      ),
      padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 3.0),
            child: const Icon(
              Icons.access_time,
              size: 15,
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

// アイコン＋総再生回数
class TotalPlay extends StatelessWidget {
  final String count;
  const TotalPlay({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 3.0),
          child: const Icon(Icons.video_library_outlined, size: 15),
        ),
        Expanded(
          child:
              Text(count, softWrap: true, style: const TextStyle(fontSize: 15)),
        ),
      ],
    );
  }
}

// 投稿日時
class PostDate extends StatelessWidget {
  final String date;
  const PostDate({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 3.0),
          child: Text(
            date,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
