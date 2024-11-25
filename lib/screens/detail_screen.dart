import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wisata_candi/models/candi.dart';

class DetailScreen extends StatelessWidget {
  final Candi candi;
  const DetailScreen({super.key, required this.candi});

  void _showZoomedImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: InteractiveViewer(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => Transform.scale(
                  scale: 0.2,
                  child: const CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //HEADER
              Stack(children: [
                //Image Utama
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      candi.imageAsset,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
                ),
                //Tombol back
                Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ]),
              //INFO
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    //Info Atas (Nama Candi dan Tombol Favorit)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          candi.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {},
                        )
                      ],
                    ),
                    //Info Tengah (Lokasi, Dibangun, dan Tipe)
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 8),
                        const SizedBox(
                          width: 70,
                          child: Text('Lokasi',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Text(': ${candi.location}'),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 8),
                        const SizedBox(
                          width: 70,
                          child: Text('Dibangun',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Text(': ${candi.built}'),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.house,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 8),
                        const SizedBox(
                          width: 70,
                          child: Text('Tipe',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Text(': ${candi.type}'),
                      ],
                    ),
                    //Info Bawah (Deskripsi)
                    const SizedBox(height: 16),
                    Divider(
                      color: Colors.brown.shade100,
                      thickness: 1,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      candi.description,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    Divider(
                      color: Colors.brown.shade100,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
              //GALLERY
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Galeri',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: candi.imageUrls.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GestureDetector(
                              onTap: () => _showZoomedImage(
                                  context, candi.imageUrls[index]),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.brown.shade100,
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: CachedNetworkImage(
                                    imageUrl: candi.imageUrls[index],
                                    placeholder: (context, url) => Transform.scale(
                                        scale: 0.2,
                                        child:
                                            const CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tap untuk memperbesar',
                      style: TextStyle(color: Colors.brown),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
