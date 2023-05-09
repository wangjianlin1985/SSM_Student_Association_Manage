<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>社团添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Team/frontlist">社团管理</a></li>
  			<li class="active">注册社团</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="teamAddForm" id="teamAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
					 <label for="team_teamUserName" class="col-md-2 text-right">社团管理员:</label>
					 <div class="col-md-8"> 
					 	<input type="text" id="team_teamUserName" name="team.teamUserName" class="form-control" placeholder="请输入社团管理员">
					 </div>
				  </div> 
				  <div class="form-group">
				  	 <label for="team_password" class="col-md-2 text-right">登录密码:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="team_password" name="team.password" class="form-control" placeholder="请输入登录密码">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="team_teamName" class="col-md-2 text-right">社团名称:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="team_teamName" name="team.teamName" class="form-control" placeholder="请输入社团名称">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="team_shoolName" class="col-md-2 text-right">所属院校:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="team_shoolName" name="team.shoolName" class="form-control" placeholder="请输入所属院校">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="team_area" class="col-md-2 text-right">所在区域:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="team_area" name="team.area" class="form-control" placeholder="请输入所在区域">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="team_teamPhoto" class="col-md-2 text-right">社团Logo:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="team_teamPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="team_teamPhoto" name="team.teamPhoto"/>
					    <input id="teamPhotoFile" name="teamPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="team_mainUnit" class="col-md-2 text-right">主管单位:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="team_mainUnit" name="team.mainUnit" class="form-control" placeholder="请输入主管单位">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="team_birthDateDiv" class="col-md-2 text-right">成立日期:</label>
				  	 <div class="col-md-8">
		                <div id="team_birthDateDiv" class="input-group date team_birthDate col-md-12" data-link-field="team_birthDate" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="team_birthDate" name="team.birthDate" size="16" type="text" value="" placeholder="请选择成立日期" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="team_email" class="col-md-2 text-right">电子邮箱:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="team_email" name="team.email" class="form-control" placeholder="请输入电子邮箱">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="team_telephone" class="col-md-2 text-right">负责人电话:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="team_telephone" name="team.telephone" class="form-control" placeholder="请输入负责人电话">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="team_chargeMan" class="col-md-2 text-right">负责人姓名:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="team_chargeMan" name="team.chargeMan" class="form-control" placeholder="请输入负责人姓名">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="team_address" class="col-md-2 text-right">详细地址:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="team_address" name="team.address" class="form-control" placeholder="请输入详细地址">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="team_personList" class="col-md-2 text-right">社团成员:</label>
				  	 <div class="col-md-8">
							    <textarea name="team.personList" id="team_personList" style="width:100%;height:500px;"></textarea>
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxTeamAdd();" class="btn btn-primary bottom5 top5">社团注册</span>
		          </div> 
		          <style>#teamAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
	    </div>
	</div>
</div>
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var team_personList_editor = UE.getEditor('team_personList'); //社团成员编辑器
var basePath = "<%=basePath%>";
	//提交添加社团信息
	function ajaxTeamAdd() { 
		//提交之前先验证表单
		$("#teamAddForm").data('bootstrapValidator').validate();
		if(!$("#teamAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(team_personList_editor.getContent() == "") {
			alert('社团成员不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Team/add",
			dataType : "json" , 
			data: new FormData($("#teamAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#teamAddForm").find("input").val("");
					$("#teamAddForm").find("textarea").val("");
					team_personList_editor.setContent("");
				} else {
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
	//验证社团添加表单字段
	$('#teamAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"team.teamUserName": {
				validators: {
					notEmpty: {
						message: "社团管理员不能为空",
					}
				}
			},
			"team.password": {
				validators: {
					notEmpty: {
						message: "登录密码不能为空",
					}
				}
			},
			"team.teamName": {
				validators: {
					notEmpty: {
						message: "社团名称不能为空",
					}
				}
			},
			"team.shoolName": {
				validators: {
					notEmpty: {
						message: "所属院校不能为空",
					}
				}
			},
			"team.area": {
				validators: {
					notEmpty: {
						message: "所在区域不能为空",
					}
				}
			},
			"team.mainUnit": {
				validators: {
					notEmpty: {
						message: "主管单位不能为空",
					}
				}
			},
			"team.birthDate": {
				validators: {
					notEmpty: {
						message: "成立日期不能为空",
					}
				}
			},
			"team.email": {
				validators: {
					notEmpty: {
						message: "电子邮箱不能为空",
					}
				}
			},
			"team.telephone": {
				validators: {
					notEmpty: {
						message: "负责人电话不能为空",
					}
				}
			},
			"team.chargeMan": {
				validators: {
					notEmpty: {
						message: "负责人姓名不能为空",
					}
				}
			},
			"team.address": {
				validators: {
					notEmpty: {
						message: "详细地址不能为空",
					}
				}
			},
		}
	}); 
	//成立日期组件
	$('#team_birthDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#teamAddForm').data('bootstrapValidator').updateStatus('team.birthDate', 'NOT_VALIDATED',null).validateField('team.birthDate');
	});
})
</script>
</body>
</html>
