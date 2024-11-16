package com.tka.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.tka.entity.User;
import com.tka.service.UserService;

@Controller
public class LoginController 
{

    @Autowired
    UserService userService;

    private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    
    
    @PostMapping("login")
    public String loginUser(String emailOrUsername, String password, Model model) 
    {
        User user = userService.findUserByEmailOrUsername(emailOrUsername);

        if (user == null) 
        {
            model.addAttribute("errorMessage", "User does not exist!");
            return "loginUser"; 
        }
 
        if (user.getStatus().equals("InActive"))
        {
            model.addAttribute("errorMessage", "Your account is locked. Please contact support.");
            return "loginUser";   
        }
        
        if(user.getUser_role().equals("ROLE_ADMIN"))
        {
            if (!passwordEncoder.matches(password, user.getPassword())) 
          {
        	model.addAttribute("errorMessage", "Invalid password!");
        	 return "loginUser"; 
          }
            else
            {
             return "redirect:/admin/dashboard";
            }
        }
        
        if(user.getUser_role().equals("ROLE_USER"))
        {
        if (!passwordEncoder.matches(password, user.getPassword())) 
        {
        	int remainAttempts = (2 - user.getFailed_attempts());
        	if(remainAttempts == 0)
        	{
                model.addAttribute("errorMessage", "Your account is locked. Please contact support.");
        	}
        	if(remainAttempts > 0)
        	{
            model.addAttribute("errorMessage", "Invalid password. You have " +remainAttempts +" attempt remaining..!!");
        	}
            userService.updateFailedAttempts(emailOrUsername);
            return "loginUser";   
        }
        }
            userService.resetFailedAttempts(emailOrUsername);
       
        	model.addAttribute("successMessage", "Welcome " + user.getFname() + " " + user.getLname() + "!");
        	return "home";
    }  
   
    @PostMapping("/logout")
    public String logout()
   {
	 return "redirect:/login";
   }
    
   @GetMapping("/login")
   public String login()
   {
	   return "loginUser";
   }
}


