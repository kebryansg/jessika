/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mvc.modelo.smDaoImp;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import mvc.controlador.C_BD;
import mvc.controlador.con_db;

import mvc.controlador.entidades.sm.Especialidad;
import mvc.modelo.smDao.EspecialidadDao;

/**
 *
 * @author Byron
 */
public class EspecialidadDaoImp implements EspecialidadDao{
    C_BD conn;
    @Override
    public List<Especialidad> list() {
        this.conn = con_db.open(con_db.MSSQL_SM);
        List<Especialidad> list = new ArrayList<>();
        ResultSet rs = this.conn.query("SELECT * FROM ESPECIALIDAD WHERE VISIBLE=1 ");
        try {
            while (rs.next()) {
                Especialidad value = new Especialidad();
                value.setId(rs.getInt("id"));
                value.setDescripcion(rs.getNString("descripcion"));
                list.add(value);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            this.conn.close();
        }
        return list;
    }
    
    @Override
    public List<Especialidad> list(int id) {
        this.conn = con_db.open(con_db.MSSQL_SM);
        List<Especialidad> list = new ArrayList<>();
        ResultSet rs = this.conn.query("SELECT especialidad.id,especialidad.descripcion from medico_especialidad inner join especialidad on especialidad.id=medico_especialidad.idEspecialidad inner join medico on medico_especialidad.idMedico=medico.id WHERE medico.id="+id+"");
        try {
            while (rs.next()) {
                Especialidad value = new Especialidad();
                value.setId(rs.getInt("id"));
                value.setDescripcion(rs.getNString("descripcion"));
                list.add(value);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            this.conn.close();
        }
        return list;
    }

    @Override
    public Especialidad edit(int id) {
        this.conn = con_db.open(con_db.MSSQL_SM);
        ResultSet rs = this.conn.query("select * from ESPECIALIDAD  where id = '" + id + "'");
        Especialidad value = new Especialidad();
        try {
            while (rs.next()) {
                value.setId(rs.getInt("id"));
                value.setDescripcion(rs.getNString("descripcion"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            this.conn.close();
        }
        return value;
    }

    @Override
    public boolean save(Especialidad value) {
        String sql="";
        this.conn= con_db.open(con_db.MSSQL_SM);
        try 
        {   
            //Insert
           if(value.getId()==0)
            {
                sql="INSERT INTO especialidad (descripcion,visible) VALUES ('"+value.getDescripcion()+"','1');";
            }
            //Update
            else
            {
                sql="UPDATE especialidad SET descripcion='"+value.getDescripcion()+"', visible='"+value.getVisible()+"' where id='"+value.getId()+"'";                
            }
            this.conn.execute(sql);
            return true;
        }
        catch(Exception ex)
        {
            return false;
        }
       
    }

    @Override
    public boolean delete(int id) {
        this.conn= con_db.open(con_db.MSSQL_SM);        
        try
        {
            this.conn.execute("UPDATE ESPECIALIDAD SET visible='0' where id='"+id+"';");
            return true;
        }
        catch(Exception ex)
        {
            return false;            
        }
    }

    @Override
    public int id() {
        int idEspecialidad=0;
        this.conn= con_db.open(con_db.MSSQL_SM);        
        try
        {            
             ResultSet rs = this.conn.query("SELECT  TOP 1 id from especialidad order by id desc");
             while(rs.next())
             {
                 idEspecialidad=rs.getInt("id");
             }
             return idEspecialidad;
        }
        catch(SQLException ex)
        {
            return idEspecialidad;
        }
    }

    @Override
    public int totalRegistros(int flag, String buscar ) {
        int totalRegistros=0;
        this.conn= con_db.open(con_db.MSSQL_SM);        
        try
        {            
            ResultSet rs =null;
            if(flag==1)
            {
                rs = this.conn.query("SELECT COUNT(id) as totalRegistros from especialidad where visible=1 and descripcion like '%"+buscar+"%'");
            }
            else
            {
                rs = this.conn.query("SELECT COUNT(id) as totalRegistros from especialidad where visible=1 ");
            }
             
             while(rs.next())
             {
                 totalRegistros=rs.getInt("totalRegistros");
             }
             return totalRegistros;
        }
        catch(SQLException ex)
        {
            return totalRegistros;
        }
    }

    @Override
    public List<Especialidad> list(int numeroPaginas, int totalRegistro, int bandera, String buscar) {
        List<Especialidad> list = new ArrayList<>();

              try {  
            Connection conexion;          
            conexion = con_db.open(con_db.MSSQL_SM).getConexion();
            CallableStatement cStmt=null;
            //con el txt buscar
            if(bandera==1)
            {   
                cStmt = conexion.prepareCall("{call obtenerEspecialidadBuscar(?, ?, ?)}");  
                cStmt.setString(3, buscar);  
            }
            // sin el txt buscar
            else
            {
                cStmt = conexion.prepareCall("{call obtenerEspecialidades(?, ?)}");  
            }
            cStmt.setInt(1, numeroPaginas);    
            cStmt.setInt(2, totalRegistro);  
            cStmt.execute();    
                 final ResultSet rs = cStmt.getResultSet(); 
            //ResultSet rs = this.conn.query("SELECT * FROM MEDICO");

                while (rs.next()) {
                    Especialidad value = new Especialidad();
                    value.setId(rs.getInt("id"));
                    value.setDescripcion(rs.getString("descripcion"));                                
                    value.setRegistros(rs.getInt("registros"));
                    list.add(value);

                }
            } catch (SQLException ex) {
                System.out.println(ex.getMessage());
            } finally {
                //this.conn.close();
            }

            return list;
    }
    
    
    
}
