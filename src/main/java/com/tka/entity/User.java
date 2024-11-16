package com.tka.entity;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;


@Entity
public class User
{
    @Id
    @NotBlank(message = "Username is required")
    @Size(max = 30, message = "Username cannot exceed 30 characters")
    private String username;
    
    @NotBlank(message = "First Name is required")
    @Size(max = 50, message = "First Name cannot exceed 50 characters")
    private String fname;

    @NotBlank(message = "Last Name is required")
    @Size(max = 50, message = "Last Name cannot exceed 50 characters")
    private String lname;

    @NotBlank(message = "Mobile Number is required")
    @Pattern(regexp = "^[0-9]{10}$", message = "Mobile number must be 10 digits")
    @Column( name = "mobile", unique = true)
    private String mobile;

    @NotBlank(message = "Email is required")
    @Email(message = "Email should be valid")
    @Column( name = "email", unique = true)
    private String email;

    @NotBlank(message = "Location is required")
    private String location;

    private LocalDateTime lastModifiedDate;

    private String status = "Active"; 

    @NotBlank(message = "Password is required")
    @Size(min = 8, message = "Password must be at least 8 characters long")
    private String password;

    private int failed_attempts = 0;
    
    private String user_role = "ROLE_USER";
    
    @Column(unique = true, nullable = false, length = 10)
    private String panCard;

    @Column(nullable = false)
    private int cibilScore;
    
    public User() {
        this.lastModifiedDate = LocalDateTime.now();
    }

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getLname() {
		return lname;
	}

	public void setLname(String lname) {
		this.lname = lname;
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

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public LocalDateTime getLastModifiedDate() {
		return lastModifiedDate;
	}

	public void setLastModifiedDate(LocalDateTime lastModifiedDate) {
		this.lastModifiedDate = lastModifiedDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getFailed_attempts() {
		return failed_attempts;
	}

	public void setFailed_attempts(int failed_attempts) {
		this.failed_attempts = failed_attempts;
	}

	
	public String getUser_role() {
		return user_role;
	}

	public void setUser_role(String user_role) {
		this.user_role = user_role;
	}

	
	public String getPanCard() {
		return panCard;
	}

	public void setPanCard(String panCard) {
		this.panCard = panCard;
	}

	public int getCibilScore() {
		return cibilScore;
	}

	public void setCibilScore(int cibilScore) {
		this.cibilScore = cibilScore;
	}

	@Override
	public String toString() {
		return "User [username=" + username + ", fname=" + fname + ", lname=" + lname + ", mobile=" + mobile
				+ ", email=" + email + ", location=" + location + ", lastModifiedDate=" + lastModifiedDate + ", status="
				+ status + ", password=" + password + ", failed_attempts=" + failed_attempts + ", user_role="
				+ user_role + ", panCard=" + panCard + ", cibilScore=" + cibilScore + "]";
	}

	

	
	
    
    
}

