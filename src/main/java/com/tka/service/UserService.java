package com.tka.service;

import java.security.SecureRandom;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tka.dao.UserDao;
import com.tka.entity.LoanApplication;
import com.tka.entity.User;

@Service
public class UserService
{
	@Autowired
	UserDao userDao;

	public String registerUser(User user) 
	{
		boolean isRegistered = userDao.registerUser(user);
		if(isRegistered)
		{
			return "Registration Successful...!!!";
		}
		else
		{
			return "Registration Failed...!!!";
		}
	}
	
	public User findUserByEmailOrUsername(String emailOrUsername) 
	{
		return userDao.findUserByEmailOrUsername(emailOrUsername);
	}

	public void updateFailedAttempts(String emailOrUsername) 
	{
		userDao.updateFailedAttempts(emailOrUsername);
	}

	public void resetFailedAttempts(String emailOrUsername) 
	{
		userDao.resetFailedAttempts(emailOrUsername);
	}

	public void resetPassword(String identifier) 
	{
		 userDao.resetPassword(identifier);
	}

	public boolean updatePassword(String newPassword) 
	{
		return userDao.updatePassword(newPassword);
	}

	public List<User> getAllUsers() 
	{
		return userDao.getAllUsers();
	}

	public User getUserByUsername(String email)
	{
		return userDao.getUserByUsername(email);
	}

	public void deleteUserByEmail(String email) 
	{
		userDao.deleteUserByEmail(email);
	}

	public void updateUserStatus(String action, String email) 
	{
		userDao.updateUserStatus(action, email);
	}

	public void approveLoan(int loanId) 
	{
		 userDao.approveLoan(loanId);
	}

	public void rejectLoan(int loanId) 
	{
		 userDao.rejectLoan(loanId);
	}

	public LoanApplication getLoanByLoanID(int loanId)
	{
		return userDao.getLoanByLoanID(loanId);
	}
	
	 public String generateUsername(String fname, String lname, String mobile) 
	 {
	        return fname.substring(0, 3) + lname.substring(0, 3) + mobile.substring(mobile.length() - 4);
	 }

	    public String generatePassword() 
	    {
	        String upperCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	        String lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
	        String numbers = "0123456789";
	        String specialCharacters = "!@#$%^&*()";

	        String combinedChars = upperCaseLetters + lowerCaseLetters + numbers + specialCharacters;
	        SecureRandom random = new SecureRandom();
	        StringBuilder password = new StringBuilder();

	        int passwordLength = 8 + random.nextInt(3); 
	        for (int i = 0; i < passwordLength; i++) 
	        {
	            password.append(combinedChars.charAt(random.nextInt(combinedChars.length())));
	        }
	        return password.toString();
	    }

		public boolean validatePanCard(User user) 
		{
			return userDao.validatePanCard(user);
		}

		public boolean validatePanCardUnique(User user) 
		{
			return userDao.validatePanCardUnique(user);
		}
}
