/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mvc.modelo.smDao;

import mvc.controlador.entidades.sm.Medico;
import mvc.controlador.entidades.sm.Usuario;



/**
 *
 * @author Deivi
 */
public interface UsuarioDao {
    //public int Login(String usuario, String clave);
    public String Login(String usuario, String clave);
    public Medico getMedico();
    public int getIdRol();
    public int getId();
    
}
