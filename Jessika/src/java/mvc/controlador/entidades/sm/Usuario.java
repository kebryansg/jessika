/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mvc.controlador.entidades.sm;

/**
 *
 * @author Deivi
 */
public class Usuario {
    private String nick;
    private String clave;
    private Rol rol;

    public Usuario(String nick, String clave, Rol rol) {
        this.nick = nick;
        this.clave = clave;
        this.rol = rol;
    }

    public Usuario() {
    }

    public String getNick() {
        return nick;
    }

    public void setNick(String nick) {
        this.nick = nick;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public Rol getRol() {
        return rol;
    }

    public void setRol(Rol rol) {
        this.rol = rol;
    }
    
}
