package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.ExerciseService;
import com.chengxusheji.po.Exercise;
import com.chengxusheji.service.TeamService;
import com.chengxusheji.po.Team;

//Exercise管理控制层
@Controller
@RequestMapping("/Exercise")
public class ExerciseController extends BaseController {

    /*业务层对象*/
    @Resource ExerciseService exerciseService;

    @Resource TeamService teamService;
	@InitBinder("teamObj")
	public void initBinderteamObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("teamObj.");
	}
	@InitBinder("exercise")
	public void initBinderExercise(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("exercise.");
	}
	/*跳转到添加Exercise视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Exercise());
		/*查询所有的Team信息*/
		List<Team> teamList = teamService.queryAllTeam();
		request.setAttribute("teamList", teamList);
		return "Exercise_add";
	}

	/*客户端ajax方式提交添加活动信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Exercise exercise, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        exerciseService.addExercise(exercise);
        message = "活动添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	

	/*客户端ajax方式社团管理员提交添加活动信息*/
	@RequestMapping(value = "/stAdd", method = RequestMethod.POST)
	public void stAdd(@Validated Exercise exercise, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		String message = "";
		boolean success = false;
		
		String st = (String)session.getAttribute("st");
		Team teamObj = teamService.getTeam(st); 
		exercise.setTeamObj(teamObj);
		
		 
        exerciseService.addExercise(exercise);
        message = "活动发布成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	/*ajax方式按照查询条件分页查询活动信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String exerciseName,String exerciseDate,@ModelAttribute("teamObj") Team teamObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (exerciseName == null) exerciseName = "";
		if (exerciseDate == null) exerciseDate = "";
		if(rows != 0)exerciseService.setRows(rows);
		List<Exercise> exerciseList = exerciseService.queryExercise(exerciseName, exerciseDate, teamObj, page);
	    /*计算总的页数和总的记录数*/
	    exerciseService.queryTotalPageAndRecordNumber(exerciseName, exerciseDate, teamObj);
	    /*获取到总的页码数目*/
	    int totalPage = exerciseService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = exerciseService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Exercise exercise:exerciseList) {
			JSONObject jsonExercise = exercise.getJsonObject();
			jsonArray.put(jsonExercise);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}
	
	
	/*ajax方式按照查询条件分页查询活动信息*/
	@RequestMapping(value = { "/stList" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void stList(String exerciseName,String exerciseDate,@ModelAttribute("teamObj") Team teamObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		if (page==null || page == 0) page = 1;
		if (exerciseName == null) exerciseName = "";
		if (exerciseDate == null) exerciseDate = "";
		if(rows != 0)exerciseService.setRows(rows);
		teamObj = new Team();
		teamObj.setTeamUserName(session.getAttribute("st").toString());
		List<Exercise> exerciseList = exerciseService.queryExercise(exerciseName, exerciseDate, teamObj, page);
	    /*计算总的页数和总的记录数*/
	    exerciseService.queryTotalPageAndRecordNumber(exerciseName, exerciseDate, teamObj);
	    /*获取到总的页码数目*/
	    int totalPage = exerciseService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = exerciseService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Exercise exercise:exerciseList) {
			JSONObject jsonExercise = exercise.getJsonObject();
			jsonArray.put(jsonExercise);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}
	

	/*ajax方式按照查询条件分页查询活动信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Exercise> exerciseList = exerciseService.queryAllExercise();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Exercise exercise:exerciseList) {
			JSONObject jsonExercise = new JSONObject();
			jsonExercise.accumulate("exerciseId", exercise.getExerciseId());
			jsonExercise.accumulate("exerciseName", exercise.getExerciseName());
			jsonArray.put(jsonExercise);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}
	
	/*ajax方式按照查询条件分页查询活动信息*/
	@RequestMapping(value = { "/stListAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void stListAll(HttpServletResponse response,HttpSession session) throws Exception {
		List<Exercise> exerciseList = exerciseService.queryAllExercise(session.getAttribute("st").toString());
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Exercise exercise:exerciseList) {
			JSONObject jsonExercise = new JSONObject();
			jsonExercise.accumulate("exerciseId", exercise.getExerciseId());
			jsonExercise.accumulate("exerciseName", exercise.getExerciseName());
			jsonArray.put(jsonExercise);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}
	

	/*前台按照查询条件分页查询活动信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String exerciseName,String exerciseDate,@ModelAttribute("teamObj") Team teamObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (exerciseName == null) exerciseName = "";
		if (exerciseDate == null) exerciseDate = "";
		List<Exercise> exerciseList = exerciseService.queryExercise(exerciseName, exerciseDate, teamObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    exerciseService.queryTotalPageAndRecordNumber(exerciseName, exerciseDate, teamObj);
	    /*获取到总的页码数目*/
	    int totalPage = exerciseService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = exerciseService.getRecordNumber();
	    request.setAttribute("exerciseList",  exerciseList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("exerciseName", exerciseName);
	    request.setAttribute("exerciseDate", exerciseDate);
	    request.setAttribute("teamObj", teamObj);
	    List<Team> teamList = teamService.queryAllTeam();
	    request.setAttribute("teamList", teamList);
		return "Exercise/exercise_frontquery_result"; 
	}

     /*前台查询Exercise信息*/
	@RequestMapping(value="/{exerciseId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer exerciseId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键exerciseId获取Exercise对象*/
        Exercise exercise = exerciseService.getExercise(exerciseId);

        List<Team> teamList = teamService.queryAllTeam();
        request.setAttribute("teamList", teamList);
        request.setAttribute("exercise",  exercise);
        return "Exercise/exercise_frontshow";
	}

	/*ajax方式显示活动修改jsp视图页*/
	@RequestMapping(value="/{exerciseId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer exerciseId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键exerciseId获取Exercise对象*/
        Exercise exercise = exerciseService.getExercise(exerciseId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonExercise = exercise.getJsonObject();
		out.println(jsonExercise.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新活动信息*/
	@RequestMapping(value = "/{exerciseId}/update", method = RequestMethod.POST)
	public void update(@Validated Exercise exercise, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			exerciseService.updateExercise(exercise);
			message = "活动更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "活动更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除活动信息*/
	@RequestMapping(value="/{exerciseId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer exerciseId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  exerciseService.deleteExercise(exerciseId);
	            request.setAttribute("message", "活动删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "活动删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条活动记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String exerciseIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = exerciseService.deleteExercises(exerciseIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出活动信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String exerciseName,String exerciseDate,@ModelAttribute("teamObj") Team teamObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(exerciseName == null) exerciseName = "";
        if(exerciseDate == null) exerciseDate = "";
        List<Exercise> exerciseList = exerciseService.queryExercise(exerciseName,exerciseDate,teamObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Exercise信息记录"; 
        String[] headers = { "活动名称","活动开始时间","活动时长","活动地点","参与人数","主办社团"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<exerciseList.size();i++) {
        	Exercise exercise = exerciseList.get(i); 
        	dataset.add(new String[]{exercise.getExerciseName(),exercise.getExerciseDate(),exercise.getServiceTime(),exercise.getAddress(),exercise.getPersonNum() + "",exercise.getTeamObj().getTeamName()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Exercise.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
