package com.mypackage.dao.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mypackage.admin.entity.Admin;

public class AdminDao {
	
	private Connection connection;

    public AdminDao(Connection connection)
    {
        this.connection = connection;
    }

    public void register(Admin admin) throws SQLException 
    {
        
		PreparedStatement ps = connection.prepareStatement("insert into admin (admin_name, admin_email, admin_mobile, admin_password) values(?,?,?,?)");
        
        try
        {
            ps.setString(1, admin.getAdminName());
            ps.setString(2, admin.getAdminEmail());
            ps.setString(3, admin.getAdminMobile());
            ps.setString(4, admin.getAdminPassword());
           

            int i=ps.executeUpdate();
            
            if(i>0) {
            	System.out.println("Admin Successfully Registered");
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
    
    //Admin Dao for login() method
    public Admin login(String adminEmail, String adminPassword)
    {	
    	
    	Admin admin=null ;
    	
    	try
    	{  		
			String sql = "select * from admin where admin_email=? and admin_password=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, adminEmail);
			ps.setString(2, adminPassword);

			ResultSet rs = ps.executeQuery();

			while (rs.next())
			{
				admin = new Admin();
				admin.getAdminId();
				admin.setAdminName(rs.getString(2));
				admin.setAdminEmail(rs.getString(3));
				admin.setAdminPassword(rs.getString(4));
				admin.setAdminMobile(rs.getString(5));
				
			}
		} 
    	catch (Exception e)
    	{
    		System.out.println("Error : "+e);
			e.printStackTrace();
		} 	 
		return admin;	
	}
    public List<Admin> getAdmins()
    {
		List<Admin> list = new ArrayList<Admin>();
		Admin admin = null;

		try
		{
			String sql = "select * from admin";
			
			PreparedStatement ps = connection.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();

			while (rs.next())
			{
				admin = new Admin();
				
				admin.setAdminName(rs.getString(2));
				admin.setAdminEmail(rs.getString(3));
				admin.setAdminMobile(rs.getString(4));
				list.add(admin);
			}
		} 
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return list;
	}
}
