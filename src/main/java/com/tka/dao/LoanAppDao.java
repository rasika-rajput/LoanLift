package com.tka.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tka.entity.LoanApplication;
import com.tka.service.UserService;

@Repository
public class LoanAppDao 
{
	@Autowired
	SessionFactory sessionFactory;
	
	@Autowired
	UserService userService;
	
	public boolean submitLoanApplication(LoanApplication loanApp) 
	{
		        Session session = sessionFactory.openSession();
		        Transaction transaction = session.beginTransaction();
		        System.out.println("LoanApplication data: " + loanApp);
		        session.save(loanApp);
		        transaction.commit(); 
		        System.out.println("LoanApplication successfully saved!");
		        return true;
		       
	 }

	public List<LoanApplication> getAllLoanApps() 
	{
		    Session session = sessionFactory.openSession();
		    Criteria criteria = session.createCriteria(LoanApplication.class);
		    List<LoanApplication> loanApps = criteria.list();
		    return loanApps;
	}

	

	}


