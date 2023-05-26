package net.etfbl.ip.dto;

import java.io.Serializable;
import java.util.Objects;

public class Message implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2012629222195107973L;

	private Integer id;
	private Integer idUserAccount;
	private String content;
	private boolean isRead;
	private String dateAndTime;
	private String username;
	private String mail;
	
	public Message() {
		// TODO Auto-generated constructor stub
	}
	
	public Message(Integer id, Integer idUserAccount, String content, boolean isRead, String dateAndTime, String username, String mail) {
		this.id = id;
		this.idUserAccount = idUserAccount;
		this.content = content;
		this.isRead = isRead;
		this.dateAndTime = dateAndTime;
		this.username = username;
		this.mail = mail;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getIdUserAccount() {
		return idUserAccount;
	}

	public void setIdUserAccount(Integer idUserAccount) {
		this.idUserAccount = idUserAccount;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public boolean isRead() {
		return isRead;
	}

	public void setRead(boolean isRead) {
		this.isRead = isRead;
	}

	public String getDateAndTime() {
		return dateAndTime;
	}

	public void setDateAndTime(String dateAndTime) {
		this.dateAndTime = dateAndTime;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String email) {
		this.mail = email;
	}

	@Override
	public int hashCode() {
		return Objects.hash(content, dateAndTime, id, idUserAccount, isRead, username, mail);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Message other = (Message) obj;
		return Objects.equals(content, other.content) && Objects.equals(dateAndTime, other.dateAndTime)
				&& Objects.equals(id, other.id) && Objects.equals(idUserAccount, other.idUserAccount)
				&& isRead == other.isRead && Objects.equals(mail, other.mail)
						&& Objects.equals(username, other.username);
	}
	
	

}
