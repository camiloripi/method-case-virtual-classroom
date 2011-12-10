/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mcvc.face.select;
import com.opentok.api.API_Config;
import com.opentok.api.OpenTokSDK;
import com.opentok.api.constants.RoleConstants;
import com.opentok.exception.OpenTokException;

/**
 *
 * @author camilo
 */
public class face_tokbox {
    OpenTokSDK sdk;
    
    public face_tokbox(){
        sdk = new OpenTokSDK(API_Config.API_KEY, API_Config.API_SECRET); 
    }
    
    public String generateSessionID() throws OpenTokException{
        String ID="";

        //Generate a basic session
       ID = sdk.create_session().session_id;
        System.out.println(ID);      
        return ID;
        
    }
    
    public String generateToKenMaestro(String sessionID) throws OpenTokException{
        String token="";
         token =  sdk.generate_token(sessionID,RoleConstants.MODERATOR);
        return token;
    }
    
    public String generateToKenAlumno(String sessionID) throws OpenTokException{
        String token="";
         token =  sdk.generate_token(sessionID,RoleConstants.PUBLISHER);
        return token;
    }
    
}
