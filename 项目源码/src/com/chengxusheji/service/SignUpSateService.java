package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.SignUpSate;

import com.chengxusheji.mapper.SignUpSateMapper;
@Service
public class SignUpSateService {

	@Resource SignUpSateMapper signUpSateMapper;
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

    /*添加审核状态记录*/
    public void addSignUpSate(SignUpSate signUpSate) throws Exception {
    	signUpSateMapper.addSignUpSate(signUpSate);
    }

    /*按照查询条件分页查询审核状态记录*/
    public ArrayList<SignUpSate> querySignUpSate(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return signUpSateMapper.querySignUpSate(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<SignUpSate> querySignUpSate() throws Exception  { 
     	String where = "where 1=1";
    	return signUpSateMapper.querySignUpSateList(where);
    }

    /*查询所有审核状态记录*/
    public ArrayList<SignUpSate> queryAllSignUpSate()  throws Exception {
        return signUpSateMapper.querySignUpSateList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = signUpSateMapper.querySignUpSateCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取审核状态记录*/
    public SignUpSate getSignUpSate(int stateId) throws Exception  {
        SignUpSate signUpSate = signUpSateMapper.getSignUpSate(stateId);
        return signUpSate;
    }

    /*更新审核状态记录*/
    public void updateSignUpSate(SignUpSate signUpSate) throws Exception {
        signUpSateMapper.updateSignUpSate(signUpSate);
    }

    /*删除一条审核状态记录*/
    public void deleteSignUpSate (int stateId) throws Exception {
        signUpSateMapper.deleteSignUpSate(stateId);
    }

    /*删除多条审核状态信息*/
    public int deleteSignUpSates (String stateIds) throws Exception {
    	String _stateIds[] = stateIds.split(",");
    	for(String _stateId: _stateIds) {
    		signUpSateMapper.deleteSignUpSate(Integer.parseInt(_stateId));
    	}
    	return _stateIds.length;
    }
}
