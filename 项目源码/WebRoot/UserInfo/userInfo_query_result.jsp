<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userInfo.css" /> 

<div id="userInfo_manage"></div>
<div id="userInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="userInfo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="userInfo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="userInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="userInfo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="userInfo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="userInfoQueryForm" method="post">
			用户名：<input type="text" class="textbox" id="user_name" name="user_name" style="width:110px" />
			姓名：<input type="text" class="textbox" id="name" name="name" style="width:110px" />
			学校学院：<input type="text" class="textbox" id="schoolName" name="schoolName" style="width:110px" />
			年级专业：<input type="text" class="textbox" id="specialInfo" name="specialInfo" style="width:110px" />
			出生日期：<input type="text" id="birthday" name="birthday" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="userInfo_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="userInfoEditDiv">
	<form id="userInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">用户名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_user_name_edit" name="userInfo.user_name" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_password_edit" name="userInfo.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_name_edit" name="userInfo.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_sex_edit" name="userInfo.sex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">用户照片:</span>
			<span class="inputControl">
				<img id="userInfo_userPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="userInfo_userPhoto" name="userInfo.userPhoto"/>
				<input id="userPhotoFile" name="userPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">学校学院:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_schoolName_edit" name="userInfo.schoolName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">年级专业:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_specialInfo_edit" name="userInfo.specialInfo" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">民族:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_nation_edit" name="userInfo.nation" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">政治面貌:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_politicalStatus_edit" name="userInfo.politicalStatus" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_birthday_edit" name="userInfo.birthday" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_telephone_edit" name="userInfo.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_address_edit" name="userInfo.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">有兴趣的项目:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="userInfo_interest_edit" name="userInfo.interest" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">个人介绍:</span>
			<span class="inputControl">
				<script name="userInfo.introduce" id="userInfo_introduce_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var userInfo_introduce_editor = UE.getEditor('userInfo_introduce_edit'); //个人介绍编辑器
</script>
<script type="text/javascript" src="UserInfo/js/userInfo_manage.js"></script> 
