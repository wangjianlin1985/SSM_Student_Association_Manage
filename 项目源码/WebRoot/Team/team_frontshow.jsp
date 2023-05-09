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
  <TITLE>查看社团详情</TITLE>
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
  		<li><a href="<%=basePath %>Team/frontlist">社团信息</a></li>
  		<li class="active">详情查看</li>
	</ul>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">社团管理员:</div>
		<div class="col-md-10 col-xs-6"><%=team.getTeamUserName()%></div>
	</div>
	 
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">社团名称:</div>
		<div class="col-md-10 col-xs-6"><%=team.getTeamName()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">所属院校:</div>
		<div class="col-md-10 col-xs-6"><%=team.getShoolName()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">所在区域:</div>
		<div class="col-md-10 col-xs-6"><%=team.getArea()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">社团Logo:</div>
		<div class="col-md-10 col-xs-6"><img class="img-responsive" src="<%=basePath %><%=team.getTeamPhoto() %>"  border="0px"/></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">主管单位:</div>
		<div class="col-md-10 col-xs-6"><%=team.getMainUnit()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">成立日期:</div>
		<div class="col-md-10 col-xs-6"><%=team.getBirthDate()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">电子邮箱:</div>
		<div class="col-md-10 col-xs-6"><%=team.getEmail()%></div>
	</div>
 
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">负责人姓名:</div>
		<div class="col-md-10 col-xs-6"><%=team.getChargeMan()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">详细地址:</div>
		<div class="col-md-10 col-xs-6"><%=team.getAddress()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">社团成员:</div>
		<div class="col-md-10 col-xs-6"><%=team.getPersonList()%></div>
	</div>
	
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">报名电话:</div>
		<div class="col-md-10 col-xs-6">
			<button class="btn btn-primary"><%=team.getTelephone()%></button>
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

