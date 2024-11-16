package com.tka.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tka.entity.LoanApplication;
import com.tka.entity.User;
import com.tka.service.LoanAppService;
import com.tka.service.UserService;

@Controller
public class AdminController 
{
	@Autowired
	UserService userService;
	
	@Autowired
	LoanAppService loanAppService;
	
	@GetMapping("/admin/dashboard")
	public String getAllUsers(Model model)
	{
		List<User> users = userService.getAllUsers();
		List<LoanApplication> loanApps = loanAppService.getAllLoanApps();
	     model.addAttribute("users", users);
	     model.addAttribute("loanApps", loanApps);
	        return "admin_dashboard";
	}
	
	@GetMapping("/view-user-info")
	public String getUserByUsername(@RequestParam String email, Model model)
	{
		User user = userService.getUserByUsername(email);
		 model.addAttribute("user", user);
	     return "view-user-info";
	}
	
	@PostMapping("/delete-user")
    public void deleteUser(@RequestParam String email) 
	{
           userService.deleteUserByEmail(email);         
    }
	
	@PostMapping("/update-user-status")
    public void updateUserStatus(@RequestParam String action, String email) 
	{
           userService.updateUserStatus(action, email);         
    }
	
	@GetMapping("/loanApplicationForm")
	public String loanApplication()
	{
		return "loanApplicationForm";
	}
	
	@PostMapping("/approve-loan")
	public void approveLoan(@RequestParam int loanId) 
	{
	    userService.approveLoan(loanId);
	}
	
	@PostMapping("/reject-loan")
    public void rejectLoan(@RequestParam int loanId) 
	{
		 userService.rejectLoan(loanId);  

    }
	
	@GetMapping("/view-loan-info")
	public String getLoanByLoanID(@RequestParam int loanId, Model model)
	{
		LoanApplication loanApp = userService.getLoanByLoanID(loanId);
		 model.addAttribute("loanApp", loanApp);
	     return "view-loan-info";
	}
}
