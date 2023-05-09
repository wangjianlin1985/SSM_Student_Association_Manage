$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('exercise_content');
	var exercise_content_editor = UE.getEditor('exercise_content'); //活动内容编辑框
	$("#exercise_exerciseName").validatebox({
		required : true, 
		missingMessage : '请输入活动名称',
	});

	$("#exercise_exerciseDate").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#exercise_serviceTime").validatebox({
		required : true, 
		missingMessage : '请输入活动时长',
	});

	$("#exercise_address").validatebox({
		required : true, 
		missingMessage : '请输入活动地点',
	});

	$("#exercise_personNum").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入参与人数',
		invalidMessage : '参与人数输入不对',
	});

	$("#exercise_teamObj_teamUserName").combobox({
	    url:'Team/listAll',
	    valueField: "teamUserName",
	    textField: "teamName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#exercise_teamObj_teamUserName").combobox("getData"); 
            if (data.length > 0) {
                $("#exercise_teamObj_teamUserName").combobox("select", data[0].teamUserName);
            }
        }
	});
	//单击添加按钮
	$("#exerciseAddButton").click(function () {
		if(exercise_content_editor.getContent() == "") {
			alert("请输入活动内容");
			return;
		}
		//验证表单 
		if(!$("#exerciseAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#exerciseAddForm").form({
			    url:"Exercise/stAdd",
			    onSubmit: function(){
					if($("#exerciseAddForm").form("validate"))  { 
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
                        $("#exerciseAddForm").form("clear");
                        exercise_content_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#exerciseAddForm").submit();
		}
	});

	//单击清空按钮
	$("#exerciseClearButton").click(function () { 
		$("#exerciseAddForm").form("clear"); 
	});
});
