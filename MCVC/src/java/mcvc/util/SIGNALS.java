/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mcvc.util;

/**
 *
 * @author Camilo-Rivera
 */
public class SIGNALS {
    private String sender;
    private String reciber;
    private int type;
    private boolean estatus;

    public String getSender() {
        return sender;
    }

    /**
     * @param sender the sender to set
     */
    public void setSender(String sender) {
        this.sender = sender;
    }

    /**
     * @return the reciber
     */
    public String getReciber() {
        return reciber;
    }

    /**
     * @param reciber the reciber to set
     */
    public void setReciber(String reciber) {
        this.reciber = reciber;
    }

    /**
     * @return the type
     */
    public int getType() {
        return type;
    }

    /**
     * @param type the type to set
     */
    public void setType(int type) {
        this.type = type;
    }

    /**
     * @return the estatus
     */
    public boolean isEstatus() {
        return estatus;
    }

    /**
     * @param estatus the estatus to set
     */
    public void setEstatus(boolean estatus) {
        this.estatus = estatus;
    }
    
    
}
