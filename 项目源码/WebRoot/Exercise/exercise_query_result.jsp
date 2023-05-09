<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/exercise.css" /> 

<div id="exercise_manage"></div>
<div id="exercise_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="exercise_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="exercise_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="exercise_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="exercise_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="exercise_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="exerciseQueryForm" method="post">
			活动名称：<input type="text" class="textbox" id="exerciseName" name="exerciseName" style="width:110px" />
			活动开始时间：<input type="text" id="exerciseDate" name="exerciseDate" class="easyui-datebox" editable="false" style="width:100px">
			主办社团：<input class="textbox" type="text" id="teamObj_teamUserName_query" name="teamObj.teamUserName" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="exercise_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="exerciseEditDiv">
	<form id="exerciseEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">活动id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exercise_exerciseId_edit" name="exercise.exerciseId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">活动名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exercise_exerciseName_edit" name="exercise.exerciseName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">活动开始时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exercise_exerciseDate_edit" name="exercise.exerciseDate" />

			</span>

		</div>
		<div>
			<span class="label">活动时长:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exercise_serviceTime_edit" name="exercise.serviceTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">活动地点:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exercise_address_edit" name="exercise.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">参与人数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exercise_personNum_edit" name="exercise.personNum" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">活动内容:</span>
			<span class="inputControl">
				<script name="exercise.content" id="exercise_content_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">主办社团:</span>
			<span class="inputControl">
				<input class="textbox"  id="exercise_teamObj_teamUserName_edit" name="exercise.teamObj.teamUserName" style="width: auto"/>
			</span>
		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var exercise_content_editor = UE.getEditor('exercise_content_edit'); //活动内容编辑器
</script>
<script type="text/javascript" src="Exercise/js/exercise_manage.js"></script> 
