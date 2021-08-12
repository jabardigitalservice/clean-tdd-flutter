class ContentModel {
  String? sTypename;
  Posts? posts;

  ContentModel({this.sTypename, this.posts});

  ContentModel.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    posts = json['posts'] != null ? new Posts.fromJson(json['posts']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    if (this.posts != null) {
      data['posts'] = this.posts!.toJson();
    }
    return data;
  }
}

class Posts {
  List<PostsContent>? posts;
  int? totalPosts;

  Posts({this.posts, this.totalPosts});

  Posts.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <PostsContent>[];
      json['posts'].forEach((v) {
        posts!.add(new PostsContent.fromJson(v));
      });
    }
    totalPosts = json['totalPosts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    data['totalPosts'] = this.totalPosts;
    return data;
  }
}

class PostsContent {
  String? content;
  String? title;

  PostsContent({this.content, this.title});

  PostsContent.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['title'] = this.title;
    return data;
  }
}
