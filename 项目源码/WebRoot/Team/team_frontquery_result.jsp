<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Team" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Team> teamList = (List<Team>)request.getAttribute("teamList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String teamUserName = (String)request.getAttribute("teamUserName"); //社团管理员查询关键字
    String teamName = (String)request.getAttribute("teamName"); //社团名称查询关键字
    String shoolName = (String)request.getAttribute("shoolName"); //所属院校查询关键字
    String area = (String)request.getAttribute("area"); //所在区域查询关键字
    String mainUnit = (String)request.getAttribute("mainUnit"); //主管单位查询关键字
    String email = (String)request.getAttribute("email"); //电子邮箱查询关键字
    String telephone = (String)request.getAttribute("telephone"); //负责人电话查询关键字
    String chargeMan = (String)request.getAttribute("chargeMan"); //负责人姓名查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>社团查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Team/frontlist">社团信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Team/team_frontAdd.jsp" style="display:none;">添加社团</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<teamList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Team team = teamList.get(i); //获取到社团对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Team/<%=team.getTeamUserName() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=team.getTeamPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		社团管理员:<%=team.getTeamUserName() %>
			     	</div>
			     	<div class="field">
	            		社团名称:<%=team.getTeamName() %>
			     	</div>
			     	<div class="field">
	            		所属院校:<%=team.getShoolName() %>
			     	</div>
			     	<div class="field">
	            		所在区域:<%=team.getArea() %>
			     	</div>
			     	<div class="field">
	            		主管单位:<%=team.getMainUnit() %>
			     	</div>
			     	<div class="field">
	            		成立日期:<%=team.getBirthDate() %>
			     	</div>
			     	<div class="field">
	            		电子邮箱:<%=team.getEmail() %>
			     	</div>
			     	<div class="field">
	            		负责人电话:<%=team.getTelephone() %>
			     	</div>
			     	<div class="field">
	            		负责人姓名:<%=team.getChargeMan() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Team/<%=team.getTeamUserName() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="teamEdit('<%=team.getTeamUserName() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="teamDelete('<%=team.getTeamUserName() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>社团查询</h1>
		</div>
		<form name="teamQueryForm" id="teamQueryForm" action="<%=basePath %>Team/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="teamUserName">社团管理员:</label>
				<input type="text" id="teamUserName" name="teamUserName" value="<%=teamUserName %>" class="form-control" placeholder="请输入社团管理员">
			</div>
			<div class="form-group">
				<label for="teamName">社团名称:</label>
				<input type="text" id="teamName" name="teamName" value="<%=teamName %>" class="form-control" placeholder="请输入社团名称">
			</div>
			<div class="form-group">
				<label for="shoolName">所属院校:</label>
				<input type="text" id="shoolName" name="shoolName" value="<%=shoolName %>" class="form-control" placeholder="请输入所属院校">
			</div>
			<div class="form-group">
				<label for="area">所在区域:</label>
				<input type="text" id="area" name="area" value="<%=area %>" class="form-control" placeholder="请输入所在区域">
			</div>
			<div class="form-group">
				<label for="mainUnit">主管单位:</label>
				<input type="text" id="mainUnit" name="mainUnit" value="<%=mainUnit %>" class="form-control" placeholder="请输入主管单位">
			</div>
			<div class="form-group">
				<label for="email">电子邮箱:</label>
				<input type="text" id="email" name="email" value="<%=email %>" class="form-control" placeholder="请输入电子邮箱">
			</div>
			<div class="form-group">
				<label for="telephone">负责人电话:</label>
				<input type="text" id="telephone" name="telephone" value="<%=telephone %>" class="form-control" placeholder="请输入负责人电话">
			</div>
			<div class="form-group">
				<label for="chargeMan">负责人姓名:</label>
				<input type="text" id="chargeMan" name="chargeMan" value="<%=chargeMan %>" class="form-control" placeholder="请输入负责人姓名">
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="teamEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;社团信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="teamEditForm" id="teamEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="team_teamUserName_edit" class="col-md-3 text-right">社团管理员:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="team_teamUserName_edit" name="team.teamUserName" class="form-control" placeholder="请输入社团管理员" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="team_password_edit" class="col-md-3 text-right">登录密码:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="team_password_edit" name="team.password" class="form-control" placeholder="请输入登录密码">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="team_teamName_edit" class="col-md-3 text-right">社团名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="team_teamName_edit" name="team.teamName" class="form-control" placeholder="请输入社团名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="team_shoolName_edit" class="col-md-3 text-right">所属院校:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="team_shoolName_edit" name="team.shoolName" class="form-control" placeholder="请输入所属院校">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="team_area_edit" class="col-md-3 text-right">所在区域:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="team_area_edit" name="team.area" class="form-control" placeholder="请输入所在区域">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="team_teamPhoto_edit" class="col-md-3 text-right">社团Logo:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="team_teamPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="team_teamPhoto" name="team.teamPhoto"/>
			    <input id="teamPhotoFile" name="teamPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="team_mainUnit_edit" class="col-md-3 text-right">主管单位:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="team_mainUnit_edit" name="team.mainUnit" class="form-control" placeholder="请输入主管单位">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="team_birthDate_edit" class="col-md-3 text-right">成立日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date team_birthDate_edit col-md-12" data-link-field="team_birthDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="team_birthDate_edit" name="team.birthDate" size="16" type="text" value="" placeholder="请选择成立日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="team_email_edit" class="col-md-3 text-right">电子邮箱:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="team_email_edit" name="team.email" class="form-control" placeholder="请输入电子邮箱">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="team_telephone_edit" class="col-md-3 text-right">负责人电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="team_telephone_edit" name="team.telephone" class="form-control" placeholder="请输入负责人电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="team_chargeMan_edit" class="col-md-3 text-right">负责人姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="team_chargeMan_edit" name="team.chargeMan" class="form-control" placeholder="请输入负责人姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="team_address_edit" class="col-md-3 text-right">详细地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="team_address_edit" name="team.address" class="form-control" placeholder="请输入详细地址">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="team_personList_edit" class="col-md-3 text-right">社团成员:</label>
		  	 <div class="col-md-9">
			 	<textarea name="team.personList" id="team_personList_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#teamEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxTeamModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var team_personList_edit = UE.getEditor('team_personList_edit'); //社团成员编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.teamQueryForm.currentPage.value = currentPage;
    document.teamQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.teamQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.teamQueryForm.currentPage.value = pageValue;
    documentteamQueryForm.submit();
}

