package com.tka.entity;

import javax.persistence.Column;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class CIBIL 
{
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
    
    @Column(unique = true, nullable = false, length = 10)
    private String panCard;
}
