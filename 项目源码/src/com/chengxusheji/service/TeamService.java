package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;

import com.chengxusheji.po.Admin;
import com.chengxusheji.po.Team;

import com.chengxusheji.mapper.TeamMapper;
@Service
public class TeamService {

	@Resource TeamMapper teamMapper;
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

    /*添加社团记录*/
    public void addTeam(Team team) throws Exception {
    	teamMapper.addTeam(team);
    }

    /*按照查询条件分页查询社团记录*/
    public ArrayList<Team> queryTeam(String teamUserName,String teamName,String shoolName,String area,String mainUnit,String email,String telephone,String chargeMan,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!teamUserName.equals("")) where = where + " and t_team.teamUserName like '%" + teamUserName + "%'";
    	if(!teamName.equals("")) where = where + " and t_team.teamName like '%" + teamName + "%'";
    	if(!shoolName.equals("")) where = where + " and t_team.shoolName like '%" + shoolName + "%'";
    	if(!area.equals("")) where = where + " and t_team.area like '%" + area + "%'";
    	if(!mainUnit.equals("")) where = where + " and t_team.mainUnit like '%" + mainUnit + "%'";
    	if(!email.equals("")) where = where + " and t_team.email like '%" + email + "%'";
    	if(!telephone.equals("")) where = where + " and t_team.telephone like '%" + telephone + "%'";
    	if(!chargeMan.equals("")) where = where + " and t_team.chargeMan like '%" + chargeMan + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return teamMapper.queryTeam(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Team> queryTeam(String teamUserName,String teamName,String shoolName,String area,String mainUnit,String email,String telephone,String chargeMan) throws Exception  { 
     	String where = "where 1=1";
    	if(!teamUserName.equals("")) where = where + " and t_team.teamUserName like '%" + teamUserName + "%'";
    	if(!teamName.equals("")) where = where + " and t_team.teamName like '%" + teamName + "%'";
    	if(!shoolName.equals("")) where = where + " and t_team.shoolName like '%" + shoolName + "%'";
    	if(!area.equals("")) where = where + " and t_team.area like '%" + area + "%'";
    	if(!mainUnit.equals("")) where = where + " and t_team.mainUnit like '%" + mainUnit + "%'";
    	if(!email.equals("")) where = where + " and t_team.email like '%" + email + "%'";
    	if(!telephone.equals("")) where = where + " and t_team.telephone like '%" + telephone + "%'";
    	if(!chargeMan.equals("")) where = where + " and t_team.chargeMan like '%" + chargeMan + "%'";
    	return teamMapper.queryTeamList(where);
    }

    /*查询所有社团记录*/
    public ArrayList<Team> queryAllTeam()  throws Exception {
        return teamMapper.queryTeamList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String teamUserName,String teamName,String shoolName,String area,String mainUnit,String email,String telephone,String chargeMan) throws Exception {
     	String where = "where 1=1";
    	if(!teamUserName.equals("")) where = where + " and t_team.teamUserName like '%" + teamUserName + "%'";
    	if(!teamName.equals("")) where = where + " and t_team.teamName like '%" + teamName + "%'";
    	if(!shoolName.equals("")) where = where + " and t_team.shoolName like '%" + shoolName + "%'";
    	if(!area.equals("")) where = where + " and t_team.area like '%" + area + "%'";
    	if(!mainUnit.equals("")) where = where + " and t_team.mainUnit like '%" + mainUnit + "%'";
    	if(!email.equals("")) where = where + " and t_team.email like '%" + email + "%'";
    	if(!telephone.equals("")) where = where + " and t_team.telephone like '%" + telephone + "%'";
    	if(!chargeMan.equals("")) where = where + " and t_team.chargeMan like '%" + chargeMan + "%'";
        recordNumber = teamMapper.queryTeamCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取社团记录*/
    public Team getTeam(String teamUserName) throws Exception  {
        Team team = teamMapper.getTeam(teamUserName);
        return team;
    }

    /*更新社团记录*/
    public void updateTeam(Team team) throws Exception {
        teamMapper.updateTeam(team);
    }

    /*删除一条社团记录*/
    public void deleteTeam (String teamUserName) throws Exception {
        teamMapper.deleteTeam(teamUserName);
    }

    /*删除多条社团信息*/
    public int deleteTeams (String teamUserNames) throws Exception {
    	String _teamUserNames[] = teamUserNames.split(",");
    	for(String _teamUserName: _teamUserNames) {
    		teamMapper.deleteTeam(_teamUserName);
    	}
    	return _teamUserNames.length;
    }
	 
	
	/*保存业务逻辑错误信息字段*/
	private String errMessage;
	public String getErrMessage() { return this.errMessage; }
	
	/*验证用户登录*/
	public boolean checkLogin(Admin admin) throws Exception { 
		Team db_team = (Team) teamMapper.getTeam(admin.getUsername());
		if(db_team == null) { 
			this.errMessage = " 账号不存在 ";
			System.out.print(this.errMessage);
			return false;
		} else if( !db_team.getPassword().equals(admin.getPassword())) {
			this.errMessage = " 密码不正确! ";
			System.out.print(this.errMessage);
			return false;
		}
		
		return true;
	}
}
