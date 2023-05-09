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
import com.chengxusheji.service.TeamService;
import com.chengxusheji.po.Team;

//Team管理控制层
@Controller
@RequestMapping("/Team")
public class TeamController extends BaseController {

    /*业务层对象*/
    @Resource TeamService teamService;

	@InitBinder("team")
	public void initBinderTeam(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("team.");
	}
	/*跳转到添加Team视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Team());
		return "Team_add";
	}

	/*客户端ajax方式提交添加社团信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Team team, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		if(teamService.getTeam(team.getTeamUserName()) != null) {
			message = "社团管理员已经存在！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			team.setTeamPhoto(this.handlePhotoUpload(request, "teamPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        teamService.addTeam(team);
        message = "社团添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询社团信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String teamUserName,String teamName,String shoolName,String area,String mainUnit,String email,String telephone,String chargeMan,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (teamUserName == null) teamUserName = "";
		if (teamName == null) teamName = "";
		if (shoolName == null) shoolName = "";
		if (area == null) area = "";
		if (mainUnit == null) mainUnit = "";
		if (email == null) email = "";
		if (telephone == null) telephone = "";
		if (chargeMan == null) chargeMan = "";
		if(rows != 0)teamService.setRows(rows);
		List<Team> teamList = teamService.queryTeam(teamUserName, teamName, shoolName, area, mainUnit, email, telephone, chargeMan, page);
	    /*计算总的页数和总的记录数*/
	    teamService.queryTotalPageAndRecordNumber(teamUserName, teamName, shoolName, area, mainUnit, email, telephone, chargeMan);
	    /*获取到总的页码数目*/
	    int totalPage = teamService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = teamService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Team team:teamList) {
			JSONObject jsonTeam = team.getJsonObject();
			jsonArray.put(jsonTeam);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询社团信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Team> teamList = teamService.queryAllTeam();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Team team:teamList) {
			JSONObject jsonTeam = new JSONObject();
			jsonTeam.accumulate("teamUserName", team.getTeamUserName());
			jsonTeam.accumulate("teamName", team.getTeamName());
			jsonArray.put(jsonTeam);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询社团信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String teamUserName,String teamName,String shoolName,String area,String mainUnit,String email,String telephone,String chargeMan,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (teamUserName == null) teamUserName = "";
		if (teamName == null) teamName = "";
		if (shoolName == null) shoolName = "";
		if (area == null) area = "";
		if (mainUnit == null) mainUnit = "";
		if (email == null) email = "";
		if (telephone == null) telephone = "";
		if (chargeMan == null) chargeMan = "";
		List<Team> teamList = teamService.queryTeam(teamUserName, teamName, shoolName, area, mainUnit, email, telephone, chargeMan, currentPage);
	    /*计算总的页数和总的记录数*/
	    teamService.queryTotalPageAndRecordNumber(teamUserName, teamName, shoolName, area, mainUnit, email, telephone, chargeMan);
	    /*获取到总的页码数目*/
	    int totalPage = teamService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = teamService.getRecordNumber();
	    request.setAttribute("teamList",  teamList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("teamUserName", teamUserName);
	    request.setAttribute("teamName", teamName);
	    request.setAttribute("shoolName", shoolName);
	    request.setAttribute("area", area);
	    request.setAttribute("mainUnit", mainUnit);
	    request.setAttribute("email", email);
	    request.setAttribute("telephone", telephone);
	    request.setAttribute("chargeMan", chargeMan);
		return "Team/team_frontquery_result"; 
	}

     /*前台查询Team信息*/
	@RequestMapping(value="/{teamUserName}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable String teamUserName,Model model,HttpServletRequest request) throws Exception {
		/*根据主键teamUserName获取Team对象*/
        Team team = teamService.getTeam(teamUserName);

        request.setAttribute("team",  team);
        return "Team/team_frontshow";
	}

	/*ajax方式显示社团修改jsp视图页*/
	@RequestMapping(value="/{teamUserName}/update",method=RequestMethod.GET)
	public void update(@PathVariable String teamUserName,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键teamUserName获取Team对象*/
        Team team = teamService.getTeam(teamUserName);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonTeam = team.getJsonObject();
		out.println(jsonTeam.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新社团信息*/
	@RequestMapping(value = "/{teamUserName}/update", method = RequestMethod.POST)
	public void update(@Validated Team team, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String teamPhotoFileName = this.handlePhotoUpload(request, "teamPhotoFile");
		if(!teamPhotoFileName.equals("upload/NoImage.jpg"))team.setTeamPhoto(teamPhotoFileName); 


		try {
			teamService.updateTeam(team);
			message = "社团更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "社团更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除社团信息*/
	@RequestMapping(value="/{teamUserName}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable String teamUserName,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  teamService.deleteTeam(teamUserName);
	            request.setAttribute("message", "社团删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "社团删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条社团记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String teamUserNames,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = teamService.deleteTeams(teamUserNames);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出社团信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String teamUserName,String teamName,String shoolName,String area,String mainUnit,String email,String telephone,String chargeMan, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(teamUserName == null) teamUserName = "";
        if(teamName == null) teamName = "";
        if(shoolName == null) shoolName = "";
        if(area == null) area = "";
        if(mainUnit == null) mainUnit = "";
        if(email == null) email = "";
        if(telephone == null) telephone = "";
        if(chargeMan == null) chargeMan = "";
        List<Team> teamList = teamService.queryTeam(teamUserName,teamName,shoolName,area,mainUnit,email,telephone,chargeMan);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Team信息记录"; 
        String[] headers = { "社团管理员","社团名称","所属院校","所在区域","社团Logo","主管单位","成立日期","电子邮箱","负责人电话","负责人姓名"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<teamList.size();i++) {
        	Team team = teamList.get(i); 
        	dataset.add(new String[]{team.getTeamUserName(),team.getTeamName(),team.getShoolName(),team.getArea(),team.getTeamPhoto(),team.getMainUnit(),team.getBirthDate(),team.getEmail(),team.getTelephone(),team.getChargeMan()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Team.xls");//filename是下载的xls的名，建议最好用英文 
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
