package com.tka.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.tka.service.UserService;

@Controller
public class PasswordController 
{
	@Autowired
	UserService userService;
	
	@GetMapping("/forget-password")
    public String forgetPassword()
   {
	 return "forget-password";
   }
	
	@GetMapping("/resetMyPassword")
    public String resetMyPassword()
   {
	 return "reset-password";
   }
	
	@PostMapping("/reset-password-link")
	public String resetPassword(String identifier)
	{
		 userService.resetPassword(identifier);
		 return "reset-password";
	}
	
	@PostMapping("/reset-password")
	public void updatePassword(@Validated String newPassword, String confirmPassword, Model model)
	{
        String passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
		 
		 if (!newPassword.matches(passwordPattern) && newPassword.length() < 8) 
		 {
			 model.addAttribute("errorMessage", "Password does not meet the complexity requirements.");
		 }
		 if(!newPassword.equals(confirmPassword))
		 {
			 model.addAttribute("errorMessage", "Passwords do not match."); 
		 }
		 boolean isUpdated = userService.updatePassword(newPassword);
		 if(isUpdated == true)
		 {
			 model.addAttribute("message", "Password changed successfully.");
	     }
	      
	   
	}
}

