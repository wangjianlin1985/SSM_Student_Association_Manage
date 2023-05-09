<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/signUpSate.css" />
<div id="signUpSate_editDiv">
	<form id="signUpSateEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">状态id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="signUpSate_stateId_edit" name="signUpSate.stateId" value="<%=request.getParameter("stateId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">状态名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="signUpSate_stateName_edit" name="signUpSate.stateName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="signUpSateModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/SignUpSate/js/signUpSate_modify.js"></script> 
