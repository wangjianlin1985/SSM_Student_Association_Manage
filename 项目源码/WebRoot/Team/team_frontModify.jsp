<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Team" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Team team = (Team)request.getAttribute("team");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改社团信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">社团信息修改</li>
	</ul>
		<div class="row"> 
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
			    <script name="team.personList" id="team_personList_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxTeamModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#teamEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


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
var team_personList_editor = UE.getEditor('team_personList_edit'); //社团成员编辑框
var basePath = "<%=basePath%>";
/*弹出修改社团界面并初始化数据*/
function teamEdit(teamUserName) {
  team_personList_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(teamUserName);
  });
}
 function ajaxModifyQuery(teamUserName) {
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
				team_personList_editor.setContent(team.personList, false);
			} else {
				alert("获取信息失败！");
			}
		}
	});
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
                location.reload(true);
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
    teamEdit("<%=request.getParameter("teamUserName")%>");
 })
 </script> 
</body>
</html>

