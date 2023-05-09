$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('exercise_content_edit');
	var exercise_content_edit = UE.getEditor('exercise_content_edit'); //活动内容编辑器
	exercise_content_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Exercise/" + $("#exercise_exerciseId_edit").val() + "/update",
		type : "get",
		data : {
			//exerciseId : $("#exercise_exerciseId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (exercise, response, status) {
			$.messager.progress("close");
			if (exercise) { 
				$("#exercise_exerciseId_edit").val(exercise.exerciseId);
				$("#exercise_exerciseId_edit").validatebox({
					required : true,
					missingMessage : "请输入活动id",
					editable: false
				});
				$("#exercise_exerciseName_edit").val(exercise.exerciseName);
				$("#exercise_exerciseName_edit").validatebox({
					required : true,
					missingMessage : "请输入活动名称",
				});
				$("#exercise_exerciseDate_edit").datetimebox({
					value: exercise.exerciseDate,
					required: true,
					showSeconds: true,
				});
				$("#exercise_serviceTime_edit").val(exercise.serviceTime);
				$("#exercise_serviceTime_edit").validatebox({
					required : true,
					missingMessage : "请输入活动时长",
				});
				$("#exercise_address_edit").val(exercise.address);
				$("#exercise_address_edit").validatebox({
					required : true,
					missingMessage : "请输入活动地点",
				});
				$("#exercise_personNum_edit").val(exercise.personNum);
				$("#exercise_personNum_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入参与人数",
					invalidMessage : "参与人数输入不对",
				});
				exercise_content_edit.setContent(exercise.content);
				$("#exercise_teamObj_teamUserName_edit").combobox({
					url:"Team/listAll",
					valueField:"teamUserName",
					textField:"teamName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#exercise_teamObj_teamUserName_edit").combobox("select", exercise.teamObjPri);
						//var data = $("#exercise_teamObj_teamUserName_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#exercise_teamObj_teamUserName_edit").combobox("select", data[0].teamUserName);
						//}
					}
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#exerciseModifyButton").click(function(){ 
		if ($("#exerciseEditForm").form("validate")) {
			$("#exerciseEditForm").form({
			    url:"Exercise/" +  $("#exercise_exerciseId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#exerciseEditForm").form("validate"))  {
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
			$("#exerciseEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
