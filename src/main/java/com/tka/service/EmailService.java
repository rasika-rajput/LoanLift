package com.tka.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService
{
	@Autowired
    JavaMailSender mailSender;
	
	 public void sendEmailNotification(String toEmail, String subject, String body) 
	    {
	        SimpleMailMessage message = new SimpleMailMessage();
	        message.setTo(toEmail);
	        message.setSubject(subject);
	        message.setText(body);

	        mailSender.send(message);
	    }
	        
     public void sendCredentials(String toEmail, String username, String password) {
	        SimpleMailMessage message = new SimpleMailMessage();
	        message.setTo(toEmail);
	        message.setSubject("Your Username and Password for Loan Application");
	        message.setText("Dear User,\n\nYour account credentials are:\n" +
	                        "Username: " + username + "\nPassword: " + password +
	                        "\n\nPlease log in using these details.");

	        mailSender.send(message);
	    }
}
