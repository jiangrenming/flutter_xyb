class WorkTeamBeanEntity {
	List<WorkTeamBeanLevel> level;

	WorkTeamBeanEntity({this.level});

	WorkTeamBeanEntity.fromJson(Map<String, dynamic> json) {
		if (json['level'] != null) {
			level = new List<WorkTeamBeanLevel>();(json['level'] as List).forEach((v) { level.add(new WorkTeamBeanLevel.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.level != null) {
      data['level'] =  this.level.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class WorkTeamBeanLevel {
	String img;
	int roleId;
	String companyName;
	int levelId;
	int custId;
	String location;
	String levelName;

	WorkTeamBeanLevel({this.img, this.roleId, this.companyName, this.levelId, this.custId, this.location, this.levelName});

	WorkTeamBeanLevel.fromJson(Map<String, dynamic> json) {
		img = json['img'];
		roleId = json['roleId'];
		companyName = json['companyName'];
		levelId = json['levelId'];
		custId = json['custId'];
		location = json['location'];
		levelName = json['levelName'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['img'] = this.img;
		data['roleId'] = this.roleId;
		data['companyName'] = this.companyName;
		data['levelId'] = this.levelId;
		data['custId'] = this.custId;
		data['location'] = this.location;
		data['levelName'] = this.levelName;
		return data;
	}
}
