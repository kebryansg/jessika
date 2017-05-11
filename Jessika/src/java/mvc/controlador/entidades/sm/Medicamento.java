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
    private String medicamentoTratamiento;
    private Date fecha;
    private String Hor;
    private String Lni;
    private String Fin;
    private Ingresos ingreso;
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMedicamentoTratamiento() {
        return medicamentoTratamiento;
    }

    public void setMedicamentoTratamiento(String medicamentoTratamiento) {
        this.medicamentoTratamiento = medicamentoTratamiento;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getHor() {
        return Hor;
    }

    public void setHor(String Hor) {
        this.Hor = Hor;
    }

    public String getLni() {
        return Lni;
    }

    public void setLni(String Lni) {
        this.Lni = Lni;
    }

    public String getFin() {
        return Fin;
    }

    public void setFin(String Fin) {
        this.Fin = Fin;
    }

    public Ingresos getIngreso() {
        return ingreso;
    }

    public void setIngreso(Ingresos ingreso) {
        this.ingreso = ingreso;
    }

    public Medicamento(Integer id, String medicamentoTratamiento, Date fecha, String Hor, String Lni, String Fin, Ingresos ingreso) {
        this.id = id;
        this.medicamentoTratamiento = medicamentoTratamiento;
        this.fecha = fecha;
        this.Hor = Hor;
        this.Lni = Lni;
        this.Fin = Fin;
        this.ingreso = ingreso;
    }

    
    
}
