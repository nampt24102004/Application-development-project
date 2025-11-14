/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validate;

/**
 *
 * @author Long0
 */
public class InputValidator {
    private static String REGEX_EMAIL = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
    private static String REGEX_PHONE = "^(0|/+84)[1-9]{1}[0-9]{8}$";
    private static String REGEX_STRONGPASS = "^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
    
    public static boolean isEmail(String email) {
        return email.matches(REGEX_EMAIL);
    }
    public static boolean isPhone(String phone) {
        return phone.matches(REGEX_PHONE);
    }
    public static boolean isStrongPass(String password) {
        return password.matches(REGEX_STRONGPASS);
    }
}
