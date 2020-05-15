import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_xyb/base/response_entity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_xyb/widgets/home_top.dart';
import 'package:flutter_xyb/http/dio_net.dart';
import 'package:flutter_xyb/module/work_team_bean_entity.dart';
import 'package:flutter_xyb/constants/contants.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_xyb/utils/refresh_util.dart';
import 'package:flutter_xyb/view/home/emplomy/jx_manager.dart';
import 'package:flutter_xyb/utils/share_utils.dart';
import 'package:flutter_xyb/page_manager/load_state.dart';
//工作界面
class WorkPages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WorkPagesState();
  }
}

class _WorkPagesState extends State<WorkPages> {
  WorkTeamBeanEntity _workTeamBeanEntity;
  List<WorkTeamBeanLevel> _workTeamBeanLevel;
  String company = "";

  List<WorkItemBean> workItems = List();
  List<Widget> _itemList = List();

  LoadState loadState ;
  @override
  void initState() {
    super.initState();
    workItems = getAllWorkBeans();
    loadState = LoadState.State_Loading;
    getChooseData();
  }

  Widget getItemsWidget(WorkItemBean itemBean, BuildContext context) {
    if (itemBean.type == 0) {
      return Container(
        color: Colors.blueGrey,
        width: MediaQuery.of(context).size.width,
        height: 90.0,
        margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
        child: Material(
          borderRadius: BorderRadius.circular(10.0),
          elevation: 3.0,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width / 3.3,
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.all(2.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Image.asset(itemBean.itemBean[index].itemsImg,
                              height: 50.0, width: 50.0),
                          flex: 2,
                        ),
                        SizedBox(height: 2.0),
                        Expanded(
                          child: Text(itemBean.itemBean[index].itemNames,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 13.0)),
                          flex: 1,
                        )
                      ],
                    ),
                  );
                },
                itemCount: itemBean.itemBean.length,
                physics: new NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
              )),
        ),
      );
    } else {
      return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment(-1.0, 0.0),
                child: Text(
                  itemBean.title,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 20),
              GridView.builder(
                physics: new NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Fluttertoast.showToast(msg: "点击的位置:"+itemBean.itemBean[index].itemNames);
                      //ToDo()点击的项目
                       if(itemBean.itemBean[index].itemIds == 19){  //绩效管理
                         Navigator.push(context, MaterialPageRoute(builder: (context) {
                           return JXManager();
                         }));
                       }
                    },
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Image.asset(itemBean.itemBean[index].itemsImg,
                              height: 50.0, width: 50.0),
                          flex: 2,
                        ),
                        SizedBox(height: 2.0),
                        Expanded(
                          child: Text(itemBean.itemBean[index].itemNames,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 13.0)),
                          flex: 1,
                        )
                      ],
                    )),
                  );
                },
                itemCount: itemBean.itemBean.length,
              ),
            ],
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    _itemList.clear();
    _itemList = workItems.map((WorkItemBean item) {
      return getItemsWidget(item, context);
    }).toList();

    return SafeArea (
      child: LoadStateLayout(
        state: loadState,
        content: "努力加载中...",
        successWidget: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              HomeTopWidgets(data: _workTeamBeanLevel),
              Expanded(
                child: EasyRefresh.custom(
                    shrinkWrap:true,
                    header: RefreshUtils.defaultHeader(),
                    onRefresh: () async{
                      //TodO()刷新数据操作
                    },
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                          child: Column(
                            children: <Widget>[
                              ListPages(),
                              //3.三大类
                              ListView(
                                children: _itemList,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                              )
                            ],
                          )
                      )
                    ]
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  void getChooseData() {
    Map<String,dynamic> params = Map();
    params["userId"] = SharedPreferencesDataUtils.getInstace().getInt(Constans.USERID);
    DioApi.getInstance().post<HttpResponseEntity,WorkTeamBeanEntity>
      ("/home/index",params: params,
          sucessCallback: (response){
            _workTeamBeanEntity = response;
            setState(() {
              loadState = LoadState.State_Success;
              if(_workTeamBeanEntity != null )
              _workTeamBeanLevel = _workTeamBeanEntity.level == null ?  List() :_workTeamBeanEntity.level;
            });
          },reLoginCallBack: (special){

          },errorCallback: (error){

          }
        );
  }
}

/*****************轮播图 start**********************/
class ListPages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListPagesState();
  }
}

