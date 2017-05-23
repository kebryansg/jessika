
package mvc.modelo.smDao;

import mvc.controlador.entidades.sm.Consulta;

public interface ConsultaDao {
    public boolean save(Consulta value);
    public Consulta edit(int id);
}
