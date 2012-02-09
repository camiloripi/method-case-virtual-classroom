/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mcvc.util;

/**
 *
 * @author Camilo-Rivera
 */
public class publisherProperties {
    private boolean audio;
    private boolean video;
    private String sessionid;

    /**
     * @return the audio
     */
    public boolean isAudio() {
        return audio;
    }

    /**
     * @param audio the audio to set
     */
    public void setAudio(boolean audio) {
        this.audio = audio;
    }

    /**
     * @return the video
     */
    public boolean isVideo() {
        return video;
    }

    /**
     * @param video the video to set
     */
    public void setVideo(boolean video) {
        this.video = video;
    }

    /**
     * @return the sessionid
     */
    public String getSessionid() {
        return sessionid;
    }

    /**
     * @param sessionid the sessionid to set
     */
    public void setSessionid(String sessionid) {
        this.sessionid = sessionid;
    }
    
}
