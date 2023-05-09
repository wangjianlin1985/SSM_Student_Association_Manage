package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class UserInfo {
    /*用户名*/
    @NotEmpty(message="用户名不能为空")
    private String user_name;
    public String getUser_name(){
        return user_name;
    }
    public void setUser_name(String user_name){
        this.user_name = user_name;
    }

    /*登录密码*/
    @NotEmpty(message="登录密码不能为空")
    private String password;
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    /*姓名*/
    @NotEmpty(message="姓名不能为空")
    private String name;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    /*性别*/
    @NotEmpty(message="性别不能为空")
    private String sex;
    public String getSex() {
        return sex;
    }
    public void setSex(String sex) {
        this.sex = sex;
    }

    /*用户照片*/
    private String userPhoto;
    public String getUserPhoto() {
        return userPhoto;
    }
    public void setUserPhoto(String userPhoto) {
        this.userPhoto = userPhoto;
    }

    /*学校学院*/
    @NotEmpty(message="学校学院不能为空")
    private String schoolName;
    public String getSchoolName() {
        return schoolName;
    }
    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    /*年级专业*/
    @NotEmpty(message="年级专业不能为空")
    private String specialInfo;
    public String getSpecialInfo() {
        return specialInfo;
    }
    public void setSpecialInfo(String specialInfo) {
        this.specialInfo = specialInfo;
    }

    /*民族*/
    private String nation;
    public String getNation() {
        return nation;
    }
    public void setNation(String nation) {
        this.nation = nation;
    }

    /*政治面貌*/
    private String politicalStatus;
    public String getPoliticalStatus() {
        return politicalStatus;
    }
    public void setPoliticalStatus(String politicalStatus) {
        this.politicalStatus = politicalStatus;
    }

    /*出生日期*/
    @NotEmpty(message="出生日期不能为空")
    private String birthday;
    public String getBirthday() {
        return birthday;
    }
    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    /*联系电话*/
    @NotEmpty(message="联系电话不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*联系地址*/
    @NotEmpty(message="联系地址不能为空")
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    /*有兴趣的项目*/
    private String interest;
    public String getInterest() {
        return interest;
    }
    public void setInterest(String interest) {
        this.interest = interest;
    }

    /*个人介绍*/
    private String introduce;
    public String getIntroduce() {
        return introduce;
    }
    public void setIntroduce(String introduce) {
        this.introduce = introduce;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonUserInfo=new JSONObject(); 
		jsonUserInfo.accumulate("user_name", this.getUser_name());
		jsonUserInfo.accumulate("password", this.getPassword());
		jsonUserInfo.accumulate("name", this.getName());
		jsonUserInfo.accumulate("sex", this.getSex());
		jsonUserInfo.accumulate("userPhoto", this.getUserPhoto());
		jsonUserInfo.accumulate("schoolName", this.getSchoolName());
		jsonUserInfo.accumulate("specialInfo", this.getSpecialInfo());
		jsonUserInfo.accumulate("nation", this.getNation());
		jsonUserInfo.accumulate("politicalStatus", this.getPoliticalStatus());
		jsonUserInfo.accumulate("birthday", this.getBirthday().length()>19?this.getBirthday().substring(0,19):this.getBirthday());
		jsonUserInfo.accumulate("telephone", this.getTelephone());
		jsonUserInfo.accumulate("address", this.getAddress());
		jsonUserInfo.accumulate("interest", this.getInterest());
		jsonUserInfo.accumulate("introduce", this.getIntroduce());
		return jsonUserInfo;
    }}