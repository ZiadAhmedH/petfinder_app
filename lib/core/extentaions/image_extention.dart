
extension ImageExtention on String {
  String getImageUrl(String? imageId) {
    return 'https://cdn2.thecatapi.com/images/$this.jpg';
  }
}