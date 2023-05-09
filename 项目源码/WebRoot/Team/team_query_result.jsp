<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/team.css" /> 

<div id="team_manage"></div>
<div id="team_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="team_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="team_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="team_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="team_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="team_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="teamQueryForm" method="post">
			社团管理员：<input type="text" class="textbox" id="teamUserName" name="teamUserName" style="width:110px" />
			社团名称：<input type="text" class="textbox" id="teamName" name="teamName" style="width:110px" />
			所属院校：<input type="text" class="textbox" id="shoolName" name="shoolName" style="width:110px" />
			所在区域：<input type="text" class="textbox" id="area" name="area" style="width:110px" />
			主管单位：<input type="text" class="textbox" id="mainUnit" name="mainUnit" style="width:110px" />
			电子邮箱：<input type="text" class="textbox" id="email" name="email" style="width:110px" />
			负责人电话：<input type="text" class="textbox" id="telephone" name="telephone" style="width:110px" />
			负责人姓名：<input type="text" class="textbox" id="chargeMan" name="chargeMan" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="team_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="teamEditDiv">
	<form id="teamEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">社团管理员:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_teamUserName_edit" name="team.teamUserName" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_password_edit" name="team.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">社团名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_teamName_edit" name="team.teamName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所属院校:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_shoolName_edit" name="team.shoolName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所在区域:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_area_edit" name="team.area" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">社团Logo:</span>
			<span class="inputControl">
				<img id="team_teamPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="team_teamPhoto" name="team.teamPhoto"/>
				<input id="teamPhotoFile" name="teamPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">主管单位:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_mainUnit_edit" name="team.mainUnit" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">成立日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_birthDate_edit" name="team.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">电子邮箱:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_email_edit" name="team.email" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">负责人电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_telephone_edit" name="team.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">负责人姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_chargeMan_edit" name="team.chargeMan" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">详细地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_address_edit" name="team.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">社团成员:</span>
			<span class="inputControl">
				<script name="team.personList" id="team_personList_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var team_personList_editor = UE.getEditor('team_personList_edit'); //社团成员编辑器
</script>
<script type="text/javascript" src="Team/js/team_manage.js"></script> 
