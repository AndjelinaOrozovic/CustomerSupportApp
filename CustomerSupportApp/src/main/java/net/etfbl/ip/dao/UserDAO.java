package net.etfbl.ip.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import net.etfbl.ip.beans.UserBean;

public class UserDAO {

	private static final String SQL_SELECT_ACCOUNT = "SELECT * FROM account WHERE username=? AND password=? AND id_account_type=1";
	
	public static UserBean checkAccount(String username, String password) {
		UserBean user = null;
		
		Connection c = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		Object values[] = {username, password};
		
		try {
			c = DBUtil.getConnection();
			ps = DBUtil.prepareStatement(c, SQL_SELECT_ACCOUNT, false, values);
			rs = ps.executeQuery();
			if(rs.next()) {
				user = new UserBean(rs.getInt(1), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs, ps, c);
		}
		
		return user;
	}
	
}
