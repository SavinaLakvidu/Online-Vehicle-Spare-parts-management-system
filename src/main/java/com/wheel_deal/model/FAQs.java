package com.wheel_deal.model;
import java.util.Date;

public class FAQs {
	
	private int faqid;
    private String question;
    private String answer;
    private Date created_at;
    
	public int getFaqid() {
		return faqid;
	}
	public String getQuestion() {
		return question;
	}
	public String getAnswer() {
		return answer;
	}
	public Date getCreated_at() {
		return created_at;
	}
	public void setFaqid(int faqid) {
		this.faqid = faqid;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}

    
}
