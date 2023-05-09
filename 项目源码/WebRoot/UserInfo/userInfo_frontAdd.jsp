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
<title>用户添加</title>
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
  			<li><a href="<%=basePath %>UserInfo/frontlist">用户管理</a></li>
  			<li class="active">注册用户</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="userInfoAddForm" id="userInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
					 <label for="userInfo_user_name" class="col-md-2 text-right">用户名:</label>
					 <div class="col-md-8"> 
					 	<input type="text" id="userInfo_user_name" name="userInfo.user_name" class="form-control" placeholder="请输入用户名">
					 </div>
				  </div> 
				  <div class="form-group">
				  	 <label for="userInfo_password" class="col-md-2 text-right">登录密码:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_password" name="userInfo.password" class="form-control" placeholder="请输入登录密码">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_name" class="col-md-2 text-right">姓名:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_name" name="userInfo.name" class="form-control" placeholder="请输入姓名">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_sex" class="col-md-2 text-right">性别:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_sex" name="userInfo.sex" class="form-control" placeholder="请输入性别">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_userPhoto" class="col-md-2 text-right">用户照片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="userInfo_userPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="userInfo_userPhoto" name="userInfo.userPhoto"/>
					    <input id="userPhotoFile" name="userPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_schoolName" class="col-md-2 text-right">学校学院:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_schoolName" name="userInfo.schoolName" class="form-control" placeholder="请输入学校学院">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_specialInfo" class="col-md-2 text-right">年级专业:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_specialInfo" name="userInfo.specialInfo" class="form-control" placeholder="请输入年级专业">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_nation" class="col-md-2 text-right">民族:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_nation" name="userInfo.nation" class="form-control" placeholder="请输入民族">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_politicalStatus" class="col-md-2 text-right">政治面貌:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_politicalStatus" name="userInfo.politicalStatus" class="form-control" placeholder="请输入政治面貌">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_birthdayDiv" class="col-md-2 text-right">出生日期:</label>
				  	 <div class="col-md-8">
		                <div id="userInfo_birthdayDiv" class="input-group date userInfo_birthday col-md-12" data-link-field="userInfo_birthday" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="userInfo_birthday" name="userInfo.birthday" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_telephone" class="col-md-2 text-right">联系电话:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_telephone" name="userInfo.telephone" class="form-control" placeholder="请输入联系电话">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_address" class="col-md-2 text-right">联系地址:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_address" name="userInfo.address" class="form-control" placeholder="请输入联系地址">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_interest" class="col-md-2 text-right">有兴趣的项目:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_interest" name="userInfo.interest" class="form-control" placeholder="请输入有兴趣的项目">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_introduce" class="col-md-2 text-right">个人介绍:</label>
				  	 <div class="col-md-8">
							    <textarea name="userInfo.introduce" id="userInfo_introduce" style="width:100%;height:500px;"></textarea>
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxUserInfoAdd();" class="btn btn-primary bottom5 top5">注册用户</span>
		          </div> 
		          <style>#userInfoAddForm .form-group {margin:5px;}  </style>  
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
var userInfo_introduce_editor = UE.getEditor('userInfo_introduce'); //个人介绍编辑器
var basePath = "<%=basePath%>";
	//提交添加用户信息
	function ajaxUserInfoAdd() { 
		//提交之前先验证表单
		$("#userInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#userInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "UserInfo/add",
			dataType : "json" , 
			data: new FormData($("#userInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#userInfoAddForm").find("input").val("");
					$("#userInfoAddForm").find("textarea").val("");
					userInfo_introduce_editor.setContent("");
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
	//验证用户添加表单字段
	$('#userInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"userInfo.user_name": {
				validators: {
					notEmpty: {
						message: "用户名不能为空",
					}
				}
			},
			"userInfo.password": {
				validators: {
					notEmpty: {
						message: "登录密码不能为空",
					}
				}
			},
			"userInfo.name": {
				validators: {
					notEmpty: {
						message: "姓名不能为空",
					}
				}
			},
			"userInfo.sex": {
				validators: {
					notEmpty: {
						message: "性别不能为空",
					}
				}
			},
			"userInfo.schoolName": {
				validators: {
					notEmpty: {
						message: "学校学院不能为空",
					}
				}
			},
			"userInfo.specialInfo": {
				validators: {
					notEmpty: {
						message: "年级专业不能为空",
					}
				}
			},
			"userInfo.birthday": {
				validators: {
					notEmpty: {
						message: "出生日期不能为空",
					}
				}
			},
			"userInfo.telephone": {
				validators: {
					notEmpty: {
						message: "联系电话不能为空",
					}
				}
			},
			"userInfo.address": {
				validators: {
					notEmpty: {
						message: "联系地址不能为空",
					}
				}
			},
		}
	}); 
	//出生日期组件
	$('#userInfo_birthdayDiv').datetimepicker({
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
		$('#userInfoAddForm').data('bootstrapValidator').updateStatus('userInfo.birthday', 'NOT_VALIDATED',null).validateField('userInfo.birthday');
	});
})
</script>
</body>
</html>
