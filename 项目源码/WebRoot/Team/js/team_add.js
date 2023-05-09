$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('team_personList');
	var team_personList_editor = UE.getEditor('team_personList'); //社团成员编辑框
	$("#team_teamUserName").validatebox({
		required : true, 
		missingMessage : '请输入社团管理员',
	});

	$("#team_password").validatebox({
		required : true, 
		missingMessage : '请输入登录密码',
	});

	$("#team_teamName").validatebox({
		required : true, 
		missingMessage : '请输入社团名称',
	});

	$("#team_shoolName").validatebox({
		required : true, 
		missingMessage : '请输入所属院校',
	});

	$("#team_area").validatebox({
		required : true, 
		missingMessage : '请输入所在区域',
	});

	$("#team_mainUnit").validatebox({
		required : true, 
		missingMessage : '请输入主管单位',
	});

	$("#team_birthDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#team_email").validatebox({
		required : true, 
		missingMessage : '请输入电子邮箱',
	});

	$("#team_telephone").validatebox({
		required : true, 
		missingMessage : '请输入负责人电话',
	});

	$("#team_chargeMan").validatebox({
		required : true, 
		missingMessage : '请输入负责人姓名',
	});

	$("#team_address").validatebox({
		required : true, 
		missingMessage : '请输入详细地址',
	});

	//单击添加按钮
	$("#teamAddButton").click(function () {
		if(team_personList_editor.getContent() == "") {
			alert("请输入社团成员");
			return;
		}
		//验证表单 
		if(!$("#teamAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#teamAddForm").form({
			    url:"Team/add",
			    onSubmit: function(){
					if($("#teamAddForm").form("validate"))  { 
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
                        $("#teamAddForm").form("clear");
                        team_personList_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#teamAddForm").submit();
		}
	});

	//单击清空按钮
	$("#teamClearButton").click(function () { 
		$("#teamAddForm").form("clear"); 
	});
});
