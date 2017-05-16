
package mvc.modelo.smDao;

import java.util.List;
import mvc.controlador.entidades.sm.DetalleEstudiosLabs;
import mvc.controlador.entidades.sm.EstudiosLaboratorio;

public interface EstudiosLaboratorioDao {
    public List<EstudiosLaboratorio> list();
    public List<DetalleEstudiosLabs> list_Det(int value,String filter, int pag, int top);
    public EstudiosLaboratorio edit(int value);
}
