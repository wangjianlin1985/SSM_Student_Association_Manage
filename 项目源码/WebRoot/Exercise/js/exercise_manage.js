var exercise_manage_tool = null; 
$(function () { 
	initExerciseManageTool(); //建立Exercise管理对象
	exercise_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#exercise_manage").datagrid({
		url : 'Exercise/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "exerciseId",
		sortOrder : "desc",
		toolbar : "#exercise_manage_tool",
		columns : [[
			{
				field : "exerciseName",
				title : "活动名称",
				width : 140,
			},
			{
				field : "exerciseDate",
				title : "活动开始时间",
				width : 140,
			},
			{
				field : "serviceTime",
				title : "活动时长",
				width : 140,
			},
			{
				field : "address",
				title : "活动地点",
				width : 140,
			},
			{
				field : "personNum",
				title : "参与人数",
				width : 70,
			},
			{
				field : "teamObj",
				title : "主办社团",
				width : 140,
			},
		]],
	});

	$("#exerciseEditDiv").dialog({
		title : "修改管理",
		top: "10px",
		width : 1000,
		height : 600,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#exerciseEditForm").form("validate")) {
					//验证表单 
					if(!$("#exerciseEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#exerciseEditForm").form({
						    url:"Exercise/" + $("#exercise_exerciseId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#exerciseEditDiv").dialog("close");
			                        exercise_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#exerciseEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#exerciseEditDiv").dialog("close");
				$("#exerciseEditForm").form("reset"); 
			},
		}],
	});
});

function initExerciseManageTool() {
	exercise_manage_tool = {
		init: function() {
			$.ajax({
				url : "Team/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#teamObj_teamUserName_query").combobox({ 
					    valueField:"teamUserName",
					    textField:"teamName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{teamUserName:"",teamName:"不限制"});
					$("#teamObj_teamUserName_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#exercise_manage").datagrid("reload");
		},
		redo : function () {
			$("#exercise_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#exercise_manage").datagrid("options").queryParams;
			queryParams["exerciseName"] = $("#exerciseName").val();
			queryParams["exerciseDate"] = $("#exerciseDate").datebox("getValue"); 
			queryParams["teamObj.teamUserName"] = $("#teamObj_teamUserName_query").combobox("getValue");
			$("#exercise_manage").datagrid("options").queryParams=queryParams; 
			$("#exercise_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#exerciseQueryForm").form({
			    url:"Exercise/OutToExcel",
			});
			//提交表单
			$("#exerciseQueryForm").submit();
		},
		remove : function () {
			var rows = $("#exercise_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var exerciseIds = [];
						for (var i = 0; i < rows.length; i ++) {
							exerciseIds.push(rows[i].exerciseId);
						}
						$.ajax({
							type : "POST",
							url : "Exercise/deletes",
							data : {
								exerciseIds : exerciseIds.join(","),
							},
							beforeSend : function () {
								$("#exercise_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#exercise_manage").datagrid("loaded");
									$("#exercise_manage").datagrid("load");
									$("#exercise_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#exercise_manage").datagrid("loaded");
									$("#exercise_manage").datagrid("load");
									$("#exercise_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#exercise_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Exercise/" + rows[0].exerciseId +  "/update",
					type : "get",
					data : {
						//exerciseId : rows[0].exerciseId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (exercise, response, status) {
						$.messager.progress("close");
						if (exercise) { 
							$("#exerciseEditDiv").dialog("open");
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
							exercise_content_editor.setContent(exercise.content, false);
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
