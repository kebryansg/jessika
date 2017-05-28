/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mvc.modelo.smDaoImp;

import java.util.List;
import mvc.controlador.C_BD;
import mvc.controlador.con_db;
import mvc.controlador.entidades.sm.ConsultaEstudiosImagen;
import mvc.modelo.smDao.ConsultaEstudiosImagenDao;

/**
 *
 * @author kebryan
 */
public class ConsultaEstudiosImagenDaoImp implements ConsultaEstudiosImagenDao{
    C_BD conn;

    @Override
    public boolean save(ConsultaEstudiosImagen value) {
        this.conn = con_db.open(con_db.MSSQL_SM);
        String sql = "";
        try {
            if (value.getId() == 0) {
                sql = "INSERT INTO [dbo].[consultaEstudiosImagen]([idConsulta],[idDetalleEstudiosImagen],[detExtremidad]) VALUES(" + value.getIdConsulta().getId() + "," + value.getIdDetalleEstudiosImagen().getId() + ",'" + value.getDetExtremidad()+ "')";
            } else {
                sql = "UPDATE [dbo].[consultaEstudiosImagen]\n"
                        + "   SET [idConsulta] = '" + value.getIdConsulta().getId() + "'\n"
                        + "   SET [idDetalleEstudiosImagen] = '" + value.getIdDetalleEstudiosImagen().getId() + "'\n"
                        + "   SET [detExtremidad] = '" + value.getDetExtremidad()+ "'\n"
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
    public ConsultaEstudiosImagen edit(int id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<ConsultaEstudiosImagen> list(int idConsulta) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