/*弹出修改社团界面并初始化数据*/
function teamEdit(teamUserName) {
	$.ajax({
		url :  basePath + "Team/" + teamUserName + "/update",
		type : "get",
		dataType: "json",
		success : function (team, response, status) {
			if (team) {
				$("#team_teamUserName_edit").val(team.teamUserName);
				$("#team_password_edit").val(team.password);
				$("#team_teamName_edit").val(team.teamName);
				$("#team_shoolName_edit").val(team.shoolName);
				$("#team_area_edit").val(team.area);
				$("#team_teamPhoto").val(team.teamPhoto);
				$("#team_teamPhotoImg").attr("src", basePath +　team.teamPhoto);
				$("#team_mainUnit_edit").val(team.mainUnit);
				$("#team_birthDate_edit").val(team.birthDate);
				$("#team_email_edit").val(team.email);
				$("#team_telephone_edit").val(team.telephone);
				$("#team_chargeMan_edit").val(team.chargeMan);
				$("#team_address_edit").val(team.address);
				team_personList_edit.setContent(team.personList, false);
				$('#teamEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除社团信息*/
function teamDelete(teamUserName) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Team/deletes",
			data : {
				teamUserNames : teamUserName,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#teamQueryForm").submit();
					//location.href= basePath + "Team/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交社团信息表单给服务器端修改*/
function ajaxTeamModify() {
	$.ajax({
		url :  basePath + "Team/" + $("#team_teamUserName_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#teamEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#teamQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse > a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();

    /*成立日期组件*/
    $('.team_birthDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

