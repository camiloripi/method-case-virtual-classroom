/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mcvc.servlets;

import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import mcvc.util.publisherProperties;

/**
 * Web application lifecycle listener.
 *
 * @author Camilo-Rivera
 */
public class Cleaner implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ArrayList<publisherProperties> publisherarry = new ArrayList<publisherProperties>();
        sce.getServletContext().setAttribute("publisher", publisherarry);

        Enumeration<Driver> drivers = DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            Driver driver = drivers.nextElement();
            try {
                DriverManager.registerDriver(driver);
            } catch (SQLException ex) {
                Logger.getLogger(Cleaner.class.getName()).log(Level.SEVERE, null, ex);
            }


        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        Enumeration<String> attributes = sce.getServletContext().getAttributeNames();
        while(attributes.hasMoreElements()){
            String attribute = attributes.nextElement();          
            sce.getServletContext().removeAttribute(attribute);            
        }
        
        Enumeration<Driver> drivers = DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            Driver driver = drivers.nextElement();
            try {
                DriverManager.deregisterDriver(driver);
            } catch (SQLException ex) {
                Logger.getLogger(Cleaner.class.getName()).log(Level.SEVERE, null, ex);
            }


        }
    }
}
