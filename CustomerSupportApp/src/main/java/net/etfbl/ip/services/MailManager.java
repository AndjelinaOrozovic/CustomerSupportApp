package net.etfbl.ip.services;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Properties;
import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class MailManager {

	private Properties properties = new Properties();
	
	private static final String SENDER_PROPERTIES = "net.etfbl.ip.services.sender";
	private static final String MAIL_PROPERTIES = "mail.properties";
	
	private static final String SENDER_NAME = "Customer Support";
	private static final String SUBJECT = "Customer Support Response";
	
	private static String mail = "";
	private static String password = "";
	
	private static MailManager mailManager;
	
	private MailManager() {
		
		loadConfiguration();
		readMailCredentials();
		
	}
	
	public static MailManager getMailManager() {
		
		if(mailManager == null) {
			mailManager = new MailManager();
		} 
		
		return mailManager;
		
	}
	
	private Properties loadConfiguration() {
		
		try {
			properties.load(getClass().getResourceAsStream(MAIL_PROPERTIES));
		} catch (IOException e) {
			e.printStackTrace();
		}
		 
		return properties;
		
	}
	
	private void readMailCredentials() {
		
		ResourceBundle rb = PropertyResourceBundle.getBundle(SENDER_PROPERTIES);
		mail = rb.getString("mail");
		password = rb.getString("password");
		
	}
	
	
	public boolean sendMail(String receiver, String mailContent) {
		
		Session session = Session.getInstance(properties, new Authenticator() {
			
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				
				return new PasswordAuthentication(mail, password);
			
			}
		});
		
		try {
			
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(mail, SENDER_NAME));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(receiver));
			message.setSubject(SUBJECT);
			message.setText(mailContent);
			
			Transport.send(message);
			
			return true;

		} catch (MessagingException | UnsupportedEncodingException e) {
		
			e.printStackTrace();
			return false;
	
		}
		
	}
	
}
