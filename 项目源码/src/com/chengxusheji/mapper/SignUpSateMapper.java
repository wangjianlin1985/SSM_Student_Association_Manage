package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.SignUpSate;

public interface SignUpSateMapper {
	/*添加审核状态信息*/
	public void addSignUpSate(SignUpSate signUpSate) throws Exception;

	/*按照查询条件分页查询审核状态记录*/
	public ArrayList<SignUpSate> querySignUpSate(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有审核状态记录*/
	public ArrayList<SignUpSate> querySignUpSateList(@Param("where") String where) throws Exception;

	/*按照查询条件的审核状态记录数*/
	public int querySignUpSateCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条审核状态记录*/
	public SignUpSate getSignUpSate(int stateId) throws Exception;

	/*更新审核状态记录*/
	public void updateSignUpSate(SignUpSate signUpSate) throws Exception;

	/*删除审核状态记录*/
	public void deleteSignUpSate(int stateId) throws Exception;

}
