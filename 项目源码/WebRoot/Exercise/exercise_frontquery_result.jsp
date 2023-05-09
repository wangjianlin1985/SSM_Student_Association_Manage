<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Exercise" %>
<%@ page import="com.chengxusheji.po.Team" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Exercise> exerciseList = (List<Exercise>)request.getAttribute("exerciseList");
    //获取所有的teamObj信息
    List<Team> teamList = (List<Team>)request.getAttribute("teamList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String exerciseName = (String)request.getAttribute("exerciseName"); //活动名称查询关键字
    String exerciseDate = (String)request.getAttribute("exerciseDate"); //活动开始时间查询关键字
    Team teamObj = (Team)request.getAttribute("teamObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>活动查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#exerciseListPanel" aria-controls="exerciseListPanel" role="tab" data-toggle="tab">活动列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Exercise/exercise_frontAdd.jsp" style="display:none;">添加活动</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="exerciseListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>活动名称</td><td>活动开始时间</td><td>活动时长</td><td>活动地点</td><td>参与人数</td><td>主办社团</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<exerciseList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Exercise exercise = exerciseList.get(i); //获取到活动对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=exercise.getExerciseName() %></td>
 											<td><%=exercise.getExerciseDate() %></td>
 											<td><%=exercise.getServiceTime() %></td>
 											<td><%=exercise.getAddress() %></td>
 											<td><%=exercise.getPersonNum() %></td>
 											<td><%=exercise.getTeamObj().getTeamName() %></td>
 											<td>
 												<a href="<%=basePath  %>Exercise/<%=exercise.getExerciseId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="exerciseEdit('<%=exercise.getExerciseId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="exerciseDelete('<%=exercise.getExerciseId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>活动查询</h1>
		</div>
		<form name="exerciseQueryForm" id="exerciseQueryForm" action="<%=basePath %>Exercise/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="exerciseName">活动名称:</label>
				<input type="text" id="exerciseName" name="exerciseName" value="<%=exerciseName %>" class="form-control" placeholder="请输入活动名称">
			</div>






			<div class="form-group">
				<label for="exerciseDate">活动开始时间:</label>
				<input type="text" id="exerciseDate" name="exerciseDate" class="form-control"  placeholder="请选择活动开始时间" value="<%=exerciseDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <div class="form-group">
            	<label for="teamObj_teamUserName">主办社团：</label>
                <select id="teamObj_teamUserName" name="teamObj.teamUserName" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Team teamTemp:teamList) {
	 					String selected = "";
 					if(teamObj!=null && teamObj.getTeamUserName()!=null && teamObj.getTeamUserName().equals(teamTemp.getTeamUserName()))
 						selected = "selected";
	 				%>
 				 <option value="<%=teamTemp.getTeamUserName() %>" <%=selected %>><%=teamTemp.getTeamName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="exerciseEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;活动信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="exerciseEditForm" id="exerciseEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="exercise_exerciseId_edit" class="col-md-3 text-right">活动id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="exercise_exerciseId_edit" name="exercise.exerciseId" class="form-control" placeholder="请输入活动id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="exercise_exerciseName_edit" class="col-md-3 text-right">活动名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="exercise_exerciseName_edit" name="exercise.exerciseName" class="form-control" placeholder="请输入活动名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="exercise_exerciseDate_edit" class="col-md-3 text-right">活动开始时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date exercise_exerciseDate_edit col-md-12" data-link-field="exercise_exerciseDate_edit">
                    <input class="form-control" id="exercise_exerciseDate_edit" name="exercise.exerciseDate" size="16" type="text" value="" placeholder="请选择活动开始时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="exercise_serviceTime_edit" class="col-md-3 text-right">活动时长:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="exercise_serviceTime_edit" name="exercise.serviceTime" class="form-control" placeholder="请输入活动时长">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="exercise_address_edit" class="col-md-3 text-right">活动地点:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="exercise_address_edit" name="exercise.address" class="form-control" placeholder="请输入活动地点">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="exercise_personNum_edit" class="col-md-3 text-right">参与人数:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="exercise_personNum_edit" name="exercise.personNum" class="form-control" placeholder="请输入参与人数">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="exercise_content_edit" class="col-md-3 text-right">活动内容:</label>
		  	 <div class="col-md-9">
			 	<textarea name="exercise.content" id="exercise_content_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="exercise_teamObj_teamUserName_edit" class="col-md-3 text-right">主办社团:</label>
		  	 <div class="col-md-9">
			    <select id="exercise_teamObj_teamUserName_edit" name="exercise.teamObj.teamUserName" class="form-control">
			    </select>
		  	 </div>
		  </div>
		</form> 
	    <style>#exerciseEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxExerciseModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var exercise_content_edit = UE.getEditor('exercise_content_edit'); //活动内容编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.exerciseQueryForm.currentPage.value = currentPage;
    document.exerciseQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.exerciseQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.exerciseQueryForm.currentPage.value = pageValue;
    documentexerciseQueryForm.submit();
}

/*弹出修改活动界面并初始化数据*/
function exerciseEdit(exerciseId) {
	$.ajax({
		url :  basePath + "Exercise/" + exerciseId + "/update",
		type : "get",
		dataType: "json",
		success : function (exercise, response, status) {
			if (exercise) {
				$("#exercise_exerciseId_edit").val(exercise.exerciseId);
				$("#exercise_exerciseName_edit").val(exercise.exerciseName);
				$("#exercise_exerciseDate_edit").val(exercise.exerciseDate);
				$("#exercise_serviceTime_edit").val(exercise.serviceTime);
				$("#exercise_address_edit").val(exercise.address);
				$("#exercise_personNum_edit").val(exercise.personNum);
				exercise_content_edit.setContent(exercise.content, false);
				$.ajax({
					url: basePath + "Team/listAll",
					type: "get",
					success: function(teams,response,status) { 
						$("#exercise_teamObj_teamUserName_edit").empty();
						var html="";
		        		$(teams).each(function(i,team){
		        			html += "<option value='" + team.teamUserName + "'>" + team.teamName + "</option>";
		        		});
		        		$("#exercise_teamObj_teamUserName_edit").html(html);
		        		$("#exercise_teamObj_teamUserName_edit").val(exercise.teamObjPri);
					}
				});
				$('#exerciseEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除活动信息*/
function exerciseDelete(exerciseId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Exercise/deletes",
			data : {
				exerciseIds : exerciseId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#exerciseQueryForm").submit();
					//location.href= basePath + "Exercise/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交活动信息表单给服务器端修改*/
function ajaxExerciseModify() {
	$.ajax({
		url :  basePath + "Exercise/" + $("#exercise_exerciseId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#exerciseEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#exerciseQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse > a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();

    /*活动开始时间组件*/
    $('.exercise_exerciseDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

