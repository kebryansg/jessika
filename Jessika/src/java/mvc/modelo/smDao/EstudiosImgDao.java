
package mvc.modelo.smDao;

import java.util.List;
import mvc.controlador.entidades.sm.DetallesEstudiosImg;
import mvc.controlador.entidades.sm.EstudioImagen;


public interface EstudiosImgDao {
    public EstudioImagen edit(int id);
    public List<DetallesEstudiosImg> list_det(int idTipoEstudiosImg, int idEstudiosImg,String filter, int pag, int top);
}
