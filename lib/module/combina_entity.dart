class CombinaEntity {
	double degs;
	List<int> cfCount;
	List<String> jzDate;
	List<int> jzCount;
	int allCount;
	List<String> cfDate;

	CombinaEntity({this.degs, this.cfCount, this.jzDate, this.jzCount, this.allCount, this.cfDate});

	CombinaEntity.fromJson(Map<String, dynamic> json) {
		degs = json['degs'];
		cfCount = json['cfCount']?.cast<int>();
		jzDate = json['jzDate']?.cast<String>();
		jzCount = json['jzCount']?.cast<int>();
		allCount = json['allCount'];
		cfDate = json['cfDate']?.cast<String>();
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['degs'] = this.degs;
		data['cfCount'] = this.cfCount;
		data['jzDate'] = this.jzDate;
		data['jzCount'] = this.jzCount;
		data['allCount'] = this.allCount;
		data['cfDate'] = this.cfDate;
		return data;
	}

	@override
	String toString() {
		return 'CombinaEntity{degs: $degs, cfCount: $cfCount, jzDate: $jzDate, jzCount: $jzCount, allCount: $allCount, cfDate: $cfDate}';
	}


}
