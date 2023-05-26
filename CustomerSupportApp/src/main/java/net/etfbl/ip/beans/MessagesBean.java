package net.etfbl.ip.beans;

import java.io.Serializable;
import java.util.List;

import net.etfbl.ip.dao.MessageDAO;
import net.etfbl.ip.dto.Message;

public class MessagesBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4477106431295148077L;

	public List<Message> getAllMessages() {
		return MessageDAO.getAllMessages();
	}
	
	public List<Message> getAllUnreadMessages() {
		return MessageDAO.getAllUnreadMessages();
	}
	
	public boolean checkAsRead(Integer id) {
		return MessageDAO.checkAsRead(id);
	}
	
	public List<Message> getSearchedMessages(String content) {
		return MessageDAO.getSearchedMessages(content);
	}
	
	public Message getMessageById(Integer id) {
		return MessageDAO.getMessageById(id);
	}

}
