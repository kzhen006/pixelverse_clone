class AppwriteConstants {
  static const String databaseId = '67fc31aa003cfa4af952';
  static const String projectId = '67fc179700311bc4f203';
  static const String endPoint = 'http://localhost:80/v1';

  static const String usersCollection = '67fd817100068f52a99d';
  static const String tweetsCollection = '6801317200351ee8fcc0';
  //static const String notificationsCollection = '63cd5ff88b08e40a11bc';

  static const String imagesBucket = '68018908002694647221';

  static String imageUrl(String imageId) =>
     '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
     //for only iOS: 'http://localhost:80/v1/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin'; 
  
}