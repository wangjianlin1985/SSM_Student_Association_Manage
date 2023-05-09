package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class SignUp {
    /*报名id*/
    private Integer signUpId;
    public Integer getSignUpId(){
        return signUpId;
    }
    public void setSignUpId(Integer signUpId){
        this.signUpId = signUpId;
    }

    /*社团活动*/
    private Exercise exerciseObj;
    public Exercise getExerciseObj() {
        return exerciseObj;
    }
    public void setExerciseObj(Exercise exerciseObj) {
        this.exerciseObj = exerciseObj;
    }

    /*报名用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*报名时间*/
    private String signUpTime;
    public String getSignUpTime() {
        return signUpTime;
    }
    public void setSignUpTime(String signUpTime) {
        this.signUpTime = signUpTime;
    }

    /*审核状态*/
    private SignUpSate signUpState;
    public SignUpSate getSignUpState() {
        return signUpState;
    }
    public void setSignUpState(SignUpSate signUpState) {
        this.signUpState = signUpState;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonSignUp=new JSONObject(); 
		jsonSignUp.accumulate("signUpId", this.getSignUpId());
		jsonSignUp.accumulate("exerciseObj", this.getExerciseObj().getExerciseName());
		jsonSignUp.accumulate("exerciseObjPri", this.getExerciseObj().getExerciseId());
		jsonSignUp.accumulate("userObj", this.getUserObj().getName());
		jsonSignUp.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonSignUp.accumulate("signUpTime", this.getSignUpTime());
		jsonSignUp.accumulate("signUpState", this.getSignUpState().getStateName());
		jsonSignUp.accumulate("signUpStatePri", this.getSignUpState().getStateId());
		return jsonSignUp;
    }}