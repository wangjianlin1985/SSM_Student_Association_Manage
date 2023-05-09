var team_manage_tool = null; 
$(function () { 
	initTeamManageTool(); //建立Team管理对象
	team_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#team_manage").datagrid({
		url : 'Team/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "teamUserName",
		sortOrder : "desc",
		toolbar : "#team_manage_tool",
		columns : [[
			{
				field : "teamUserName",
				title : "社团管理员",
				width : 140,
			},
			{
				field : "teamName",
				title : "社团名称",
				width : 140,
			},
			{
				field : "shoolName",
				title : "所属院校",
				width : 140,
			},
			{
				field : "area",
				title : "所在区域",
				width : 140,
			},
			{
				field : "teamPhoto",
				title : "社团Logo",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "mainUnit",
				title : "主管单位",
				width : 140,
			},
			{
				field : "birthDate",
				title : "成立日期",
				width : 140,
			},
			{
				field : "email",
				title : "电子邮箱",
				width : 140,
			},
			{
				field : "telephone",
				title : "负责人电话",
				width : 140,
			},
			{
				field : "chargeMan",
				title : "负责人姓名",
				width : 140,
			},
		]],
	});

	$("#teamEditDiv").dialog({
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
				if ($("#teamEditForm").form("validate")) {
					//验证表单 
					if(!$("#teamEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#teamEditForm").form({
						    url:"Team/" + $("#team_teamUserName_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#teamEditDiv").dialog("close");
			                        team_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#teamEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#teamEditDiv").dialog("close");
				$("#teamEditForm").form("reset"); 
			},
		}],
	});
});

function initTeamManageTool() {
	team_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#team_manage").datagrid("reload");
		},
		redo : function () {
			$("#team_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#team_manage").datagrid("options").queryParams;
			queryParams["teamUserName"] = $("#teamUserName").val();
			queryParams["teamName"] = $("#teamName").val();
			queryParams["shoolName"] = $("#shoolName").val();
			queryParams["area"] = $("#area").val();
			queryParams["mainUnit"] = $("#mainUnit").val();
			queryParams["email"] = $("#email").val();
			queryParams["telephone"] = $("#telephone").val();
			queryParams["chargeMan"] = $("#chargeMan").val();
			$("#team_manage").datagrid("options").queryParams=queryParams; 
			$("#team_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#teamQueryForm").form({
			    url:"Team/OutToExcel",
			});
			//提交表单
			$("#teamQueryForm").submit();
		},
		remove : function () {
			var rows = $("#team_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var teamUserNames = [];
						for (var i = 0; i < rows.length; i ++) {
							teamUserNames.push(rows[i].teamUserName);
						}
						$.ajax({
							type : "POST",
							url : "Team/deletes",
							data : {
								teamUserNames : teamUserNames.join(","),
							},
							beforeSend : function () {
								$("#team_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#team_manage").datagrid("loaded");
									$("#team_manage").datagrid("load");
									$("#team_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#team_manage").datagrid("loaded");
									$("#team_manage").datagrid("load");
									$("#team_manage").datagrid("unselectAll");
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
			var rows = $("#team_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Team/" + rows[0].teamUserName +  "/update",
					type : "get",
					data : {
						//teamUserName : rows[0].teamUserName,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (team, response, status) {
						$.messager.progress("close");
						if (team) { 
							$("#teamEditDiv").dialog("open");
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
							team_personList_editor.setContent(team.personList, false);
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
