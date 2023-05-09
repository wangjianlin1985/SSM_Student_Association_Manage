package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Exercise;

public interface ExerciseMapper {
	/*添加活动信息*/
	public void addExercise(Exercise exercise) throws Exception;

	/*按照查询条件分页查询活动记录*/
	public ArrayList<Exercise> queryExercise(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有活动记录*/
	public ArrayList<Exercise> queryExerciseList(@Param("where") String where) throws Exception;

	/*按照查询条件的活动记录数*/
	public int queryExerciseCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条活动记录*/
	public Exercise getExercise(int exerciseId) throws Exception;

	/*更新活动记录*/
	public void updateExercise(Exercise exercise) throws Exception;

	/*删除活动记录*/
	public void deleteExercise(int exerciseId) throws Exception;

}
