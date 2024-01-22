package com.mypackage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mypackage.entity.User;

public class UserDao
{
    private Connection connection;

    public UserDao(Connection connection)
    {
        this.connection = connection;
    }

    public void register(User user) throws SQLException 
    {
        
		PreparedStatement ps = connection.prepareStatement("insert into user (user_name, user_email, user_password, user_phone, user_address) values(?,?,?,?,?)");
        
        try
        {
            ps.setString(1, user.getUserName());
            ps.setString(2, user.getUserEmail());
            ps.setString(3, user.getUserPassword());
            ps.setString(4, user.getUserPhone());
            ps.setString(5, user.getUserAddress());

            int i=ps.executeUpdate();
            
            if(i>0) {
            	System.out.println("Successfully Registered");
            }
            else {
            	System.out.println("Something error");
            }    
        }
        catch(SQLException exp)
        {
        	System.out.println("Error : "+exp);
        	
        	exp.printStackTrace();
        } 
    }
    
    //User Dao for login() method
    public User login(String usrname, String password)
    {	
    	
    	User user=null ;
    	
    	try
    	{  		
			String sql = "select * from user where user_email=? and user_password=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, usrname);
			ps.setString(2, password);

			ResultSet rs = ps.executeQuery();

			while (rs.next())
			{
				user= new User();
				user.getUserId();
				user.setUserName(rs.getString(2));
				user.setUserEmail(rs.getString(3));
				user.setUserPassword(rs.getString(4));
				user.setUserPhone(rs.getString(5));
				user.setUserAddress(rs.getString(6));
				user.getUserType();				
			}
		} 
    	catch (Exception e)
    	{
    		System.out.println("Error : "+e);
			e.printStackTrace();
		} 	 
		return user;	
	}
    
    public List<User> getUsers()
    {
		List<User> list = new ArrayList<User>();
		User user = null;

		try
		{
			String sql = "select * from user";
			
			PreparedStatement ps = connection.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();

			while (rs.next())
			{
				user = new User();
				
				user.setUserName(rs.getString(2));
				user.setUserEmail(rs.getString(3));
				user.setUserPhone(rs.getString(5));
				user.setUserAddress(rs.getString(6));
				list.add(user);
			}
		} 
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return list;
	}
    
    
    public boolean checkOldPassword(String useremail, String currentpassword) {
        boolean f = false;
        try
        {
            String sql = "SELECT * FROM user WHERE user_email = ?";
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, useremail);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next())
            {               
                String password = rs.getString("user_password");
                if (password.equals(currentpassword))
                {
                    f = true;
                }
            }
            
        } 
        catch (SQLException e)
        {
            System.out.println("Error : " + e);
            e.printStackTrace();
        }
        return f;
    }


	public boolean changePassword(String useremail, String newPassword) {
		boolean f = false;

		try {
			String sql = "update user set user_password=? where user_email=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, newPassword);
			ps.setString(2, useremail);

			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}
		} catch (SQLException e)
		{
			System.out.println("Error : "+e);
			e.printStackTrace();
		}

		return f;
	}
	
	public void updateInformation(String userPassword,String userPhone, String userAddress, String userName) throws SQLException 
    {
        
		PreparedStatement ps = connection.prepareStatement("update user set user_password=?, user_phone=?, user_address=? where user_name=?");
        
        try
        {
            ps.setString(1, userPassword);
            ps.setString(2, userPhone);
            ps.setString(3, userAddress);
            ps.setString(4, userName);

            int i=ps.executeUpdate();
            
            if(i>0) {
            	System.out.println("Successfully Updated");
            }
            else {
            	System.out.println("Something error in updation");
            }    
        }
        catch(SQLException exp)
        {
        	System.out.println("Error : "+exp);
        	
        	exp.printStackTrace();
        } 
    }

	public void updateInformation(User user) {
		
	}
	
	
	public int getUserId(String userEmail) {
	    int userId = -1; // Initialize the userId to a default value (-1 or any other appropriate default value)
	    try {
	        String sql = "SELECT user_id FROM user WHERE user_email = ?";
	        PreparedStatement ps = connection.prepareStatement(sql);
	        ps.setString(1, userEmail);

	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            userId = rs.getInt("user_id"); // Retrieve the user_id column from the result set
	            System.out.println("User Id is : "+userId);
	        }

	        // Close the result set, statement, and connection (in a finally block for proper resource management)
	        rs.close();
	        ps.close();
	    } catch (SQLException e) {
	        System.out.println("Error: " + e);
	        e.printStackTrace();
	    }
	    return userId;
	}
	
	
	public boolean checkPhoneExists(String phoneNumber) {
	    boolean exists = false;

	    try {
	        String sql = "SELECT user_phone FROM user WHERE user_phone = ?";
	        PreparedStatement ps = connection.prepareStatement(sql);
	        ps.setString(1, phoneNumber); 
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            exists = true; 
	            System.out.println("User Phone exists: " + phoneNumber);
	        }

	        rs.close();
	        ps.close();
	    } catch (SQLException e) {
	        System.out.println("Error: " + e);
	        e.printStackTrace();
	    }

	    return exists;
	}
	

public boolean checkEmailExists(String email) {
    boolean exists = false;

    try {
        String sql = "SELECT user_email FROM user WHERE user_email = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, email);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            exists = true; 
            System.out.println("User Email exists: " + email);
        }

        rs.close();
        ps.close();
    } catch (SQLException e) {
        System.out.println("Error: " + e);
        e.printStackTrace();
    }

    return exists;
}

		public User getUserDetails(int userId) {
			
			User user = new User();
			
			try {
				String sql = "SELECT `order`.*, user.* " +
	                     "FROM `order` " +
	                     "INNER JOIN user ON `order`.user_id = user.user_id " +
	                     "WHERE `order`.user_id = ?";

				
				PreparedStatement ps = connection.prepareStatement(sql);
				
				ps.setInt(1, userId);
				
				ResultSet rs = ps.executeQuery();
				
				while(rs.next()){
					user.setUserName(rs.getString("user_name"));
					user.setUserEmail(rs.getString("user_email"));
					user.setUserPhone(rs.getString("user_phone"));
				}
	        
	       
	        
	    } catch (SQLException e) {
	        System.out.println("Error: " + e);
	    }
			return user;
			
		}

}
