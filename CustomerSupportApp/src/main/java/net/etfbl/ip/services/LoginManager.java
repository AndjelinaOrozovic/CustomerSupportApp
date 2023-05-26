package net.etfbl.ip.services;

import net.etfbl.ip.beans.UserBean;
import net.etfbl.ip.dao.UserDAO;

public class LoginManager {
	
	private static LoginManager loginManager;

	public LoginManager() {
	}
	
	public static LoginManager getLoginManager() {
		if(loginManager == null) {
			loginManager = new LoginManager();
		}
		return loginManager;
	}
	
	public UserBean loginUser(String username, String password) {
		return UserDAO.checkAccount(username.trim(), password.trim());
	}

}
