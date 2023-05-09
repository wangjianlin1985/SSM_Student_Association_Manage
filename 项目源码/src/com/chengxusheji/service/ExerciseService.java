package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Team;
import com.chengxusheji.po.Exercise;

import com.chengxusheji.mapper.ExerciseMapper;
@Service
public class ExerciseService {

	@Resource ExerciseMapper exerciseMapper;
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

    /*添加活动记录*/
    public void addExercise(Exercise exercise) throws Exception {
    	exerciseMapper.addExercise(exercise);
    }

    /*按照查询条件分页查询活动记录*/
    public ArrayList<Exercise> queryExercise(String exerciseName,String exerciseDate,Team teamObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!exerciseName.equals("")) where = where + " and t_exercise.exerciseName like '%" + exerciseName + "%'";
    	if(!exerciseDate.equals("")) where = where + " and t_exercise.exerciseDate like '%" + exerciseDate + "%'";
    	if(null != teamObj &&  teamObj.getTeamUserName() != null  && !teamObj.getTeamUserName().equals(""))  where += " and t_exercise.teamObj='" + teamObj.getTeamUserName() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return exerciseMapper.queryExercise(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Exercise> queryExercise(String exerciseName,String exerciseDate,Team teamObj) throws Exception  { 
     	String where = "where 1=1";
    	if(!exerciseName.equals("")) where = where + " and t_exercise.exerciseName like '%" + exerciseName + "%'";
    	if(!exerciseDate.equals("")) where = where + " and t_exercise.exerciseDate like '%" + exerciseDate + "%'";
    	if(null != teamObj &&  teamObj.getTeamUserName() != null && !teamObj.getTeamUserName().equals(""))  where += " and t_exercise.teamObj='" + teamObj.getTeamUserName() + "'";
    	return exerciseMapper.queryExerciseList(where);
    }

    /*查询所有活动记录*/
    public ArrayList<Exercise> queryAllExercise()  throws Exception {
        return exerciseMapper.queryExerciseList("where 1=1");
    }
    
    /*社团负责人查询所有本社团活动记录*/
    public ArrayList<Exercise> queryAllExercise(String stUserName)  throws Exception {
        return exerciseMapper.queryExerciseList("where t_team.teamUserName='" + stUserName + "'");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String exerciseName,String exerciseDate,Team teamObj) throws Exception {
     	String where = "where 1=1";
    	if(!exerciseName.equals("")) where = where + " and t_exercise.exerciseName like '%" + exerciseName + "%'";
    	if(!exerciseDate.equals("")) where = where + " and t_exercise.exerciseDate like '%" + exerciseDate + "%'";
    	if(null != teamObj &&  teamObj.getTeamUserName() != null && !teamObj.getTeamUserName().equals(""))  where += " and t_exercise.teamObj='" + teamObj.getTeamUserName() + "'";
        recordNumber = exerciseMapper.queryExerciseCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取活动记录*/
    public Exercise getExercise(int exerciseId) throws Exception  {
        Exercise exercise = exerciseMapper.getExercise(exerciseId);
        return exercise;
    }

    /*更新活动记录*/
    public void updateExercise(Exercise exercise) throws Exception {
        exerciseMapper.updateExercise(exercise);
    }

    /*删除一条活动记录*/
    public void deleteExercise (int exerciseId) throws Exception {
        exerciseMapper.deleteExercise(exerciseId);
    }

    /*删除多条活动信息*/
    public int deleteExercises (String exerciseIds) throws Exception {
    	String _exerciseIds[] = exerciseIds.split(",");
    	for(String _exerciseId: _exerciseIds) {
    		exerciseMapper.deleteExercise(Integer.parseInt(_exerciseId));
    	}
    	return _exerciseIds.length;
    }
}
