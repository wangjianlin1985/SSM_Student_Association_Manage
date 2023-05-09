package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Team {
    /*社团管理员*/
    @NotEmpty(message="社团管理员不能为空")
    private String teamUserName;
    public String getTeamUserName(){
        return teamUserName;
    }
    public void setTeamUserName(String teamUserName){
        this.teamUserName = teamUserName;
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

    /*社团名称*/
    @NotEmpty(message="社团名称不能为空")
    private String teamName;
    public String getTeamName() {
        return teamName;
    }
    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    /*所属院校*/
    @NotEmpty(message="所属院校不能为空")
    private String shoolName;
    public String getShoolName() {
        return shoolName;
    }
    public void setShoolName(String shoolName) {
        this.shoolName = shoolName;
    }

    /*所在区域*/
    @NotEmpty(message="所在区域不能为空")
    private String area;
    public String getArea() {
        return area;
    }
    public void setArea(String area) {
        this.area = area;
    }

    /*社团Logo*/
    private String teamPhoto;
    public String getTeamPhoto() {
        return teamPhoto;
    }
    public void setTeamPhoto(String teamPhoto) {
        this.teamPhoto = teamPhoto;
    }

    /*主管单位*/
    @NotEmpty(message="主管单位不能为空")
    private String mainUnit;
    public String getMainUnit() {
        return mainUnit;
    }
    public void setMainUnit(String mainUnit) {
        this.mainUnit = mainUnit;
    }

    /*成立日期*/
    @NotEmpty(message="成立日期不能为空")
    private String birthDate;
    public String getBirthDate() {
        return birthDate;
    }
    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    /*电子邮箱*/
    @NotEmpty(message="电子邮箱不能为空")
    private String email;
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    /*负责人电话*/
    @NotEmpty(message="负责人电话不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*负责人姓名*/
    @NotEmpty(message="负责人姓名不能为空")
    private String chargeMan;
    public String getChargeMan() {
        return chargeMan;
    }
    public void setChargeMan(String chargeMan) {
        this.chargeMan = chargeMan;
    }

    /*详细地址*/
    @NotEmpty(message="详细地址不能为空")
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    /*社团成员*/
    @NotEmpty(message="社团成员不能为空")
    private String personList;
    public String getPersonList() {
        return personList;
    }
    public void setPersonList(String personList) {
        this.personList = personList;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonTeam=new JSONObject(); 
		jsonTeam.accumulate("teamUserName", this.getTeamUserName());
		jsonTeam.accumulate("password", this.getPassword());
		jsonTeam.accumulate("teamName", this.getTeamName());
		jsonTeam.accumulate("shoolName", this.getShoolName());
		jsonTeam.accumulate("area", this.getArea());
		jsonTeam.accumulate("teamPhoto", this.getTeamPhoto());
		jsonTeam.accumulate("mainUnit", this.getMainUnit());
		jsonTeam.accumulate("birthDate", this.getBirthDate().length()>19?this.getBirthDate().substring(0,19):this.getBirthDate());
		jsonTeam.accumulate("email", this.getEmail());
		jsonTeam.accumulate("telephone", this.getTelephone());
		jsonTeam.accumulate("chargeMan", this.getChargeMan());
		jsonTeam.accumulate("address", this.getAddress());
		jsonTeam.accumulate("personList", this.getPersonList());
		return jsonTeam;
    }}