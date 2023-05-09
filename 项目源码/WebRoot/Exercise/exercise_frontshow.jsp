<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Exercise" %>
<%@ page import="com.chengxusheji.po.Team" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的teamObj信息
    List<Team> teamList = (List<Team>)request.getAttribute("teamList");
    Exercise exercise = (Exercise)request.getAttribute("exercise");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>查看活动详情</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li><a href="<%=basePath %>Exercise/frontlist">活动信息</a></li>
  		<li class="active">详情查看</li>
	</ul>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">活动id:</div>
		<div class="col-md-10 col-xs-6"><%=exercise.getExerciseId()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">活动名称:</div>
		<div class="col-md-10 col-xs-6"><%=exercise.getExerciseName()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">活动开始时间:</div>
		<div class="col-md-10 col-xs-6"><%=exercise.getExerciseDate()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">活动时长:</div>
		<div class="col-md-10 col-xs-6"><%=exercise.getServiceTime()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">活动地点:</div>
		<div class="col-md-10 col-xs-6"><%=exercise.getAddress()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">参与人数:</div>
		<div class="col-md-10 col-xs-6"><%=exercise.getPersonNum()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">活动内容:</div>
		<div class="col-md-10 col-xs-6"><%=exercise.getContent()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">主办社团:</div>
		<div class="col-md-10 col-xs-6"><%=exercise.getTeamObj().getTeamName() %></div>
	</div>
	<div class="row bottom15">
		<div class="col-md-2 col-xs-4"></div>
		<div class="col-md-6 col-xs-6">
			<button onclick="userSign();" class="btn btn-primary">我要报名</button>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<button onclick="history.back();" class="btn btn-info">返回</button>
		</div>
	</div>
</div> 
<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script>
var basePath = "<%=basePath%>";

function userSign() { 

	$.ajax({
		url : basePath + "SignUp/userAdd",
		type : "post",
		dataType: "json",
		data: {
			"signUp.exerciseObj.exerciseId": <%=exercise.getExerciseId() %>
		},
		success : function (data, response, status) { 
			if(data.success){
				alert("报名成功~");
				//location.reload();
			}else{
				alert(data.message);
			}
		}
	});
}


$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse > a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
 })
 </script> 
</body>
</html>

