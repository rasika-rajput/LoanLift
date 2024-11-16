package com.tka.entity;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class LoanApplication {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int loanId;

    @Column(nullable = false)
    private double loanAmount;

    @Column(nullable = false)
    private String loanType;

    @Column(nullable = false)
    private int loanDuration;

    @Column(nullable = false)
    private double interestRate;

    @Column(nullable = false)
    private double annualIncome;

    @Column(nullable = false, length = 500)
    private String purpose;

    @Column(nullable = false)
    private String status = "Pending";

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "username", referencedColumnName = "username", nullable = false)
	public User user;

    private LocalDateTime applicationDate;

    @Column(unique = true, nullable = false, length = 10)
    private String panCard;

    
    public LoanApplication() {
    	this.applicationDate = LocalDateTime.now();
	}

	public LoanApplication(int loanId, double loanAmount, String loanType, int loanDuration, double interestRate,
			double annualIncome, String purpose, String status, User user, LocalDateTime applicationDate) {
		super();
		this.loanId = loanId;
		this.loanAmount = loanAmount;
		this.loanType = loanType;
		this.loanDuration = loanDuration;
		this.interestRate = interestRate;
		this.annualIncome = annualIncome;
		this.purpose = purpose;
		this.status = status;
		this.user = user;
		this.applicationDate = applicationDate;
	}






	public int getLoanId() {
		return loanId;
	}



	public void setLoanId(int loanId) {
		this.loanId = loanId;
	}



	public double getLoanAmount() {
		return loanAmount;
	}



	public void setLoanAmount(double loanAmount) {
		this.loanAmount = loanAmount;
	}



	public String getLoanType() {
		return loanType;
	}



	public void setLoanType(String loanType) {
		this.loanType = loanType;
	}



	public int getLoanDuration() {
		return loanDuration;
	}



	public void setLoanDuration(int loanDuration) {
		this.loanDuration = loanDuration;
	}



	public double getInterestRate() {
		return interestRate;
	}



	public void setInterestRate(double interestRate) {
		this.interestRate = interestRate;
	}



	public double getAnnualIncome() {
		return annualIncome;
	}



	public void setAnnualIncome(double annualIncome) {
		this.annualIncome = annualIncome;
	}



	public String getPurpose() {
		return purpose;
	}



	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}



	public String getStatus() {
		return status;
	}



	public void setStatus(String status) {
		this.status = status;
	}



	public User getUser() {
		return user;
	}



	public void setUser(User user) {
		this.user = user;
	}

	public LocalDateTime getApplicationDate() {
		return applicationDate;
	}

	public void setApplicationDate(LocalDateTime applicationDate) {
		this.applicationDate = applicationDate;
	}

	public String getPanCard() {
		return panCard;
	}

	public void setPanCard(String panCard) {
		this.panCard = panCard;
	}

	

	@Override
	public String toString() {
		return "LoanApplication [loanId=" + loanId + ", loanAmount=" + loanAmount + ", loanType=" + loanType
				+ ", loanDuration=" + loanDuration + ", interestRate=" + interestRate + ", annualIncome=" + annualIncome
				+ ", purpose=" + purpose + ", status=" + status + ", user=" + user + ", applicationDate="
				+ applicationDate + ", panCard=" + panCard + "]";
	}

	
	

	
}
