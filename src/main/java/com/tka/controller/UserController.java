package com.tka.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.tka.entity.User;
import com.tka.service.EmailService;
import com.tka.service.LoanAppService;
import com.tka.service.UserService;

@Controller
public class UserController 
{
	@Autowired
	UserService userService;
	
	@Autowired
	LoanAppService loanAppService;
	
	@Autowired
    private EmailService emailService;
	
	@GetMapping("/register")
    public String registrationPage()
   {
	 return "register";
   }
	
	@PostMapping("/registeration")
	public String registerUser(Model model ,@ModelAttribute User user)
	{
		String message = userService.registerUser(user);
		model.addAttribute("msg", message);
		return "loginUser";
	}
	
	@GetMapping("/checkCIBILscore")
	public String checkCIBIL()
	{
		return "checkCIBILscore";
	}
	
	 @PostMapping("/check-CIBIL-score")
	    public String checkCibilScore(User user, Model model) 
	 {
		 String panInvalid = "Invalid PanCard";
		   boolean flag = userService.validatePanCard(user);
		   boolean flag1 = userService.validatePanCardUnique(user);
		   if(flag1 == false)
		   {
			   model.addAttribute("panInvalid", panInvalid);
		   }
		   if(flag == true && flag1 == true)
		   {
	        String username = userService.generateUsername(user.getFname(), user.getLname(), user.getMobile());
	        String password = userService.generatePassword();

	        user.setUsername(username);
	        user.setPassword(password);  

	        int cibilScore = loanAppService.generateCibilScore();
	        user.setCibilScore(cibilScore);

	        userService.registerUser(user);

	        emailService.sendCredentials("rasikarajput2122@gmail.com", username, password);

	        model.addAttribute("cibilScore", cibilScore);
	        return "showCIBILscore";  
		   }
		   else
		   {
			   return "checkCIBILscore";
		   }
	    }

}
