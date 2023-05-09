<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/team.css" />
<div id="teamAddDiv">
	<form id="teamAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">社团管理员:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_teamUserName" name="team.teamUserName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_password" name="team.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">社团名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_teamName" name="team.teamName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所属院校:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_shoolName" name="team.shoolName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所在区域:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_area" name="team.area" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">社团Logo:</span>
			<span class="inputControl">
				<input id="teamPhotoFile" name="teamPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">主管单位:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_mainUnit" name="team.mainUnit" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">成立日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_birthDate" name="team.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">电子邮箱:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_email" name="team.email" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">负责人电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_telephone" name="team.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">负责人姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_chargeMan" name="team.chargeMan" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">详细地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="team_address" name="team.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">社团成员:</span>
			<span class="inputControl">
				<script name="team.personList" id="team_personList" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div class="operation">
			<a id="teamAddButton" class="easyui-linkbutton">添加</a>
			<a id="teamClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Team/js/team_add.js"></script> 
