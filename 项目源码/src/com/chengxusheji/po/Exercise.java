package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Exercise {
    /*活动id*/
    private Integer exerciseId;
    public Integer getExerciseId(){
        return exerciseId;
    }
    public void setExerciseId(Integer exerciseId){
        this.exerciseId = exerciseId;
    }

    /*活动名称*/
    @NotEmpty(message="活动名称不能为空")
    private String exerciseName;
    public String getExerciseName() {
        return exerciseName;
    }
    public void setExerciseName(String exerciseName) {
        this.exerciseName = exerciseName;
    }

    /*活动开始时间*/
    @NotEmpty(message="活动开始时间不能为空")
    private String exerciseDate;
    public String getExerciseDate() {
        return exerciseDate;
    }
    public void setExerciseDate(String exerciseDate) {
        this.exerciseDate = exerciseDate;
    }

    /*活动时长*/
    @NotEmpty(message="活动时长不能为空")
    private String serviceTime;
    public String getServiceTime() {
        return serviceTime;
    }
    public void setServiceTime(String serviceTime) {
        this.serviceTime = serviceTime;
    }

    /*活动地点*/
    @NotEmpty(message="活动地点不能为空")
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    /*参与人数*/
    @NotNull(message="必须输入参与人数")
    private Integer personNum;
    public Integer getPersonNum() {
        return personNum;
    }
    public void setPersonNum(Integer personNum) {
        this.personNum = personNum;
    }

    /*活动内容*/
    @NotEmpty(message="活动内容不能为空")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*主办社团*/
    private Team teamObj;
    public Team getTeamObj() {
        return teamObj;
    }
    public void setTeamObj(Team teamObj) {
        this.teamObj = teamObj;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonExercise=new JSONObject(); 
		jsonExercise.accumulate("exerciseId", this.getExerciseId());
		jsonExercise.accumulate("exerciseName", this.getExerciseName());
		jsonExercise.accumulate("exerciseDate", this.getExerciseDate().length()>19?this.getExerciseDate().substring(0,19):this.getExerciseDate());
		jsonExercise.accumulate("serviceTime", this.getServiceTime());
		jsonExercise.accumulate("address", this.getAddress());
		jsonExercise.accumulate("personNum", this.getPersonNum());
		jsonExercise.accumulate("content", this.getContent());
		jsonExercise.accumulate("teamObj", this.getTeamObj().getTeamName());
		jsonExercise.accumulate("teamObjPri", this.getTeamObj().getTeamUserName());
		return jsonExercise;
    }}