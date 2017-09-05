
package com.bean;
public class Teacher implements java.io.Serializable{
	
	private String teacher_no;
	private String teacher_name;
	private String password;
	private String gender;
	private String birthday;
	private String education;
	private String title;
	private String edu_university;
	private String degree;
	private String deg_university;
	private String research_dir;
	private String tel;
	private String mobile;
	private String email;
	private String teacher_note;
	private int is_delete;
	public String getTeacher_no() {
		return teacher_no;
	}
	public void setTeacher_no(String teacher_no) {
		this.teacher_no = teacher_no;
	}
	public String getTeacher_name() {
		return teacher_name;
	}
	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getEducation() {
		return education;
	}
	public void setEducation(String education) {
		this.education = education;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getEdu_university() {
		return edu_university;
	}
	public void setEdu_university(String edu_university) {
		this.edu_university = edu_university;
	}
	public String getDegree() {
		return degree;
	}
	public void setDegree(String degree) {
		this.degree = degree;
	}
	public String getDeg_university() {
		return deg_university;
	}
	public void setDeg_university(String deg_university) {
		this.deg_university = deg_university;
	}
	public String getResearch_dir() {
		return research_dir;
	}
	public void setResearch_dir(String research_dir) {
		this.research_dir = research_dir;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTeacher_note() {
		return teacher_note;
	}
	public void setTeacher_note(String teacher_note) {
		this.teacher_note = teacher_note;
	}
	public int getIs_delete() {
		return is_delete;
	}
	public void setIs_delete(int is_delete) {
		this.is_delete = is_delete;
	}
	
}