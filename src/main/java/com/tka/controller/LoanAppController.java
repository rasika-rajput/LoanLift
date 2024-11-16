package com.tka.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.tka.dao.UserDao;
import com.tka.entity.LoanApplication;
import com.tka.entity.User;
import com.tka.service.EmailService;
import com.tka.service.LoanAppService;

@Controller
public class LoanAppController 
{
    @Autowired
    LoanAppService loanAppService;

    @Autowired
    UserDao userDao;

    @Autowired
    EmailService emailService;

    @PostMapping("/loanApplicationForm")
    public String submitLoanApplication(@ModelAttribute LoanApplication loanApp, String username, Model model) 
    {
    	User user = userDao.findUserByEmailOrUsername(username);
    	int cibilScore = 0;
    	if(user.getCibilScore() == 0)
    	{
    	 cibilScore = loanAppService.generateCibilScore();
    	}
    	else
    	{
    		cibilScore = user.getCibilScore();	
    	}
    	
    	String errorMsg = "Please enter a valid PAN number.";
    	if(!loanApp.getPanCard().equals(user.getPanCard()))
    			{
    		      model.addAttribute("errorMsg", errorMsg);
    		      return "loanApplicationForm";
    			}
    	loanApp.setUser(user);
    	user.setCibilScore(cibilScore);
    	userDao.updateUser(user);

    	double interestRate = loanAppService.calculateInterestRate(loanApp.getLoanType(), cibilScore);

    	loanApp.setInterestRate(interestRate);

    	boolean flag = loanAppService.submitLoanApplication(loanApp);

    	if (flag) 
    	{
    	    String name = user.getFname();
    	    double amount = loanApp.getLoanAmount();
    	    String subject = "Your Loan Application has been Submitted!";
    	    String body = "Dear " + name + ", your loan application for Rs." + amount + " has been submitted successfully";
    	    emailService.sendEmailNotification("rasikarajput2122@gmail.com", subject, body);

    	    model.addAttribute("panCard", loanApp.getPanCard());
    	    model.addAttribute("loanType", loanApp.getLoanType());
    	    model.addAttribute("cibilScore", user.getCibilScore());
    	    model.addAttribute("interestRate", interestRate);

    	    return "loanAppSuccess";
    	} 
    	else 
    	{
    	    return "loanApplicationForm";
    	}
    }


    @GetMapping("/applyLoan")
    public String applyLoan() 
    {
        return "loanApplicationForm";
    }

    @GetMapping("/loanAppSuccess")
    public String loanAppSuccess() 
    {
        return "loanAppSuccess";
    }

    @PostMapping("/calculateInterest")
    public String calculateInterest(@RequestParam String panCardNumber, @RequestParam String loanType, Model model) 
    {
        if (!loanAppService.validatePan(panCardNumber)) 
        {
            model.addAttribute("error", "Invalid PAN Card Number");
            return "loanApplicationForm";
        }

        int cibilScore = loanAppService.generateCibilScore();
        double interestRate = loanAppService.calculateInterestRate(loanType, cibilScore);

        model.addAttribute("panCardNumber", panCardNumber);
        model.addAttribute("loanType", loanType);
        model.addAttribute("cibilScore", cibilScore);
        model.addAttribute("interestRate", interestRate);

        return "loanAppSuccess";  
    }
}