class _ListPagesState extends State<ListPages> {
  final List<Widget> imageList = [
    Image.network(
        'https://pics1.baidu.com/feed/08f790529822720e6aa6f6410a5a4d43f31fabb3.jpeg?token=8fb7f32253df1531c46bfa67fe21cc75&s=EC836E99524B10E7113DF0C1030070D0',
        fit: BoxFit.fill),
    Image.network(
        'https://pics7.baidu.com/feed/9213b07eca80653884f4b8bfe74ce641ac348292.jpeg?token=f1c223af398963687fc1d41ca058526b&s=5A25A944114213E7D66D0917030040C9',
        fit: BoxFit.fill),
    Image.network(
        'https://pics4.baidu.com/feed/3b87e950352ac65caf49b4788863f51492138a80.jpeg?token=a7dd7eb878a6fbb92255c263cac17547&s=6BA00D89440B0AEF5180B9930100E081',
        fit: BoxFit.fill)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      child: Swiper(
        autoplay: true,
        autoplayDelay: 5000,
        itemCount: 3,
        itemBuilder: (context, index) {
          return imageList[index];
        },
        scrollDirection: Axis.horizontal,
        //方向
        controller: SwiperController(),
        //分页控制按钮
        pagination: SwiperPagination(builder: SwiperPagination.dots),
        //分页指示器
        onTap: (index) {
          //TodO()轮播图点击事件
          Fluttertoast.showToast(msg: "点击的位置:$index");
        },
      ),
    );
  }
}

/*****************轮播图 end**********************/
List<WorkItemBean> getAllWorkBeans() {
  List<WorkItemBean> works = List();
  var zero = List<ItemBean>();
  zero.add(ItemBean(0, "今日订单", Constans.ASSETS_IMG + "icon_today_order.png"));
  zero.add(ItemBean(1, "待办事项", Constans.ASSETS_IMG + "icon_reminder.png"));
  zero.add(ItemBean(2, "服务通知", Constans.ASSETS_IMG + "icon_wait_do.png"));
  var zero_one = WorkItemBean(0, "", itemBean: zero);
  works.add(zero_one);

  var one = List<ItemBean>();
  one.add(ItemBean(3, "客户列表", Constans.ASSETS_IMG + "kh_khlb.png"));
  one.add(ItemBean(4, "拜访客户", Constans.ASSETS_IMG + "kh_bfkh.png"));
  one.add(ItemBean(5, "找商机", Constans.ASSETS_IMG + "kh_zsj.png"));
  one.add(ItemBean(6, "终端客户", Constans.ASSETS_IMG + "kh_zdkh.png"));
  one.add(ItemBean(7, "订单管理", Constans.ASSETS_IMG + "kh_ddgl.png"));
  one.add(ItemBean(8, "供货商管理", Constans.ASSETS_IMG + "kh_ghsgl.png"));
  var work_one = WorkItemBean(1, "客户管理", itemBean: one);
  works.add(work_one);

  var two = List<ItemBean>();
  two.add(ItemBean(9, "药品库存", Constans.ASSETS_IMG + "kc_ypkc.png"));
  two.add(ItemBean(10, "进货", Constans.ASSETS_IMG + "kc_jh.png"));
  var work_two = WorkItemBean(2, "库存管理", itemBean: two);
  works.add(work_two);

  var three = List<ItemBean>();
  three.add(ItemBean(13, "物料申请", Constans.ASSETS_IMG + "sp_wlsq.png"));
  three.add(ItemBean(14, "费用支持", Constans.ASSETS_IMG + "sp_fyzc.png"));
  three.add(ItemBean(15, "学术申请", Constans.ASSETS_IMG + "sp_xssq.png"));
  var work_three = WorkItemBean(3, "审批", itemBean: three);
  works.add(work_three);

  var four = List<ItemBean>();
  four.add(ItemBean(16, "电子处方", Constans.ASSETS_IMG + "zsgl_dzcf.png"));
  four.add(ItemBean(17, "诊所患者", Constans.ASSETS_IMG + "zsgl_zshz.png"));
  four.add(ItemBean(18, "员工管理", Constans.ASSETS_IMG + "zsgl_yggl.png"));
  four.add(ItemBean(19, "绩效管理", Constans.ASSETS_IMG + "gsgl_jxgl.png"));
  four.add(ItemBean(20, "老板报表", Constans.ASSETS_IMG + "zsgl_lbbb.png"));
  var work_four = WorkItemBean(4, "诊所管理", itemBean: four);
  works.add(work_four);

  var five = List<ItemBean>();
  five.add(ItemBean(21, "日报", Constans.ASSETS_IMG + "gzhb_rb.png"));
  five.add(ItemBean(22, "周报", Constans.ASSETS_IMG + "gzhb_zb.png"));
  five.add(ItemBean(23, "月报", Constans.ASSETS_IMG + "gzhb_yb.png"));
  var work_five = WorkItemBean(5, "工作汇报", itemBean: five);
  works.add(work_five);

  return works;
}

class WorkItemBean {
  int type;
  String title;
  List<ItemBean> itemBean;

  WorkItemBean(this.type, this.title, {this.itemBean});
}

class ItemBean {
  int itemIds;
  String itemNames;
  String itemsImg;

  ItemBean(this.itemIds, this.itemNames, this.itemsImg);
}
