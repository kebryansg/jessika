/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mvc.modelo.smDaoImp;

import java.sql.SQLException;
import mvc.controlador.C_BD;
import mvc.controlador.con_db;
import mvc.modelo.smDao.UsuarioDao;
import java.sql.ResultSet;
/**
 *
 * @author Deivi
 */
public class UsuarioDaoImp implements UsuarioDao {
C_BD conn;
    @Override
    public String Login(String usuario, String clave) {
        String usuarioLogueado="";
        this.conn = con_db.open(con_db.MSSQL_SM);
        ResultSet rs = this.conn.query("SELECT nombre1+' '+apellidos1 as nombres FROM medico INNER JOIN\n" +
"                         usuario ON medico.cedula = usuario.nick where nick='"+usuario+"' and DECRYPTBYPASSPHRASE('encriptarClave',clave)='"+clave+"' ");        
        try {
            while (rs.next()) {
                usuarioLogueado=rs.getString("nombres");                
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            this.conn.close();
        }
       
        return usuarioLogueado;
    }
    
}
