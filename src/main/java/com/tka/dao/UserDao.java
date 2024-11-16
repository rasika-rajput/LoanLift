package com.tka.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.tka.entity.LoanApplication;
import com.tka.entity.User;
import com.tka.service.EmailService;

@Repository
public class UserDao 
{
	@Autowired
	SessionFactory sessionFactory;
	
	@Autowired
	EmailService emailService;
	
    private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    public User user;
	public boolean registerUser(User user) 
	{
		String hashedPassword = passwordEncoder.encode(user.getPassword());
		user.setPassword(hashedPassword);
		Session session = sessionFactory.openSession();
		Transaction transaction = session.beginTransaction();
		session.save(user);
		transaction.commit();
		session.close();
		return true;
	}
	
	public User findUserByEmailOrUsername(String emailOrUsername) 
	{
		 Session session = sessionFactory.openSession();
	     Criteria criteria = session.createCriteria(User.class);
	     criteria.add(Restrictions.or( Restrictions.eq("email", emailOrUsername),
                                       Restrictions.eq("username", emailOrUsername)));
	     return (User) criteria.uniqueResult();     
              
	}

	public void updateFailedAttempts(String emailOrUsername) 
	{
		 Session session = sessionFactory.openSession();
		 Transaction transaction = session.beginTransaction();
	     Criteria criteria = session.createCriteria(User.class);
		 criteria.add(Restrictions.or( Restrictions.eq("email", emailOrUsername),
                 Restrictions.eq("username", emailOrUsername)));
		 User user = (User) criteria.uniqueResult();
		 if(user.getFailed_attempts() < 3)
		 {
		 user.setFailed_attempts(user.getFailed_attempts() + 1);
		 session.saveOrUpdate(user);
	
		 }
		 
		 if(user.getFailed_attempts() == 3)
		 {
			 user.setStatus("InActive");
		 }
		 transaction.commit();
		 
	}
	
	public void resetFailedAttempts(String emailOrUsername) 
	{
	    Session session = sessionFactory.openSession();
	    Transaction transaction = session.beginTransaction();
	    
	    Criteria criteria = session.createCriteria(User.class);
	    criteria.add(Restrictions.or(
	        Restrictions.eq("email", emailOrUsername),
	        Restrictions.eq("username", emailOrUsername) ));
	   
	    
	    User user = (User) criteria.uniqueResult();
	    if (user != null) 
	    {
	        user.setFailed_attempts(0); 
	        session.saveOrUpdate(user);
	    }
	    
	    transaction.commit();
	    session.close();
	}

	public User resetPassword(String identifier) 
	{
		String resetLink = "http://localhost:8080/resetMyPassword";
        user = findUserByEmailOrUsername(identifier);
		System.out.println("Password Reset Link : " +resetLink);
    	return user;
	}

	public boolean updatePassword(String newPassword) 
	{
		 String passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
		 
		 if (!newPassword.matches(passwordPattern) && newPassword.length() < 8) 
		 {
		        System.out.println("Password does not meet the complexity requirements.");
		        return false; 
		 }
		 
		 Session session = sessionFactory.openSession();
		 Transaction transaction = session.beginTransaction();
		 String hashedPassword = passwordEncoder.encode(newPassword);
		 user.setPassword(hashedPassword);
		 session.update(user);
		 transaction.commit();
		 
		 return true;
	}

	public List<User> getAllUsers() 
	{
	    Session session = sessionFactory.openSession();
	    Criteria criteria = session.createCriteria(User.class);
	    List<User> all = criteria.list();
	    List<User> users = new ArrayList();
	    for (User user : all) 
	    {
			if(user.getUser_role().equalsIgnoreCase("ROLE_USER"))
				users.add(user);
				
		}
	    return users;
	}

	public User getUserByUsername(String email) 
	{
		Session session = sessionFactory.openSession();
	     Criteria criteria = session.createCriteria(User.class);
	     criteria.add(Restrictions.eq("email", email));
	     return (User) criteria.uniqueResult();
	     
	}

	public void deleteUserByEmail(String email) 
	{
		Session session = sessionFactory.openSession();
		 Transaction transaction = session.beginTransaction();
	     Criteria criteria = session.createCriteria(User.class);
		 criteria.add(Restrictions.eq("email", email));
		 User user = (User) criteria.uniqueResult();
		 session.delete(user);
		 String name = user.getFname();
		 String subject = "Account Update Notification!";
		 String body = "Dear " +name +", your account has been deleted from the system. If this was a mistake, please contact support immediately.";
		 emailService.sendEmailNotification("rasikarajput2122@gmail.com", subject, body);
		 transaction.commit();
	}

