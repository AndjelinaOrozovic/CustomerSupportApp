package net.etfbl.ip.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import net.etfbl.ip.dto.Message;

public class MessageDAO {

	private static final String SQL_SELECT_ALL_MESSAGES = "SELECT message.id, id_user_account, content, is_read, date_and_time, username, mail FROM message INNER JOIN user_account ON id_user_account = user_account.id ORDER BY message.id DESC";
	
	private static final String SQL_SELECT_UNREAD_MESSAGES = "SELECT message.id, id_user_account, content, is_read, date_and_time, username, mail FROM message INNER JOIN user_account ON id_user_account = user_account.id WHERE is_read = false ORDER BY message.id DESC";
	
	private static final String SQL_UPDATE_MESSAGE = "UPDATE message SET is_read=true WHERE id=?";
	
	private static final String SQL_SELECT_SEARCHED_MESSAGES = "SELECT message.id, id_user_account, content, is_read, date_and_time, username, mail FROM message INNER JOIN user_account ON id_user_account = user_account.id WHERE content LIKE CONCAT('%',?,'%') ORDER BY message.id DESC";
	
	private static final String SQL_SELECT_MESSAGE_BY_ID = "SELECT message.id, id_user_account, content, is_read, date_and_time, username, mail FROM message INNER JOIN user_account ON id_user_account = user_account.id WHERE message.id=?";
	
	public static ArrayList<Message> getAllMessages() {
		
		ArrayList<Message> messages = new ArrayList<Message>();		
		Connection c = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Object[] values = {};
		
		try {
			
			c = DBUtil.getConnection();
			ps = DBUtil.prepareStatement(c, SQL_SELECT_ALL_MESSAGES, false, values);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Message message = new Message(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getBoolean(4), rs.getString(5), rs.getString(6), rs.getString(7));
				messages.add(message);
			}
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs, ps, c);
		}
		
		return messages;
		
	}
	
	public static ArrayList<Message> getAllUnreadMessages() {
		
		ArrayList<Message> messages = new ArrayList<Message>();
		Connection c = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Object[] values = {};
		
		try {
			
			c = DBUtil.getConnection();
			ps = DBUtil.prepareStatement(c, SQL_SELECT_UNREAD_MESSAGES, false, values);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Message message = new Message(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getBoolean(4), rs.getString(5), rs.getString(6), rs.getString(7));
				messages.add(message);
			}
					
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs, ps, c);
		}
		
		return messages;
		
	}
	
	public static boolean checkAsRead(int messageId) {
		
		boolean checked = false;
		
		Connection c = null;
		PreparedStatement ps = null;
		Object[] values = {messageId};
		
		try {
			c = DBUtil.getConnection();
			ps = DBUtil.prepareStatement(c, SQL_UPDATE_MESSAGE, false, values);
			if(ps.executeUpdate() == 1) {
				checked = true;
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(ps, c);
		}
		
		return checked;
		
	}
	
	public static List<Message> getSearchedMessages(String content) {
		
		ArrayList<Message> messages = new ArrayList<>();
		
		Connection c = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Object[] values = { content };
		
		try {
			
			c = DBUtil.getConnection();
			ps = DBUtil.prepareStatement(c, SQL_SELECT_SEARCHED_MESSAGES, false, values);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Message message = new Message(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getBoolean(4), rs.getString(5), rs.getString(6), rs.getString(7));
				messages.add(message);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs, ps, c);
		}
		
		return messages;
		
	}
	
	public static Message getMessageById(Integer id) {
		
		Message message = null;
		
		Connection c = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Object[] values = { id };
		
		try {
			
			c = DBUtil.getConnection();
			ps = DBUtil.prepareStatement(c, SQL_SELECT_MESSAGE_BY_ID, false, values);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				message = new Message(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getBoolean(4), rs.getString(5), rs.getString(6), rs.getString(7));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs, ps, c);
		}
		
		return message;
		
	}
	
}