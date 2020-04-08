class LoginEntity {
	String phone;
	int roleId;
	String imageUrl;
	String name;
	int authFlag;
	int userId;
	String token;

	LoginEntity({this.phone, this.roleId, this.imageUrl, this.name, this.authFlag, this.userId, this.token});

	LoginEntity.fromJson(Map<String, dynamic> json) {
		phone = json['phone'];
		roleId = json['roleId'];
		imageUrl = json['imageUrl'];
		name = json['name'];
		authFlag = json['authFlag'];
		userId = json['userId'];
		token = json['token'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['phone'] = this.phone;
		data['roleId'] = this.roleId;
		data['imageUrl'] = this.imageUrl;
		data['name'] = this.name;
		data['authFlag'] = this.authFlag;
		data['userId'] = this.userId;
		data['token'] = this.token;
		return data;
	}
}
