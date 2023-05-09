<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_st_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/team.css" />
<div id="team_editDiv">
	<form id="teamEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">社团管理员:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_teamUserName_edit" name="team.teamUserName" value="<%=session.getAttribute("st") %>" style="width:200px" />
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
				<script id="team_personList_edit" name="team.personList" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div class="operation">
			<a id="teamModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Team/js/team_modify.js"></script> 
