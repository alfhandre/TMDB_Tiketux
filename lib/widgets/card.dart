import 'package:flutter/material.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/screen/detail/detail_film.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/theme.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/utils/text_plus_jakarta_sans.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/user_score.dart';

double roundToOneDecimal(double number) {
  return (number * 10).roundToDouble() / 10;
}

class CardTrending extends StatelessWidget {
  final String title, description, score, backdrop_path, id;
  final double? width;
  const CardTrending(
      {super.key,
      required this.title,
      required this.description,
      required this.score,
      required this.backdrop_path,
      this.width,
      required this.id});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return DetailFilmScreen(id: id);
        }));
      },
      child: Container(
        width: width != null ? screenWidth * width! : screenWidth * 0.8,
        decoration: BoxDecoration(
            color: bgCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderBlue)),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/original$backdrop_path',
                    fit: BoxFit.cover,
                    width: width != null
                        ? screenWidth * width!
                        : screenWidth * 0.8,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else if (loadingProgress.expectedTotalBytes != null &&
                          loadingProgress.cumulativeBytesLoaded ==
                              loadingProgress.expectedTotalBytes) {
                        return child;
                      } else if (loadingProgress.expectedTotalBytes != null &&
                          loadingProgress.cumulativeBytesLoaded >
                              loadingProgress.expectedTotalBytes!) {
                        return Container(
                          color: Colors.grey[400],
                          height: screenHeight * 0.2,
                          width: width != null
                              ? screenWidth * width!
                              : screenWidth * 0.8,
                          child: Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.grey[700],
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          color: bgCard,
                          height: screenHeight * 0.2,
                          width: width != null
                              ? screenWidth * width!
                              : screenWidth * 0.8,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: primary,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          ),
                        );
                      }
                    },
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return Container(
                        color: Colors.grey[400],
                        height: screenHeight * 0.2,
                        width: width != null
                            ? screenWidth * width!
                            : screenWidth * 0.8,
                        child: Center(
                          child: Icon(
                            Icons.error,
                            size: 30,
                            color: Colors.grey[700],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 16).add(
                    const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      JakartaSans.bold(text: title, fontSize: 18),
                      const SizedBox(height: 4),
                      JakartaSans.light(
                          text: description,
                          fontSize: 12,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IntrinsicWidth(
                  child: UserScoreMD(
                      score: '${roundToOneDecimal(double.parse(score))}'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardNewRelease extends StatelessWidget {
  final String score, posterPath, id;
  const CardNewRelease(
      {super.key,
      required this.score,
      required this.posterPath,
      required this.id});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return DetailFilmScreen(id: id);
        }));
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://image.tmdb.org/t/p/original$posterPath',
              fit: BoxFit.cover,
              height: screenHeight * 0.28,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else if (loadingProgress.expectedTotalBytes != null &&
                    loadingProgress.cumulativeBytesLoaded ==
                        loadingProgress.expectedTotalBytes) {
                  return child;
                } else if (loadingProgress.expectedTotalBytes != null &&
                    loadingProgress.cumulativeBytesLoaded >
                        loadingProgress.expectedTotalBytes!) {
                  return Container(
                    color: Colors.grey[400],
                    height: screenHeight * 0.28,
                    width: screenWidth * 0.45,
                    child: Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.grey[700],
                      ),
                    ),
                  );
                } else {
                  return Container(
                    color: bgCard,
                    height: screenHeight * 0.28,
                    width: screenWidth * 0.45,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: primary,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    ),
                  );
                }
              },
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Container(
                  color: Colors.grey[400],
                  height: screenHeight * 0.28,
                  width: screenWidth * 0.45,
                  child: Center(
                    child: Icon(
                      Icons.error,
                      size: 30,
                      color: Colors.grey[700],
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: IntrinsicWidth(
              child: UserScorePrecentateSM(
                  score: '${roundToOneDecimal(double.parse(score))}'),
            ),
          ),
        ],
      ),
    );
  }
}

class CardTopRank extends StatelessWidget {
  final String title, date, score, backdrop_path, id;
  const CardTopRank(
      {super.key,
      required this.title,
      required this.date,
      required this.score,
      required this.backdrop_path,
      required this.id});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return DetailFilmScreen(id: id);
        }));
      },
      child: Container(
        width: screenWidth * 0.9,
        decoration: BoxDecoration(
            color: bgCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderBlue)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://image.tmdb.org/t/p/original$backdrop_path',
                fit: BoxFit.cover,
                width: screenWidth * 0.9,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else if (loadingProgress.expectedTotalBytes != null &&
                      loadingProgress.cumulativeBytesLoaded ==
                          loadingProgress.expectedTotalBytes) {
                    return child;
                  } else if (loadingProgress.expectedTotalBytes != null &&
                      loadingProgress.cumulativeBytesLoaded >
                          loadingProgress.expectedTotalBytes!) {
                    return Container(
                      color: Colors.grey[400],
                      height: screenHeight * 0.23,
                      width: screenWidth * 0.9,
                      child: Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.grey[700],
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      color: bgCard,
                      height: screenHeight * 0.23,
                      width: screenWidth * 0.9,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: primary,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Container(
                    color: Colors.grey[400],
                    height: screenHeight * 0.23,
                    width: screenWidth * 0.9,
                    child: Center(
                      child: Icon(
                        Icons.error,
                        size: 30,
                        color: Colors.grey[700],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 16).add(
                const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JakartaSans.bold(
                      text: title,
                      fontSize: 18,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      JakartaSans.light(
                          text: date,
                          fontSize: 12,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.star,
                            color: gray,
                            size: 16,
                          ),
                          JakartaSans.bold(
                              text: score, fontSize: 12, color: gray),
                          JakartaSans.bold(text: '%', fontSize: 8, color: gray),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardCrew extends StatelessWidget {
  final String realName, charName;
  const CardCrew({super.key, required this.realName, required this.charName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderBlue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Container(
              color: Colors.black,
              height: 140,
              width: 140,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                JakartaSans.bold(text: realName, fontSize: 12),
                const SizedBox(height: 4),
                JakartaSans.light(text: charName, fontSize: 12, color: gray),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardComment extends StatelessWidget {
  final String title, date, description, score;
  const CardComment(
      {super.key,
      required this.title,
      required this.date,
      required this.description,
      required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xffFFFEFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color.fromARGB(25, 204, 21, 27),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                const CircleAvatar(
                  radius: 18,
                  child: Text('R'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    JakartaSans.custom(
                        text: title,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: black),
                    JakartaSans.light(text: date, fontSize: 10),
                  ],
                ),
              ]),
              UserScoreSM(score: score),
            ],
          ),
          const SizedBox(height: 12),
          JakartaSans.light(
              text: description,
              fontSize: 12,
              color: gray,
              textAlign: TextAlign.start)
        ],
      ),
    );
  }
}

class CardCrewDetail extends StatelessWidget {
  final String realName, asA;
  const CardCrewDetail({super.key, required this.realName, required this.asA});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bgCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xff3F55C61A).withOpacity(0.1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.black,
                height: 64,
                width: 64,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                JakartaSans.bold(text: realName, fontSize: 14),
                const SizedBox(height: 4),
                JakartaSans.light(text: asA, fontSize: 12, color: gray),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
