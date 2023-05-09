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
import com.chengxusheji.service.SignUpSateService;
import com.chengxusheji.po.SignUpSate;

//SignUpSate管理控制层
@Controller
@RequestMapping("/SignUpSate")
public class SignUpSateController extends BaseController {

    /*业务层对象*/
    @Resource SignUpSateService signUpSateService;

	@InitBinder("signUpSate")
	public void initBinderSignUpSate(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("signUpSate.");
	}
	/*跳转到添加SignUpSate视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new SignUpSate());
		return "SignUpSate_add";
	}

	/*客户端ajax方式提交添加审核状态信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated SignUpSate signUpSate, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        signUpSateService.addSignUpSate(signUpSate);
        message = "审核状态添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询审核状态信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)signUpSateService.setRows(rows);
		List<SignUpSate> signUpSateList = signUpSateService.querySignUpSate(page);
	    /*计算总的页数和总的记录数*/
	    signUpSateService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = signUpSateService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = signUpSateService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(SignUpSate signUpSate:signUpSateList) {
			JSONObject jsonSignUpSate = signUpSate.getJsonObject();
			jsonArray.put(jsonSignUpSate);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询审核状态信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<SignUpSate> signUpSateList = signUpSateService.queryAllSignUpSate();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(SignUpSate signUpSate:signUpSateList) {
			JSONObject jsonSignUpSate = new JSONObject();
			jsonSignUpSate.accumulate("stateId", signUpSate.getStateId());
			jsonSignUpSate.accumulate("stateName", signUpSate.getStateName());
			jsonArray.put(jsonSignUpSate);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询审核状态信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<SignUpSate> signUpSateList = signUpSateService.querySignUpSate(currentPage);
	    /*计算总的页数和总的记录数*/
	    signUpSateService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = signUpSateService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = signUpSateService.getRecordNumber();
	    request.setAttribute("signUpSateList",  signUpSateList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
		return "SignUpSate/signUpSate_frontquery_result"; 
	}

     /*前台查询SignUpSate信息*/
	@RequestMapping(value="/{stateId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer stateId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键stateId获取SignUpSate对象*/
        SignUpSate signUpSate = signUpSateService.getSignUpSate(stateId);

        request.setAttribute("signUpSate",  signUpSate);
        return "SignUpSate/signUpSate_frontshow";
	}

	/*ajax方式显示审核状态修改jsp视图页*/
	@RequestMapping(value="/{stateId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer stateId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键stateId获取SignUpSate对象*/
        SignUpSate signUpSate = signUpSateService.getSignUpSate(stateId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonSignUpSate = signUpSate.getJsonObject();
		out.println(jsonSignUpSate.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新审核状态信息*/
	@RequestMapping(value = "/{stateId}/update", method = RequestMethod.POST)
	public void update(@Validated SignUpSate signUpSate, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			signUpSateService.updateSignUpSate(signUpSate);
			message = "审核状态更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "审核状态更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除审核状态信息*/
	@RequestMapping(value="/{stateId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer stateId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  signUpSateService.deleteSignUpSate(stateId);
	            request.setAttribute("message", "审核状态删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "审核状态删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条审核状态记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String stateIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = signUpSateService.deleteSignUpSates(stateIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出审核状态信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel( Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<SignUpSate> signUpSateList = signUpSateService.querySignUpSate();
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "SignUpSate信息记录"; 
        String[] headers = { "状态id","状态名称"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<signUpSateList.size();i++) {
        	SignUpSate signUpSate = signUpSateList.get(i); 
        	dataset.add(new String[]{signUpSate.getStateId() + "",signUpSate.getStateName()});
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
			response.setHeader("Content-disposition","attachment; filename="+"SignUpSate.xls");//filename是下载的xls的名，建议最好用英文 
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
