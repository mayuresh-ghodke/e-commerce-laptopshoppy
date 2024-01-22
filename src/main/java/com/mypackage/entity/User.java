package com.mypackage.entity;

public class User {
	
    private int userId;
   
    private String userName;
   
    private String userEmail;
    
    private String userPassword;
    
    private String userPhone;
    
    private String userAddress;
    
    private String userType;
    
    
    public User(String userName, String userEmail, String userPassword, String userPhone,
			String userAddress) {
		super();
		
		this.userName = userName;
		this.userEmail = userEmail;
		this.userPassword = userPassword;
		this.userPhone = userPhone;
		this.userAddress = userAddress;
		
	}

    public User() {
		
	}

	public int getUserId() {
        return userId;
    }
	
	public void setUserId(int userId) {
		this.userId=userId;
	}

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public String getUserType() {
        return userType;
    }

//    public void setUserType(String userType) {
//        this.userType = userType;
//    }
    
    public String toString() {
        return "User{" + "userId=" + userId + ", userName=" + userName + ", userEmail=" + userEmail + ", userPassword=" + userPassword + ", userPhone=" + userPhone + ", userAddress=" + userAddress + '}';
    }
	
}
