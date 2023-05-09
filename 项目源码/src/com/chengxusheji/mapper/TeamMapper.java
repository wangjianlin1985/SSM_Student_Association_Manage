package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Team;

public interface TeamMapper {
	/*添加社团信息*/
	public void addTeam(Team team) throws Exception;

	/*按照查询条件分页查询社团记录*/
	public ArrayList<Team> queryTeam(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有社团记录*/
	public ArrayList<Team> queryTeamList(@Param("where") String where) throws Exception;

	/*按照查询条件的社团记录数*/
	public int queryTeamCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条社团记录*/
	public Team getTeam(String teamUserName) throws Exception;

	/*更新社团记录*/
	public void updateTeam(Team team) throws Exception;

	/*删除社团记录*/
	public void deleteTeam(String teamUserName) throws Exception;

}
