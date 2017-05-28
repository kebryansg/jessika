/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mvc.modelo.smDaoImp;

import java.sql.ResultSet;
import java.sql.SQLException;
import mvc.controlador.C_BD;
import mvc.controlador.con_db;
import mvc.controlador.entidades.sm.SignosVitales;
import mvc.modelo.smDao.SignosVitalesDao;

/**
 *
 * @author kebryan
 */
public class SignosVitalesDaoImp implements SignosVitalesDao{
    C_BD conn;

    @Override
    public boolean save(SignosVitales value) {
        this.conn = con_db.open(con_db.MSSQL_SM);
        String sql = "";
        try {
            if (value.getId() == 0) {
                sql = "INSERT INTO [dbo].[signosVitales]([peso],[talla],[presion],[temperatura],[fum],[fuc],[frecuenciaC]) VALUES('" + value.getPeso()+ "','" + value.getTalla()+ "','" + value.getPresion()+ "','" + value.getTemperatura()+ "','" + test.test.SQLSave(value.getFum())+ "','" + test.test.SQLSave(value.getFuc())+ "','" + value.getFrecuenciaC()+ "')";
            } else {
                sql = "UPDATE [dbo].[signosVitales]\n"
                        + "   SET [peso] = '" + value.getPeso()+ "'\n"
                        + "   SET [talla] = '" + value.getTalla()+ "'\n"
                        + "   SET [presion] = '" + value.getPresion()+ "'\n"
                        + "   SET [temperatura] = '" + value.getTemperatura()+ "'\n"
                        + "   SET [fum] = '" + test.test.SQLSave(value.getFum())+ "'\n"
                        + "   SET [fuc] = '" + test.test.SQLSave(value.getFuc())+ "'\n"
                        + "   SET [frecuenciaC] = '" + value.getFrecuenciaC()+ "'\n"
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
    public SignosVitales editar(int idConsulta) {
        this.conn = con_db.open(con_db.MSSQL_SM);
        ResultSet rs = this.conn.query("select * from signosVitales inner join dbo.consulta on consulta.idSignosvitales = signosVitales.id where consulta.id = '" + idConsulta + "'");
        SignosVitales value = new SignosVitales();
        try {
            while (rs.next()) {
                value.setId(rs.getInt("id"));
                value.setPeso(rs.getInt("peso"));
                value.setTalla(rs.getInt("talla"));
                value.setPresion(rs.getNString("presion"));
                value.setTemperatura(rs.getInt("temperatura"));
                value.setFum(rs.getDate("fum"));
                value.setFuc(rs.getDate("fuc"));
                value.setTemperatura(rs.getInt("frecuenciaC"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            this.conn.close();
        }
        return value;
    }
    
}
