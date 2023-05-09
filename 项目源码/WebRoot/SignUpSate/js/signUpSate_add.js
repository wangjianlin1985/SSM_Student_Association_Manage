$(function () {
	$("#signUpSate_stateName").validatebox({
		required : true, 
		missingMessage : '请输入状态名称',
	});

	//单击添加按钮
	$("#signUpSateAddButton").click(function () {
		//验证表单 
		if(!$("#signUpSateAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#signUpSateAddForm").form({
			    url:"SignUpSate/add",
			    onSubmit: function(){
					if($("#signUpSateAddForm").form("validate"))  { 
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
                        $("#signUpSateAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#signUpSateAddForm").submit();
		}
	});

	//单击清空按钮
	$("#signUpSateClearButton").click(function () { 
		$("#signUpSateAddForm").form("clear"); 
	});
});
