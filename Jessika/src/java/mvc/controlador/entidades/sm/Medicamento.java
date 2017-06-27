/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mvc.controlador.entidades.sm;

import java.sql.Date;

/**
 *
 * @author Deivi
 */
public class Medicamento {
    private Integer id;    
    private Date fecha;
    private Date hora;
    private String notasEvolucion;
    private String prescripcionMedica;
    private Ingresos ingreso;
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    
    public Ingresos getIngreso() {
        return ingreso;
    }

    public void setIngreso(Ingresos ingreso) {
        this.ingreso = ingreso;
    }

    public Date getHora() {
        return hora;
    }

    public void setHora(Date hora) {
        this.hora = hora;
    }

    public String getNotasEvolucion() {
        return notasEvolucion;
    }

    public void setNotasEvolucion(String notasEvolucion) {
        this.notasEvolucion = notasEvolucion;
    }

    public String getPrescripcionMedica() {
        return prescripcionMedica;
    }

    public void setPrescripcionMedica(String prescripcionMedica) {
        this.prescripcionMedica = prescripcionMedica;
    }

    public Medicamento(Integer id, Date fecha, Date hora, String notasEvolucion, String prescripcionMedica, Ingresos ingreso) {
        this.id = id;        
        this.fecha = fecha;
        this.hora = hora;
        this.notasEvolucion = notasEvolucion;
        this.prescripcionMedica = prescripcionMedica;
        this.ingreso = ingreso;
    }
    

    

    
    
}
