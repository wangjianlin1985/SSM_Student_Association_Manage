$(function () {
	$.ajax({
		url : "SignUpSate/" + $("#signUpSate_stateId_edit").val() + "/update",
		type : "get",
		data : {
			//stateId : $("#signUpSate_stateId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (signUpSate, response, status) {
			$.messager.progress("close");
			if (signUpSate) { 
				$("#signUpSate_stateId_edit").val(signUpSate.stateId);
				$("#signUpSate_stateId_edit").validatebox({
					required : true,
					missingMessage : "请输入状态id",
					editable: false
				});
				$("#signUpSate_stateName_edit").val(signUpSate.stateName);
				$("#signUpSate_stateName_edit").validatebox({
					required : true,
					missingMessage : "请输入状态名称",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#signUpSateModifyButton").click(function(){ 
		if ($("#signUpSateEditForm").form("validate")) {
			$("#signUpSateEditForm").form({
			    url:"SignUpSate/" +  $("#signUpSate_stateId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#signUpSateEditForm").form("validate"))  {
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
			$("#signUpSateEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
