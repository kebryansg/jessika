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
import mvc.controlador.entidades.sm.Medico;
import mvc.controlador.entidades.sm.Rol;
import mvc.controlador.entidades.sm.Usuario;
/**
 *
 * @author Deivi
 */
public class UsuarioDaoImp implements UsuarioDao {
C_BD conn;
Medico medico;
int idRol=-1, id=0;
    @Override
    public String Login(String usuario, String clave) {
        int idRol=-1;
        String usuarioLogueado="";
        this.conn = con_db.open(con_db.MSSQL_SM);
        
        Usuario value= new Usuario();
        ResultSet rs = this.conn.query("select * from usuario where nick='"+usuario+"' and DECRYPTBYPASSPHRASE('encriptarClave',clave)='"+clave+"'  ");        
        try {
            while (rs.next()) {
                value.setNick(rs.getString("nick"));
                value.setRol(new Rol(rs.getInt("idRol")));
                idRol=rs.getInt("idRol");
            }            
        } catch (SQLException ex) {
            idRol=-1;
            System.out.println(ex.getMessage());
            
        } finally {
            this.conn.close();
        }
        if(idRol!=-1)
        {
            switch (value.getRol().getId())
            {       
                //id1 medico
            case 1:
                medico= new Medico();
                 this.conn = con_db.open(con_db.MSSQL_SM);
                rs = this.conn.query("select * from medico where cedula='"+usuario+"'");        
                try {
                    while (rs.next()) {
                        usuarioLogueado=rs.getString("nombre1")+" "+rs.getString("apellidos1");
                        id=rs.getInt("id");
                        /*medico.setId(rs.getInt("id"));
                        medico.setNombre1(rs.getString("nombre1"));
                        medico.setNombre2(rs.getString("nombre2"));
                        medico.setApellidos1(rs.getString("apellidos1"));
                        medico.setApellidos2(rs.getString("apellidos2"));
                        medico.setDomicilio(rs.getString("domicilio"));
                        medico.setCiudad(rs.getString("ciudad"));
                        medico.setTelefonoDomicilio(rs.getString("telefonoDomicilio"));
                        medico.setTelefonoMovil(rs.getString("telefonoMovil"));
                        medico.setTelefonoOficina(rs.getString("telefonoOficina"));
                        medico.setEmail((rs.getString("email")));
                        medico.setCedula(rs.getString("cedula"));                                                      */
                        
                    }
                    
                } catch (SQLException ex) {
                    idRol=-1;
                    System.out.println(ex.getMessage());
                    
                } finally {
                    this.conn.close();
                }
                
                break;
                // para otro tipo de usuario
            case 2:
                break;
            }
        }
        return usuarioLogueado;
    }

    @Override
    public int getIdRol() {
        return idRol;
    }

    @Override
    public int getId() {
        return id;
    }


    @Override
    public Medico getMedico() {
        return medico;
    }

    
    
   

    
    
    
}
