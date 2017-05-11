/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mvc.modelo.smDao;

import java.util.List;
import mvc.controlador.entidades.sm.Especialidad;

/**
 *
 * @author Byron
 */
public interface EspecialidadDao {
    public List<Especialidad> list();
    public List<Especialidad> list(int id);
    public Especialidad edit (int id);
    public boolean save (Especialidad value);
    public boolean delete (int id);
    public int id();
    public int totalRegistros(int bandera, String buscar);
    public List<Especialidad> list(int numeroPaginas, int totalRegistro,int bandera, String buscar);
    
    
    
}
