import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_downloader/src/features/tiktok_downloader/domain/entities/video_item.dart';
import 'package:animations/animations.dart';
import '../../bloc/downloader_bloc/downloader_bloc.dart';
import 'old_download_item.dart';

class OldDownloadsSection extends StatefulWidget {
  const OldDownloadsSection({super.key});

  @override
  State<OldDownloadsSection> createState() => _OldDownloadsSectionState();
}

class _OldDownloadsSectionState extends State<OldDownloadsSection> {
  late List<VideoItem> oldDownloads;

  @override
  void initState() {
    super.initState();
    oldDownloads = context.read<DownloaderBloc>().oldDownloads;
    if (oldDownloads.isEmpty) {
      context.read<DownloaderBloc>().add(LoadOldDownloads());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloaderBloc, DownloaderState>(
      buildWhen: (previous, current) {
        if (current is OldDownloadsLoading) {
          return true;
        }
        if (current is OldDownloadsLoadingSuccess) {
          return true;
        }
        if (current is OldDownloadsLoadingFailure) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (oldDownloads.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: List.generate(
                context.read<DownloaderBloc>().oldDownloads.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: OpenContainer(
                    transitionType: ContainerTransitionType.fadeThrough,
                    closedElevation: 0,
                    closedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    closedColor: Colors.white,
                    openBuilder: (context, _) {
                      return Scaffold(
                        // appBar: AppBar(
                        //   title: Text('Video Details'),
                        // ),
                        body: Center(
                          child: OldDownloadItem(
                            videoItem: context.read<DownloaderBloc>().oldDownloads[index],
                          ),
                        ),
                      );
                    },
                    closedBuilder: (context, openContainer) {
                      return GestureDetector(
                        onTap: openContainer,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: OldDownloadItem(
                            videoItem: context.read<DownloaderBloc>().oldDownloads[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ).toList(),
            ),
          );
        } else {
          return const Center(
            child: Text(
              'No downloads available',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        }
      },
    );
  }
}
