package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Exercise;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.SignUpSate;
import com.chengxusheji.po.SignUp;

import com.chengxusheji.mapper.SignUpMapper;
@Service
public class SignUpService {

	@Resource SignUpMapper signUpMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加活动报名记录*/
    public void addSignUp(SignUp signUp) throws Exception {
    	signUpMapper.addSignUp(signUp);
    }

    /*按照查询条件分页查询活动报名记录*/
    public ArrayList<SignUp> querySignUp(Exercise exerciseObj,UserInfo userObj,SignUpSate signUpState,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != exerciseObj && exerciseObj.getExerciseId()!= null && exerciseObj.getExerciseId()!= 0)  where += " and t_signUp.exerciseObj=" + exerciseObj.getExerciseId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_signUp.userObj='" + userObj.getUser_name() + "'";
    	if(null != signUpState && signUpState.getStateId()!= null && signUpState.getStateId()!= 0)  where += " and t_signUp.signUpState=" + signUpState.getStateId();
    	int startIndex = (currentPage-1) * this.rows;
    	return signUpMapper.querySignUp(where, startIndex, this.rows);
    }
    
    /*社团负责人按照查询条件分页查询活动报名记录*/
    public ArrayList<SignUp> querySignUp(Exercise exerciseObj,UserInfo userObj,SignUpSate signUpState,String stUserName,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != exerciseObj && exerciseObj.getExerciseId()!= null && exerciseObj.getExerciseId()!= 0)  where += " and t_signUp.exerciseObj=" + exerciseObj.getExerciseId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_signUp.userObj='" + userObj.getUser_name() + "'";
    	if(null != signUpState && signUpState.getStateId()!= null && signUpState.getStateId()!= 0)  where += " and t_signUp.signUpState=" + signUpState.getStateId();
    	if(null != stUserName) where += " and t_exercise.teamObj='" + stUserName + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return signUpMapper.querySignUp(where, startIndex, this.rows);
    }
    
    

    /*按照查询条件查询所有记录*/
    public ArrayList<SignUp> querySignUp(Exercise exerciseObj,UserInfo userObj,SignUpSate signUpState) throws Exception  { 
     	String where = "where 1=1";
    	if(null != exerciseObj && exerciseObj.getExerciseId()!= null && exerciseObj.getExerciseId()!= 0)  where += " and t_signUp.exerciseObj=" + exerciseObj.getExerciseId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_signUp.userObj='" + userObj.getUser_name() + "'";
    	if(null != signUpState && signUpState.getStateId()!= null && signUpState.getStateId()!= 0)  where += " and t_signUp.signUpState=" + signUpState.getStateId();
    	return signUpMapper.querySignUpList(where);
    }

    /*查询所有活动报名记录*/
    public ArrayList<SignUp> queryAllSignUp()  throws Exception {
        return signUpMapper.querySignUpList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Exercise exerciseObj,UserInfo userObj,SignUpSate signUpState) throws Exception {
     	String where = "where 1=1";
    	if(null != exerciseObj && exerciseObj.getExerciseId()!= null && exerciseObj.getExerciseId()!= 0)  where += " and t_signUp.exerciseObj=" + exerciseObj.getExerciseId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_signUp.userObj='" + userObj.getUser_name() + "'";
    	if(null != signUpState && signUpState.getStateId()!= null && signUpState.getStateId()!= 0)  where += " and t_signUp.signUpState=" + signUpState.getStateId();
        recordNumber = signUpMapper.querySignUpCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }
    
    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Exercise exerciseObj,UserInfo userObj,SignUpSate signUpState,String stUserName) throws Exception {
     	String where = "where 1=1";
    	if(null != exerciseObj && exerciseObj.getExerciseId()!= null && exerciseObj.getExerciseId()!= 0)  where += " and t_signUp.exerciseObj=" + exerciseObj.getExerciseId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_signUp.userObj='" + userObj.getUser_name() + "'";
    	if(null != signUpState && signUpState.getStateId()!= null && signUpState.getStateId()!= 0)  where += " and t_signUp.signUpState=" + signUpState.getStateId();
    	if(null != stUserName) where += " and t_exercise.teamObj='" + stUserName + "'";
    	recordNumber = signUpMapper.querySignUpCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }


    /*根据主键获取活动报名记录*/
    public SignUp getSignUp(int signUpId) throws Exception  {
        SignUp signUp = signUpMapper.getSignUp(signUpId);
        return signUp;
    }

    /*更新活动报名记录*/
    public void updateSignUp(SignUp signUp) throws Exception {
        signUpMapper.updateSignUp(signUp);
    }

    /*删除一条活动报名记录*/
    public void deleteSignUp (int signUpId) throws Exception {
        signUpMapper.deleteSignUp(signUpId);
    }

    /*删除多条活动报名信息*/
    public int deleteSignUps (String signUpIds) throws Exception {
    	String _signUpIds[] = signUpIds.split(",");
    	for(String _signUpId: _signUpIds) {
    		signUpMapper.deleteSignUp(Integer.parseInt(_signUpId));
    	}
    	return _signUpIds.length;
    }
}
