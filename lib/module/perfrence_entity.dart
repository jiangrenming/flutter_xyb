class PerfrenceEntity {
	int summary;
	List<PerfrenceJzbyday> jzByDays;
	List<PerfrenceCfbyday> cfByDays;

	PerfrenceEntity({this.summary, this.jzByDays, this.cfByDays});

	PerfrenceEntity.fromJson(Map<String, dynamic> json) {
		summary = json['summary'];
		if (json['jzByDays'] != null) {
			jzByDays = new List<PerfrenceJzbyday>();(json['jzByDays'] as List).forEach((v) { jzByDays.add(new PerfrenceJzbyday.fromJson(v)); });
		}
		if (json['cfByDays'] != null) {
			cfByDays = new List<PerfrenceCfbyday>();(json['cfByDays'] as List).forEach((v) { cfByDays.add(new PerfrenceCfbyday.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['summary'] = this.summary;
		if (this.jzByDays != null) {
      data['jzByDays'] =  this.jzByDays.map((v) => v.toJson()).toList();
    }
		if (this.cfByDays != null) {
      data['cfByDays'] =  this.cfByDays.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class PerfrenceJzbyday {
	String date;
	int count;

	PerfrenceJzbyday({this.date, this.count});

	PerfrenceJzbyday.fromJson(Map<String, dynamic> json) {
		date = json['date'];
		count = json['count'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['date'] = this.date;
		data['count'] = this.count;
		return data;
	}
}

class PerfrenceCfbyday {
	String date;
	int count;

	PerfrenceCfbyday({this.date, this.count});

	PerfrenceCfbyday.fromJson(Map<String, dynamic> json) {
		date = json['date'];
		count = json['count'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['date'] = this.date;
		data['count'] = this.count;
		return data;
	}
}
