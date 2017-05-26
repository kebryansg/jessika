
package mvc.modelo.smDaoImp;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import mvc.controlador.C_BD;
import mvc.controlador.con_db;
import mvc.controlador.entidades.sm.DetallesEstudiosImg;
import mvc.controlador.entidades.sm.EstudioImagen;
import mvc.controlador.entidades.sm.TipoEstudioImg;
import mvc.modelo.smDao.EstudiosImgDao;

public class EstudiosImgDaoImp implements EstudiosImgDao{
    C_BD conn;

    @Override
    public EstudioImagen edit(int id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<DetallesEstudiosImg> list_det(int idTipoEstudiosImg, int idEstudiosImg,String filter, int pag, int top) {
        this.conn = con_db.open(con_db.MSSQL_SM);
        List<DetallesEstudiosImg> list = new ArrayList<>();
        String paginacion = (top != -1) ? "OFFSET " + pag + " ROWS FETCH NEXT " + top + " ROWS ONLY;" : "";
        String tipoSQL = (idTipoEstudiosImg != 0) ? (" and t_est.id = " + idTipoEstudiosImg) : "";
        String estudioSQL = (idEstudiosImg != 0) ? (" and est_i.id = " + idEstudiosImg) : "";
        String sql =("select t_est.descripcion t_descripcion, det_est_i.id, det_est_i.descripcion, det_est_i.extremidades from dbo.detallesEstudiosImg det_est_i inner join dbo.estudioImagen est_i on est_i.id = det_est_i.idEstudiosImg inner join dbo.tipoEstudioImg t_est on est_i.idTipoEstudioImg = t_est.id "
                + "where (det_est_i.descripcion like '%"+ filter +"%') "
                + tipoSQL
                + estudioSQL
                + " order by det_est_i.id " + paginacion);
        System.out.println(sql);
        ResultSet rs = this.conn.query(sql);
        try {
            while (rs.next()) {
                DetallesEstudiosImg value = new DetallesEstudiosImg(rs.getInt("id"));
                value.setDescripcion(rs.getNString("descripcion"));
                value.setExtremidades(rs.getString("extremidades"));
                EstudioImagen estI = new EstudioImagen(idEstudiosImg);
                estI.setIdTipoEstudioImg(new TipoEstudioImg(idTipoEstudiosImg, rs.getNString("t_descripcion")));
                value.setIdEstudiosImg(estI);
                
                list.add(value);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            this.conn.close();
        }
        return list;
    }
    
}