	public void updateUserStatus(String action, String email)
	{
		Session session = sessionFactory.openSession();
		 Transaction transaction = session.beginTransaction();
	     Criteria criteria = session.createCriteria(User.class);
		 criteria.add(Restrictions.eq("email", email));
		 User user = (User) criteria.uniqueResult();
		 if(action.equals("activate"))
		 {
			 user.setStatus("Active");
			 String name = user.getFname();
			 String subject = "Account Update Notification!";
			 String body = "Dear " +name +", your account has been successfully activated by the admin. You can now log in to the system.";
			 emailService.sendEmailNotification("rasikarajput2122@gmail.com", subject, body);
		 }
		 else
		 {
			 user.setStatus("InActive");
			 String name = user.getFname();
			 String subject = "Account Update Notification!";
			 String body = "Dear " +name +", your account has been deactivated. Please contact support for more information.";
			 emailService.sendEmailNotification("rasikarajput2122@gmail.com", subject, body);
		 }
		 session.update(user);
		 transaction.commit();
	}

	public void approveLoan(int loanId) 
	{
	    Session session = sessionFactory.openSession();
	    Transaction transaction = session.beginTransaction();
	    Criteria criteria = session.createCriteria(LoanApplication.class);
	    criteria.add(Restrictions.eq("loanId", loanId));
	    LoanApplication loanApp = (LoanApplication) criteria.uniqueResult();
	    loanApp.setStatus("Approved");
	    session.update(loanApp);

	    double monthlyInterestRate = (loanApp.getInterestRate() / 12) / 100;
	   
	    if (loanApp.getLoanAmount() <= 0 || loanApp.getLoanDuration() <= 0 || loanApp.getInterestRate() < 0) 
	    {
	        throw new IllegalArgumentException("Invalid loan details.");
	    }

	    double emi = (loanApp.getLoanAmount() * monthlyInterestRate * Math.pow(1 + monthlyInterestRate, loanApp.getLoanDuration()))
	                / (Math.pow(1 + monthlyInterestRate, loanApp.getLoanDuration()) - 1);

	    double totalInterest = (emi * loanApp.getLoanDuration()) - loanApp.getLoanAmount();
	    double totalPayable = loanApp.getLoanAmount() + totalInterest;
	    
	    String subject = "Your Loan Application has been Approved!";
	    String body = String.format(
          "Dear %s %s,\n\n"
        + "We are pleased to inform you that your loan application has been approved. Below are the details of your approved loan:\n\n"
        + "Sanctioned Loan Amount: ₹%.2f\n"
        + "Loan Type: %s\n"
        + "Loan Tenure: %d months\n"
        + "Applied Interest Rate: %.2f%% per annum\n"
        + "Monthly EMI Amount: ₹%.2f\n"
        + "Total Interest Amount: ₹%.2f\n"
        + "Total Payable Amount: ₹%.2f\n\n"
        + "Thank you for choosing us for your loan needs.\n\n"
        + "Sincerely,\n"
        + "HDFC Bank",
          loanApp.getUser().getFname(),  
          loanApp.getUser().getLname(), 
          loanApp.getLoanAmount(),       
          loanApp.getLoanType(),       
          loanApp.getLoanDuration(),  
          loanApp.getInterestRate(),     
          emi,                           
          totalInterest,                 
          totalPayable                  
       );

	    emailService.sendEmailNotification("rasikarajput2122@gmail.com", subject, body);
	    transaction.commit();
	}


	public void rejectLoan(int loanId) 
	{
		 Session session = sessionFactory.openSession();
		 Transaction transaction = session.beginTransaction();
	     Criteria criteria = session.createCriteria(LoanApplication.class);
		 criteria.add(Restrictions.eq("loanId", loanId));
		 LoanApplication loanApp = (LoanApplication) criteria.uniqueResult();
		 loanApp.setStatus("Rejected");
		 session.update(loanApp);
		 String name = loanApp.user.getFname();
		 double amount = loanApp.getLoanAmount();
		 String subject = "Your Loan Application has been Rejected!";
		 String body = "Dear " +name +", we regret to inform you that your loan application has been rejected. [reason]. Please contact support for more details.";
		 emailService.sendEmailNotification("rasikarajput2122@gmail.com", subject, body);
		 transaction.commit();
	}

	public LoanApplication getLoanByLoanID(int loanId)
	{
		Session session = sessionFactory.openSession();
	     Criteria criteria = session.createCriteria(LoanApplication.class);
	     criteria.add(Restrictions.eq("loanId", loanId));
	     LoanApplication loanApp = (LoanApplication) criteria.uniqueResult();
	     System.out.println(loanApp);
         return loanApp;
	}
	
	 public void updateUser(User user) 
	 {
	        Session session = sessionFactory.openSession();
		    Transaction transaction = session.beginTransaction();
	        session.update(user); 
	        transaction.commit();
	        session.close();
	  }

	public boolean validatePanCard(User user) 
	{
		String panPattern = "[A-Z]{5}[0-9]{4}[A-Z]{1}";
        return Pattern.matches(panPattern, user.getPanCard());
	}

	public boolean validatePanCardUnique(User user) 
	{
		boolean flag1 = false;
		Session session = sessionFactory.openSession();
	    Criteria criteria = session.createCriteria(User.class);
	    List<User> users = criteria.list();
	    for (User user2 : users) 
	    {
	    	if(!user.getPanCard().equals(user2.getPanCard()))
	    	{
	    		System.out.println(user.getPanCard());
	    		System.out.println(user2.getPanCard());
	    		flag1 = true;
	    	}
		}
		
		return flag1;
	}
	    
}
	




