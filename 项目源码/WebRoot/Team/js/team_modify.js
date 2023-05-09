$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('team_personList_edit');
	var team_personList_edit = UE.getEditor('team_personList_edit'); //社团成员编辑器
	team_personList_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Team/" + $("#team_teamUserName_edit").val() + "/update",
		type : "get",
		data : {
			//teamUserName : $("#team_teamUserName_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (team, response, status) {
			$.messager.progress("close");
			if (team) { 
				$("#team_teamUserName_edit").val(team.teamUserName);
				$("#team_teamUserName_edit").validatebox({
					required : true,
					missingMessage : "请输入社团管理员",
					editable: false
				});
				$("#team_password_edit").val(team.password);
				$("#team_password_edit").validatebox({
					required : true,
					missingMessage : "请输入登录密码",
				});
				$("#team_teamName_edit").val(team.teamName);
				$("#team_teamName_edit").validatebox({
					required : true,
					missingMessage : "请输入社团名称",
				});
				$("#team_shoolName_edit").val(team.shoolName);
				$("#team_shoolName_edit").validatebox({
					required : true,
					missingMessage : "请输入所属院校",
				});
				$("#team_area_edit").val(team.area);
				$("#team_area_edit").validatebox({
					required : true,
					missingMessage : "请输入所在区域",
				});
				$("#team_teamPhoto").val(team.teamPhoto);
				$("#team_teamPhotoImg").attr("src", team.teamPhoto);
				$("#team_mainUnit_edit").val(team.mainUnit);
				$("#team_mainUnit_edit").validatebox({
					required : true,
					missingMessage : "请输入主管单位",
				});
				$("#team_birthDate_edit").datebox({
					value: team.birthDate,
					required: true,
					showSeconds: true,
				});
				$("#team_email_edit").val(team.email);
				$("#team_email_edit").validatebox({
					required : true,
					missingMessage : "请输入电子邮箱",
				});
				$("#team_telephone_edit").val(team.telephone);
				$("#team_telephone_edit").validatebox({
					required : true,
					missingMessage : "请输入负责人电话",
				});
				$("#team_chargeMan_edit").val(team.chargeMan);
				$("#team_chargeMan_edit").validatebox({
					required : true,
					missingMessage : "请输入负责人姓名",
				});
				$("#team_address_edit").val(team.address);
				$("#team_address_edit").validatebox({
					required : true,
					missingMessage : "请输入详细地址",
				});
				team_personList_edit.setContent(team.personList);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#teamModifyButton").click(function(){ 
		if ($("#teamEditForm").form("validate")) {
			$("#teamEditForm").form({
			    url:"Team/" +  $("#team_teamUserName_edit").val() + "/update",
			    onSubmit: function(){
					if($("#teamEditForm").form("validate"))  {
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#teamEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
