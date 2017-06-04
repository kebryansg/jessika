package mvc.modelo.smDaoImp;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import mvc.controlador.C_BD;
import mvc.controlador.con_db;
import mvc.controlador.entidades.sm.Causa;
import mvc.modelo.smDao.CausaDao;

public class CausaDaoImp implements CausaDao {

    C_BD conn;

    @Override
    public boolean save(Causa value) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<Causa> list_filter(String value) {
        this.conn = con_db.open(con_db.MSSQL_SM);
        List<Causa> list = new ArrayList<>();
        ResultSet rs = this.conn.query("SELECT * FROM CAUSA WHERE UPPER(descripcion) LIKE '%" + value + "%'");
        System.out.println("SELECT * FROM CAUSA WHERE UPPER(descripcion) LIKE '%" + value + "%'");
        try {
            while (rs.next()) {
                Causa causa = new Causa(rs.getInt("id"));
                causa.setDescripcion(rs.getNString("descripcion").toUpperCase());
                list.add(causa);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            this.conn.close();
        }
        return list;
    }

}
