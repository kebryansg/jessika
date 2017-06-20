package mvc.modelo.smDaoImp;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import mvc.controlador.C_BD;
import mvc.controlador.con_db;
import mvc.controlador.entidades.sm.Caso;
import mvc.controlador.entidades.sm.Consulta;
import mvc.controlador.entidades.sm.Especialidad;
import mvc.controlador.entidades.sm.MedicoEspecialidad;
import mvc.controlador.entidades.sm.SignosVitales;
import mvc.modelo.smDao.ConsultaDao;
import test.list_count;

public class ConsultaDaoImp implements ConsultaDao {

    C_BD conn;

    @Override
    public boolean save(Consulta value) {
        this.conn = con_db.open(con_db.MSSQL_SM);
        String sql = "";
        try {
            if (value.getId() == 0) {
                CallableStatement call = this.conn.getConexion().prepareCall("{call dbo.saveConsulta(?,?,?,?,?,?,?,?,?,?,?)}");
                call.setInt("idMedico_Especialidad", value.getIdMedicoEspecialidad().getId());
                call.setInt("idSignosvitales", value.getIdSignosvitales().getId());
                call.setInt("idCaso", value.getIdCaso().getId());
                call.setInt("idMetodo", value.getIdMetodo());
                call.setInt("idTipoConsulta", value.getIdTipoConsulta());
                call.setString("motivo", value.getMotivo());
                call.setString("diagnostico", value.getDiagnostico());
                call.setString("prescripcion", value.getPrescripcion());
                call.setString("sintomas", value.getSintoma());
                call.registerOutParameter("id", Types.INTEGER);
                call.setDate("fecha", new java.sql.Date(value.getFecha().getTime()));
                call.execute();
                value.setId(call.getInt("id"));
                System.out.println("Consulta -" +value.getId());
            } else {
                sql = "UPDATE [dbo].[consulta]\n"
                        + "   SET [idMedico_Especialidad] = '" + value.getIdMedicoEspecialidad().getId() + "'\n"
                        + "   SET [fecha] = '" + test.test.SQLSave(value.getFecha()) + "'\n"
                        + "   SET [motivo] = '" + value.getMotivo() + "'\n"
                        + "   SET [diagnostico] = '" + value.getDiagnostico() + "'\n"
                        + "   SET [prescripcion] = '" + value.getPrescripcion() + "'\n"
                        + "   SET [sintomas] = '" + value.getSintoma() + "'\n"
                        + " WHERE id = '" + value.getId() + "'";
            }
            //conn.execute(sql);
            System.out.println(sql);
            return true;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return false;
        } finally {
            this.conn.close();
        }
    }

    @Override
    public Consulta edit(int id) {
        this.conn = con_db.open(con_db.MSSQL_SM);
        ResultSet rs = null;
        Consulta value = new Consulta();
        try {
            CallableStatement call = this.conn.getConexion().prepareCall("{call dbo.getConsulta(?)}");
            call.setInt("id", id);
            call.execute();
            rs = call.getResultSet();
            while (rs.next()) {
                value.setId(rs.getInt("id"));
                value.setFecha(rs.getDate("fecha"));
                value.setMotivo(rs.getString("motivo"));
                value.setDiagnostico(rs.getString("diagnostico"));
                value.setPrescripcion(rs.getString("prescripcion"));
                value.setSintoma(rs.getString("sintomas"));
                value.setIdCaso(new Caso(rs.getInt("idCaso"),rs.getInt("hc")));
                
                MedicoEspecialidad m_e = new MedicoEspecialidad(rs.getInt("idMedico_Especialidad"));
                m_e.setIdEspecialidad(new Especialidad(0, rs.getString("especialidad")));
                value.setIdMedicoEspecialidad(m_e);
                
                value.setIdSignosvitales(new SignosVitales(rs.getInt("idSignosvitales")));
                value.setIdMetodo(rs.getInt("idMetodo"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            this.conn.close();
        }
        return value;
    }

    @Override
    public list_count listConsultas(Date fechaI, Date fechaF,int opFecha, int idHC,int tops,int pag, String filter) {
        this.conn = con_db.open(con_db.MSSQL_SM);
        list_count l = new list_count();
        List<Consulta> list = new ArrayList<>();
        try {
            CallableStatement call = this.conn.getConexion().prepareCall("{call dbo.getConsultas(?,?,?,?,?,?,?,?)}");
            call.setInt("idHC", idHC);
            call.setInt("opFecha", opFecha);
            call.setNull("fecha", Types.DATE);
            call.setDate("fechaI", new java.sql.Date(fechaI.getTime()));
            call.setDate("fechaF", new java.sql.Date(fechaF.getTime()));
            
            call.setInt("tops", tops);
            call.setInt("pag", pag);
            call.registerOutParameter("total", Types.INTEGER);
            call.execute();
            ResultSet rs = call.getResultSet();
            while (rs.next()) {
                Consulta value = new Consulta(rs.getInt("id"));
                value.setIdCaso(new Caso(rs.getInt("idCaso")));
                value.setFecha(rs.getDate("fecha"));
                value.setMotivo(rs.getString("motivo"));
                value.setSintoma(rs.getString("sintomas"));
                value.setPrescripcion(rs.getString("prescripcion"));
                list.add(value);
            }
            l.setList(list);
            l.setTotal(call.getInt("total"));
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            this.conn.close();
        }
        return l;
    }

    @Override
    public list_count listConsultas(Date fecha, int opFecha, int idHC,int tops,int pag, String filter) {
        this.conn = con_db.open(con_db.MSSQL_SM);
        list_count l = new list_count();
        List<Consulta> list = new ArrayList<>();
        try {
            CallableStatement call = this.conn.getConexion().prepareCall("{call dbo.getConsultas(?,?,?,?,?,?,?,?)}");
            call.setInt("idHC", idHC);
            call.setInt("opFecha", opFecha);
            call.setDate("fecha", new java.sql.Date(fecha.getTime()));
            call.setNull("fechaI", Types.DATE);
            call.setNull("fechaF", Types.DATE);
            
            call.setInt("tops", tops);
            call.setInt("pag", pag);
            call.registerOutParameter("total", Types.INTEGER);
            call.execute();
            ResultSet rs = call.getResultSet();
            while (rs.next()) {
                Consulta value = new Consulta(rs.getInt("id"));
                value.setIdCaso(new Caso(rs.getInt("idCaso")));
                value.setFecha(rs.getDate("fecha"));
                value.setMotivo(rs.getString("motivo"));
                value.setSintoma(rs.getString("sintomas"));
                value.setPrescripcion(rs.getString("prescripcion"));
                list.add(value);
            }
            l.setList(list);
            l.setTotal(call.getInt("total"));
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            this.conn.close();
        }
        return l;
    }

}
