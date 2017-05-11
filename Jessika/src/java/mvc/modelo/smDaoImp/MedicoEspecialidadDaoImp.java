/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mvc.modelo.smDaoImp;

import java.util.List;
import mvc.controlador.C_BD;
import mvc.controlador.con_db;
import mvc.controlador.entidades.sm.Medico;
import mvc.controlador.entidades.sm.MedicoEspecialidad;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import mvc.controlador.entidades.sm.Especialidad;
import mvc.modelo.smDao.MedicoEspecialidadDao;

/**
 *
 * @author Deivi
 */
public class MedicoEspecialidadDaoImp implements MedicoEspecialidadDao {
    C_BD conn;
    @Override
    public boolean save(MedicoEspecialidad value) {
        String sql="";
        this.conn= con_db.open(con_db.MSSQL_SM);
        try 
        {
            //Insert
            if(value.getId()==0)
            {
                sql="INSERT INTO medico_especialidad (idMedico,idEspecialidad) values ('"+value.getIdMedico().getId()+"','"+value.getIdEspecialidad().getId()+"');";
            }
            //Update
            else
            {
                sql="UPDATE medico_especialidad set idEspecialidad='+"+value.getIdEspecialidad().getId()+"', idMedico='"+value.getIdMedico().getId()+"' where id='"+value.getId()+"'";
                
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
    public List<MedicoEspecialidad> list(int id) {
        this.conn = con_db.open(con_db.MSSQL_SM);
        List<MedicoEspecialidad> list = new ArrayList<>();
        ResultSet rs = this.conn.query("SELECT especialidad.id,  especialidad.descripcion from medico_especialidad inner join especialidad on especialidad.id=medico_especialidad.idEspecialidad inner join medico on medico_especialidad.idMedico=medico.id WHERE medico.id="+id+"");
        
        try {
            while (rs.next()) {
                MedicoEspecialidad value = new MedicoEspecialidad();                 
                value.setIdEspecialidad(new Especialidad(rs.getInt("id"),rs.getNString("descripcion")));                
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
    public MedicoEspecialidad edit(int id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean delete(int id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
