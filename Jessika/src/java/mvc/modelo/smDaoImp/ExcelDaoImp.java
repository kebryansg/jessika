/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mvc.modelo.smDaoImp;

import java.util.Date;
import mvc.modelo.smDao.ExcelDao;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import mvc.controlador.con_db;
import mvc.controlador.entidades.sm.Excel;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import mvc.controlador.C_BD;
import org.apache.poi.xssf.usermodel.XSSFFormulaEvaluator;

/**
 *
 * @author Deivi
 */
public class ExcelDaoImp implements ExcelDao {
C_BD conn;
    @Override
    public boolean generarExcelIngresos(Date fecha,String path,String nombreEstablecimiento) {
        try
        {
            Connection conexion;          
            conexion = con_db.open(con_db.MSSQL_SM).getConexion();
            CallableStatement cStmt=conexion.prepareCall("{call obtenerIngresosMensuales(?)}"); 
            cStmt.setDate(1, new java.sql.Date(fecha.getTime()));
            cStmt.execute();    
            final ResultSet rs = cStmt.getResultSet(); 
            
            //Excel objExcel= new Excel(new File("c:\\agosto.xlsx"), new File("c:\\agosto.xlsx"));                       
            //FileInputStream fileInputStream = new FileInputStream("./xlsx/plantillaIngresosMensuales2017.xlsx");
            //File file = new File("/xlsx/plantillaIngresosMensuales2017.xlsx");
            int r=5;
            XSSFWorkbook wb = new XSSFWorkbook(path);
            XSSFSheet sheet = wb.getSheetAt(0);
            
            int c=5;
            XSSFCell cell=null;
            while(rs.next())
            //for (int r=5;r < 15; r++ )
            {
                XSSFRow row = sheet.getRow(r);
                //for (int c=5;c < 15; c++ )
                {
                    //MES_RECOLECCIÓN
                     cell= row.getCell(5);                     
                     cell.setCellValue(rs.getInt("MesRecoleccion"));
                     //No. HISTORIA CLÍNICA
                     cell= row.getCell(6);
                     cell.setCellValue(rs.getInt("NHistoriaClinica"));
                     //No. DE ARCHIVO
                     cell= row.getCell(7);
                     cell.setCellValue(rs.getInt("NoArchivo"));
                     //No. CÉDULA DE IDENTIDAD O PASAPORTE
                     cell= row.getCell(8);
                     cell.setCellValue(rs.getString("cedula"));
                     //PRIMER NOMBRE
                     cell= row.getCell(9);
                     cell.setCellValue(rs.getString("nombre1"));
                     //SEGUNDO NOMBRE
                     cell= row.getCell(10);
                     cell.setCellValue(rs.getString("nombre2"));
                     //PRIMER APELLIDO
                     cell= row.getCell(11);
                     cell.setCellValue(rs.getString("apellido1"));
                     //SEGUNDO APELLIDO
                     cell= row.getCell(12);
                     cell.setCellValue(rs.getString("apellido2"));
                     //NACIONALIDAD
                     cell= row.getCell(13);
                     cell.setCellValue(rs.getInt("Nacionalidad"));
                     //Indique el País en caso de escoger Nacionalidad, opción 2
                     cell= row.getCell(14);
                     cell.setCellValue(rs.getString("Pais"));
                     //SEXO
                     cell= row.getCell(16);
                     cell.setCellValue(rs.getInt("sexo"));
                     //"Fecha Nacimiento AÑO AAAA"
                     cell= row.getCell(17);
                     cell.setCellValue(rs.getInt("AñoNacimiento"));
                     //"FECHA NACIMIENTO MES MM"
                     cell= row.getCell(18);
                     cell.setCellValue(rs.getInt("MesNacimiento"));
                     //FECHA NACIMIENTO "DÍA DD"
                     cell= row.getCell(19);
                     cell.setCellValue(rs.getInt("DiaNacimiento"));
                     
                    /*//Formula                    
                    cell= row.getCell(20);
                    String strFormula= "CONCATENAR(R"+String.valueOf(r)+";\"/\";S"+String.valueOf(r)+" ;\"/\";T"+String.valueOf(r)+"  )";
                    cell.setCellType(XSSFCell.CELL_TYPE_FORMULA);
                    cell.setCellFormula(strFormula);
                    //cell.setCellValue(row.getCell(20).toString());
                     */
                     
                     //"Condición de la edad
                     cell= row.getCell(21);
                     cell.setCellValue(rs.getInt("condicionEdad"));
                     //Edad del paciente
                     cell= row.getCell(22);
                     cell.setCellValue(rs.getInt("EdadCunplidaAlIngreso"));
                     //COMO SE IDENTIFICA (…) SEGÚN SU CULTURA Y COSTUMBRES
                     cell= row.getCell(23);
                     cell.setCellValue(rs.getInt("etnia"));
                     //"TIENE ALGUNA DISCAPACIDAD PERMANENTE (Al momento del ingreso)"
                     cell= row.getCell(24);
                     cell.setCellValue(rs.getInt("discapacidad"));                     
                     //Direccion PROVINCIA
                     cell= row.getCell(25);
                     cell.setCellValue(rs.getString("Provincia"));                     
                     //CANTÓN
                     cell= row.getCell(26);
                     cell.setCellValue(rs.getString("Canton"));                     
                     //PARROQUIA
                     cell= row.getCell(27);
                     cell.setCellValue(rs.getString("Parroquia"));                     
                     //DIRECCIÓN
                     cell= row.getCell(28);
                     cell.setCellValue(rs.getString("direccion"));                     
                     //"AÑO AAAA" INGRESO
                     cell= row.getCell(30);
                     cell.setCellValue(rs.getInt("AñoIngreso"));                     
                     //"MES MM" INGRESO
                     cell= row.getCell(31);
                     cell.setCellValue(rs.getInt("MesIngreso"));                     
                     //"DÍA DD" INGRESO
                     cell= row.getCell(32);
                     cell.setCellValue(rs.getInt("DiaIngreso"));                     
                     //"AÑO AAAA" EGRESO
                     cell= row.getCell(34);
                     cell.setCellValue(rs.getInt("AñoEgreso"));                     
                     //"MES MM" EGRESO
                     cell= row.getCell(35);
                     cell.setCellValue(rs.getInt("MesEgreso"));                     
                     //"DÍA DD" EGRESO
                     cell= row.getCell(36);
                     cell.setCellValue(rs.getInt("DiaEgreso"));                     
                     //DÍAS DE ESTADA
                     cell= row.getCell(38);
                     cell.setCellValue(rs.getInt("DiasEstada"));                     
                     //CONDICIÓN AL EGRESO
                     cell= row.getCell(39);
                     cell.setCellValue(rs.getInt("condicionEgreso"));                     
                     //ESPECIALIDAD DEL EGRESO
                     cell= row.getCell(40);
                     cell.setCellValue(rs.getInt("idEspecialidadEgreso"));                     
                     //DEFINITIVO DE EGRESO
                     cell= row.getCell(41);
                     cell.setCellValue(rs.getString("definitivoEgreso"));                     
                     //1. SECUNDARIOS DE EGRESO
                     cell= row.getCell(42);
                     cell.setCellValue(rs.getString("secundarioEgreso"));                     
                     //2. SECUNDARIOS DE EGRESO
                     cell= row.getCell(43);
                     cell.setCellValue(rs.getString("secundarioEgreso2"));                     
                     //3. CAUSA EXTERNA
                     cell= row.getCell(44);
                     cell.setCellValue(rs.getString("causaExterna"));                     
                    //"CÓDIGO CIE - 10  DIAGNÓSTICO DEFINITIVO"
                    cell= row.getCell(45);
                    cell.setCellValue(rs.getString("codigoDiagnosticoDefinitivo"));
                }
                r++;
            }
            //refresco las formulas del libro
             XSSFFormulaEvaluator.evaluateAllFormulaCells(wb);
            
            SimpleDateFormat dateFormat = null;
            dateFormat =new SimpleDateFormat("yyyy");
            int anio=Integer.parseInt(dateFormat.format(fecha));
            dateFormat =new SimpleDateFormat("MM");
            int mes=Integer.parseInt(dateFormat.format(fecha));
            String[] meses = {"Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciemrbre"};            
            FileOutputStream fileOut = new FileOutputStream("D:\\Ingresos "+meses[mes-1]+" del "+anio+" "+nombreEstablecimiento+" .xlsx");
            wb.write(fileOut);
            fileOut.flush();
            fileOut.close();
            return true;
        }
        catch(Exception ex)
        {
            return false;
            
            
        }
        
    }
    
    
}
