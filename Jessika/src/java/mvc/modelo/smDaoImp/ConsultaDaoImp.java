package mvc.modelo.smDaoImp;

import java.sql.ResultSet;
import java.sql.SQLException;
import mvc.controlador.C_BD;
import mvc.controlador.con_db;
import mvc.controlador.entidades.sm.Caso;
import mvc.controlador.entidades.sm.Consulta;
import mvc.controlador.entidades.sm.MedicoEspecialidad;
import mvc.controlador.entidades.sm.Metodos;
import mvc.controlador.entidades.sm.SignosVitales;
import mvc.modelo.smDao.ConsultaDao;

public class ConsultaDaoImp implements ConsultaDao {

    C_BD conn;

    @Override
    public boolean save(Consulta value) {
        this.conn = con_db.open(con_db.MSSQL_SM);
        String sql = "";
        try {
            if (value.getId() == 0) {
                sql = "INSERT INTO [dbo].[consulta]([idMedico_Especialidad],[idMetodo],[idSignosvitales],[idCaso],[fecha],[motivo],[diagnostico],[prescripcion],[sintomas]) "
                        + "VALUES(" + value.getIdMedicoEspecialidad().getId() + ", " + value.getIdMetodo().getId() + ", " + value.getIdSignosvitales().getId() + ", " + value.getIdCaso().getId() + ", '" + test.test.SQLSave(value.getFecha()) + "', '" + value.getMotivo() + "', '" + value.getDiagnostico() + "', '" + value.getPrescripcion() + "', '" + value.getSintoma() + "');";
            } else {
                sql = "UPDATE [dbo].[consulta]\n"
                        + "   SET [idMedico_Especialidad] = '" + value.getIdMedicoEspecialidad().getId()+ "'\n"
                        + "   SET [fecha] = '" + test.test.SQLSave(value.getFecha()) + "'\n"
                        + "   SET [motivo] = '" + value.getMotivo()+ "'\n"
                        + "   SET [diagnostico] = '" + value.getDiagnostico()+ "'\n"
                        + "   SET [prescripcion] = '" + value.getPrescripcion()+ "'\n"
                        + "   SET [sintomas] = '" + value.getSintoma()+ "'\n"
                        + " WHERE id = '" + value.getId() + "'";
            }
            conn.execute(sql);
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
        ResultSet rs = this.conn.query("select * from consulta where id = '" + id + "'");
        Consulta value = new Consulta();
        try {
            while (rs.next()) {
                value.setId(rs.getInt("id"));
                value.setFecha(rs.getDate("fecha"));
                value.setMotivo(rs.getNString("motivo"));
                value.setDiagnostico(rs.getNString("diagnostico"));
                value.setPrescripcion(rs.getNString("prescripcion"));
                value.setSintoma(rs.getNString("sintomas"));
                value.setIdCaso(new Caso(rs.getInt("idCaso")));
                value.setIdMedicoEspecialidad(new MedicoEspecialidad(rs.getInt("idMedico_Especialidad")));
                value.setIdSignosvitales(new SignosVitales(rs.getInt("idSignosvitales")));
                value.setIdMetodo(new Metodos(rs.getInt("idMetodo")));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            this.conn.close();
        }
        return value;
    }

}
