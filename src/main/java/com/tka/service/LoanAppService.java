package com.tka.service;

import java.util.List;
import java.util.Random;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tka.dao.LoanAppDao;
import com.tka.entity.LoanApplication;

@Service
public class LoanAppService 
{
@Autowired
LoanAppDao loanAppDao;
	
	public boolean submitLoanApplication(LoanApplication loanApp) 
	{
		return loanAppDao.submitLoanApplication(loanApp);
	}

	public List<LoanApplication> getAllLoanApps() 
	{
		return loanAppDao.getAllLoanApps();
	}

    public boolean validatePan(String panCardNumber) 
	 {
		        String panPattern = "[A-Z]{5}[0-9]{4}[A-Z]{1}";
		        return Pattern.matches(panPattern, panCardNumber);
     }

    public int generateCibilScore() 
    {
		        Random random = new Random();
		        return random.nextInt(301) + 600;
   }

    public double calculateInterestRate(String loanType, int cibilScore) 
	 {
		        double interestRate = 0.0;

		        switch (loanType) 
		        {
		            case "Home":
		            {
		                interestRate = getIntRateByCibilScore(cibilScore, 6.5, 8.5);
		                break;
		            }
		            
		            case "Personal":
		            {
		                interestRate = getIntRateByCibilScore(cibilScore, 9.0, 12.0);
		                break;
		            }
		            
		            case "Education":
		            {
		                interestRate = getIntRateByCibilScore(cibilScore, 4.0, 6.0);
		                break;
		            }
		            
		            case "Car":
		            {
		                interestRate = getIntRateByCibilScore(cibilScore, 7.0, 9.0);
		                break;
		            }
		            		            
		        }

		        return interestRate;
	 }

	 private double getIntRateByCibilScore(int cibilScore, double minRate, double maxRate) 
	 { 
		double interestRate = minRate + (maxRate - minRate) * (900 - cibilScore) / 300;
		return interestRate;
	  }
	 
	 
}

