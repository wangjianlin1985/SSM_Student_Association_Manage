$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('userInfo_introduce');
	var userInfo_introduce_editor = UE.getEditor('userInfo_introduce'); //个人介绍编辑框
	$("#userInfo_user_name").validatebox({
		required : true, 
		missingMessage : '请输入用户名',
	});

	$("#userInfo_password").validatebox({
		required : true, 
		missingMessage : '请输入登录密码',
	});

	$("#userInfo_name").validatebox({
		required : true, 
		missingMessage : '请输入姓名',
	});

	$("#userInfo_sex").validatebox({
		required : true, 
		missingMessage : '请输入性别',
	});

	$("#userInfo_schoolName").validatebox({
		required : true, 
		missingMessage : '请输入学校学院',
	});

	$("#userInfo_specialInfo").validatebox({
		required : true, 
		missingMessage : '请输入年级专业',
	});

	$("#userInfo_birthday").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#userInfo_telephone").validatebox({
		required : true, 
		missingMessage : '请输入联系电话',
	});

	$("#userInfo_address").validatebox({
		required : true, 
		missingMessage : '请输入联系地址',
	});

	//单击添加按钮
	$("#userInfoAddButton").click(function () {
		//验证表单 
		if(!$("#userInfoAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#userInfoAddForm").form({
			    url:"UserInfo/add",
			    onSubmit: function(){
					if($("#userInfoAddForm").form("validate"))  { 
	                	$.messager.progress({
							text : "正在提交数据中...",
						}); 
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#userInfoAddForm").form("clear");
                        userInfo_introduce_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#userInfoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#userInfoClearButton").click(function () { 
		$("#userInfoAddForm").form("clear"); 
	});
});
