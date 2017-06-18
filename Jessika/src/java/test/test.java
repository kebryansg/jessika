/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import mvc.controlador.C_BD;
import mvc.controlador.con_db;
import mvc.modelo.smDaoImp.ConsultaDaoImp;

/**
 *
 * @author kebryan
 */
public class test {

    public static void main(String[] args) throws ParseException, IOException {
        //System.out.println(ruta());
        Date fechaI = fechaSQL("2017-06-04");
        Date fechaF = fechaSQL("2017-06-14");
        //System.out.println(new ConsultaDaoImp().listConsultas(fechaI, fechaF, 2021, "").size());
        //System.out.println(new ConsultaDaoImp().listConsultas(6, 2, 2021, "").size());
    }

    public static int getID(String tabla) {
        int id = 0;
        C_BD conn = con_db.open(con_db.MSSQL_IP);
        try {
            ResultSet rs = conn.query("select IDENT_CURRENT('" + tabla + "') id");
            while (rs.next()) {
                id = rs.getInt("id");
            }
        } catch (SQLException e) {
        } finally {
            conn.close();
        }
        return id;
    }

    public static int getID_SM(String tabla) {
        int id = 0;
        C_BD conn = con_db.open(con_db.MSSQL_SM);
        try {
            ResultSet rs = conn.query("select IDENT_CURRENT('" + tabla + "') id");
            while (rs.next()) {
                id = rs.getInt("id");
            }
        } catch (SQLException e) {
        } finally {
            conn.close();
        }
        return id;
    }

    public static Date fechaSQL(String stringFecha) {
        try {
            DateFormat fechaHora = new SimpleDateFormat("yyyy-MM-dd");
            Date convertido = fechaHora.parse(stringFecha);
            return convertido;
        } catch (ParseException e) {
            return null;
        }

    }

    public static String SQLSave(Date fecha) {
        DateFormat fechaHora = new SimpleDateFormat("yyyy-MM-dd");
        String convertido = fechaHora.format(fecha);
        return convertido;
    }

    public static String getSexo(Boolean sexo) {
        return sexo ? "1" : "0";
    }

    public static Boolean setSexo(String sexo) {
        return sexo.equals("1");
    }

    public static String ruta() throws IOException {
        return new File(".").getCanonicalPath().replace("\\", "/") + "/web/";
    }

}
