var signUpSate_manage_tool = null; 
$(function () { 
	initSignUpSateManageTool(); //建立SignUpSate管理对象
	signUpSate_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#signUpSate_manage").datagrid({
		url : 'SignUpSate/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "stateId",
		sortOrder : "desc",
		toolbar : "#signUpSate_manage_tool",
		columns : [[
			{
				field : "stateId",
				title : "状态id",
				width : 70,
			},
			{
				field : "stateName",
				title : "状态名称",
				width : 140,
			},
		]],
	});

	$("#signUpSateEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#signUpSateEditForm").form("validate")) {
					//验证表单 
					if(!$("#signUpSateEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#signUpSateEditForm").form({
						    url:"SignUpSate/" + $("#signUpSate_stateId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#signUpSateEditDiv").dialog("close");
			                        signUpSate_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#signUpSateEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#signUpSateEditDiv").dialog("close");
				$("#signUpSateEditForm").form("reset"); 
			},
		}],
	});
});

function initSignUpSateManageTool() {
	signUpSate_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#signUpSate_manage").datagrid("reload");
		},
		redo : function () {
			$("#signUpSate_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#signUpSate_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#signUpSateQueryForm").form({
			    url:"SignUpSate/OutToExcel",
			});
			//提交表单
			$("#signUpSateQueryForm").submit();
		},
		remove : function () {
			var rows = $("#signUpSate_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var stateIds = [];
						for (var i = 0; i < rows.length; i ++) {
							stateIds.push(rows[i].stateId);
						}
						$.ajax({
							type : "POST",
							url : "SignUpSate/deletes",
							data : {
								stateIds : stateIds.join(","),
							},
							beforeSend : function () {
								$("#signUpSate_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#signUpSate_manage").datagrid("loaded");
									$("#signUpSate_manage").datagrid("load");
									$("#signUpSate_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#signUpSate_manage").datagrid("loaded");
									$("#signUpSate_manage").datagrid("load");
									$("#signUpSate_manage").datagrid("unselectAll");
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
			var rows = $("#signUpSate_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "SignUpSate/" + rows[0].stateId +  "/update",
					type : "get",
					data : {
						//stateId : rows[0].stateId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (signUpSate, response, status) {
						$.messager.progress("close");
						if (signUpSate) { 
							$("#signUpSateEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
