<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/signUpSate.css" />
<div id="signUpSateAddDiv">
	<form id="signUpSateAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">状态名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="signUpSate_stateName" name="signUpSate.stateName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="signUpSateAddButton" class="easyui-linkbutton">添加</a>
			<a id="signUpSateClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/SignUpSate/js/signUpSate_add.js"></script> 
