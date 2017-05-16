package mvc.modelo.smDaoImp;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import mvc.controlador.C_BD;
import mvc.controlador.con_db;
import mvc.controlador.entidades.sm.DetalleEstudiosLabs;
import mvc.controlador.entidades.sm.EstudiosLaboratorio;
import mvc.modelo.smDao.EstudiosLaboratorioDao;

public class EstudiosLaboratorioDaoImp implements EstudiosLaboratorioDao {

    C_BD conn;

    @Override
    public List<EstudiosLaboratorio> list() {
        this.conn = con_db.open(con_db.MSSQL_SM);
        List<EstudiosLaboratorio> list = new ArrayList<>();
        ResultSet rs = this.conn.query("select * from dbo.estudiosLaboratorio");
        try {
            while (rs.next()) {
                EstudiosLaboratorio value = new EstudiosLaboratorio(rs.getInt("id"));
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
    public EstudiosLaboratorio edit(int value) {
        this.conn = con_db.open(con_db.MSSQL_SM);
        EstudiosLaboratorio esLab = new EstudiosLaboratorio(0);
        ResultSet rs = this.conn.query("select * from dbo.estudiosLaboratorio where id = " + value);
        try {
            while (rs.next()) {
                esLab.setId(rs.getInt("id"));
                esLab.setDescripcion(rs.getNString("descripcion").toUpperCase());
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            this.conn.close();
        }
        return esLab;
    }

    @Override
    public List<DetalleEstudiosLabs> list_Det(int categoria, String filter, int pag, int top) {
        this.conn = con_db.open(con_db.MSSQL_SM);
        List<DetalleEstudiosLabs> list = new ArrayList<>();
        String paginacion = (top != -1) ? "OFFSET " + pag + " ROWS FETCH NEXT " + top + " ROWS ONLY;" : "";
        String categoriaSQL = (categoria != 0) ? ("and el.id = " + categoria) : "";
        System.out.println("select del.id del_id, del.descripcion del_descripcion, el.id el_id, el.descripcion el_descripcion from dbo.estudiosLaboratorio el inner join dbo.detalleEstudiosLabs del on el.id = del.idEstudiosLab where (del.descripcion like '%" + filter + "%')  " + categoriaSQL + " order by del.id " + paginacion);
        ResultSet rs = this.conn.query("select del.id del_id, del.descripcion del_descripcion, el.id el_id, el.descripcion el_descripcion from dbo.estudiosLaboratorio el inner join dbo.detalleEstudiosLabs del on el.id = del.idEstudiosLab where (del.descripcion like '%" + filter + "%')  " + categoriaSQL + " order by del.id " + paginacion);
        try {
            while (rs.next()) {
                DetalleEstudiosLabs detEst = new DetalleEstudiosLabs(rs.getInt("del_id"));
                detEst.setIdEstudiosLab(new EstudiosLaboratorio(rs.getInt("el_id"), rs.getNString("el_descripcion")));
                detEst.setDescripcion(rs.getNString("del_descripcion").toUpperCase());
                list.add(detEst);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            this.conn.close();
        }
        return list;
    }

}
