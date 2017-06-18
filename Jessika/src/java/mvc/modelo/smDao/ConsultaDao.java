package mvc.modelo.smDao;

import java.util.Date;
//import java.util.List;
import mvc.controlador.entidades.sm.Consulta;
import test.list_count;

public interface ConsultaDao {

    public list_count listConsultas(Date fechaI, Date fechaF, int idHC, int tops, int pag, String filter);

    public list_count listConsultas(int tiempo, int opFecha, int idHC, int tops, int pag, String filter);

    public boolean save(Consulta value);

    public Consulta edit(int id);
}
