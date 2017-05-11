/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mvc.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mvc.controlador.entidades.sm.EspecialidadEgreso;
import mvc.controlador.entidades.sm.HistorialClinico;
import mvc.controlador.entidades.sm.Ingresos;
import mvc.controlador.entidades.sm.Medico;
import mvc.controlador.entidades.sm.TipoIngreso;
import mvc.modelo.smDao.EspecialidadDao;
import mvc.modelo.smDao.IngresosDao;
import mvc.modelo.smDao.MedicoDao;
import mvc.modelo.smDaoImp.EspecialidadDaoImp;
import mvc.modelo.smDaoImp.IngresosDaoImp;
import mvc.modelo.smDaoImp.MedicoDaoImp;
import org.codehaus.jackson.map.ObjectMapper;
import java.util.List;
import mvc.controlador.entidades.sm.Caso;
import mvc.controlador.entidades.sm.Medicamento;


/**
 *
 * @author Deivi
 */
public class sIngresosHospital extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType( "text/html; charset=iso-8859-1" );
        PrintWriter out = response.getWriter();
        String opcion = request.getParameter("opcion");
       // private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();

        //opcion 1 cargar paciente
        if( "1".equals(opcion))        
        {
             IngresosDao ingresos = new IngresosDaoImp();
             String cedula = request.getParameter("cedula");
             HistorialClinico historia= new HistorialClinico();
             historia=ingresos.historia(cedula); 
             ObjectMapper OBJECT_MAPPER = new ObjectMapper();
             String json = OBJECT_MAPPER.writeValueAsString(historia);
             response.getWriter().write(json);

        }
        //opcion 2 guardar ingresos
        if( "2".equals(opcion))        
        {
            try
            {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");                
                Integer idHistoria =Integer.valueOf(request.getParameter("idHistoria"));
                Date fechaIngreso = sdf.parse(request.getParameter("fechaIngreso"));
                Integer idTipoIngreso =Integer.valueOf(request.getParameter("idTipoIngreso"));
                Integer idEspecialidadEgreso =Integer.valueOf(request.getParameter("idEspecialidadEgreso"));
                Date fechaEgreso = sdf.parse(request.getParameter("fechaEgreso"));
                SimpleDateFormat format = new SimpleDateFormat("HH:MM");
                Date horaIngreso = format.parse(request.getParameter("horaIngreso"));
                Boolean sos = Boolean.valueOf(request.getParameter("sos"));
                Integer condicionEgreso = Integer.valueOf(request.getParameter("condicionEgreso"));
                String definitivoEgreso =request.getParameter("definitivoEgreso");
                String secundarioEgreso =request.getParameter("secundarioEgreso");
                String secundarioEgreso2 =request.getParameter("secundarioEgreso2");
                String causaExterna =request.getParameter("causaExterna");
                String codigoDiagnosticoDefinitivo =request.getParameter("codigoDiagnosticoDefinitivo");
                EspecialidadEgreso idEspecialidadEgres= new EspecialidadEgreso();
                idEspecialidadEgres.setId(idEspecialidadEgreso);
                TipoIngreso idTipoIngre=new TipoIngreso();
                idTipoIngre.setId(idTipoIngreso);   
               IngresosDao ingr= new IngresosDaoImp();
               Ingresos unIngreso = new Ingresos(fechaIngreso,fechaEgreso,horaIngreso,sos,condicionEgreso,definitivoEgreso,secundarioEgreso,secundarioEgreso2,causaExterna,codigoDiagnosticoDefinitivo,idEspecialidadEgres,idTipoIngre);
               unIngreso.setId(0);
               ingr.Save(unIngreso, idHistoria);
                
                //EspecialidadDao esp = new EspecialidadDaoImp();
                
                
                
            }
            catch(Exception ex)
            {
                out.println(ex.getMessage());
            }
        }
        //cargar total de registros
        else if("3".equals(opcion))
        {
            Integer bandera =Integer.valueOf(request.getParameter("bandera"));
            String buscar =request.getParameter("buscar");
            IngresosDao ing= new IngresosDaoImp();
            out.println(ing.totalRegistros(bandera, buscar));
        }
        //cargar pacientes paginados
        else if("4".equals(opcion))
        {
            
            Integer bandera =Integer.valueOf(request.getParameter("bandera"));
            String buscar =request.getParameter("buscar");
            IngresosDao historias= new IngresosDaoImp();
            Integer totalMostrar =Integer.valueOf(request.getParameter("totalMostrar"));
            Integer  pagina =Integer.valueOf( request.getParameter("pagina"));
            List<HistorialClinico> list= historias.list(pagina,totalMostrar,bandera,buscar); 
             ObjectMapper OBJECT_MAPPER = new ObjectMapper();
             String json = OBJECT_MAPPER.writeValueAsString(list);
             response.getWriter().write(json);
        }
        //cargar ingresos
        else if ("5".equals(opcion))
        {
            try
            {
                IngresosDao ingresos= new IngresosDaoImp();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
                Date fechaEgreso = sdf.parse(request.getParameter("fechaEgreso"));
                Date fechaIngreso = sdf.parse(request.getParameter("fechaIngreso"));                
                Integer totalMostrar =Integer.valueOf(request.getParameter("totalMostrar"));
                Integer  pagina =Integer.valueOf( request.getParameter("pagina"));
                List<Ingresos> list= ingresos.listIngresos(pagina, totalMostrar, new java.sql.Date(fechaIngreso.getTime()),new java.sql.Date(fechaEgreso.getTime()));
                 ObjectMapper OBJECT_MAPPER = new ObjectMapper();
                 String json = OBJECT_MAPPER.writeValueAsString(list);
                 response.getWriter().write(json);
                
            }
            catch(Exception ex)
            {
            }
        }
        //cargar totalIngresos
        else if("6".equals(opcion))
        {
            
            try
            {
            IngresosDao ingresos= new IngresosDaoImp();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
                Date fechaEgreso = sdf.parse(request.getParameter("fechaEgreso"));
                Date fechaIngreso = sdf.parse(request.getParameter("fechaIngreso"));
                out.println(ingresos.totalIngresos(new java.sql.Date(fechaIngreso.getTime()),new java.sql.Date(fechaEgreso.getTime())));
            }
            catch(Exception ex)
            {
                
            }
        }
        //guardar editar
        else if("7".equals(opcion))
        {
            try
            {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");                
                Integer idIngresos =Integer.valueOf(request.getParameter("idIngreso"));
                Date fechaIngreso = sdf.parse(request.getParameter("fechaIngreso"));
                Integer idTipoIngreso =Integer.valueOf(request.getParameter("idTipoIngreso"));
                Integer idEspecialidadEgreso =Integer.valueOf(request.getParameter("idEspecialidadEgreso"));
                Date fechaEgreso = sdf.parse(request.getParameter("fechaEgreso"));
                SimpleDateFormat format = new SimpleDateFormat("YYYY-MM-DD HH:MM");
                Date horaIngreso = format.parse(request.getParameter("horaIngreso"));
                Boolean sos = Boolean.valueOf(request.getParameter("sos"));
                Integer condicionEgreso = Integer.valueOf(request.getParameter("condicionEgreso"));
                String definitivoEgreso =request.getParameter("definitivoEgreso");
                String secundarioEgreso =request.getParameter("secundarioEgreso");
                String secundarioEgreso2 =request.getParameter("secundarioEgreso2");
                String causaExterna =request.getParameter("causaExterna");
                String codigoDiagnosticoDefinitivo =request.getParameter("codigoDiagnosticoDefinitivo");
                Integer idCaso =Integer.valueOf(request.getParameter("idCaso"));
                EspecialidadEgreso idEspecialidadEgres= new EspecialidadEgreso();
                idEspecialidadEgres.setId(idEspecialidadEgreso);
                TipoIngreso idTipoIngre=new TipoIngreso();
                idTipoIngre.setId(idTipoIngreso);   
               IngresosDao ingr= new IngresosDaoImp();
               Ingresos unIngreso = new Ingresos(fechaIngreso,fechaEgreso,horaIngreso,sos,condicionEgreso,definitivoEgreso,secundarioEgreso,secundarioEgreso2,causaExterna,codigoDiagnosticoDefinitivo,idEspecialidadEgres,idTipoIngre);
               unIngreso.setId(idIngresos);
               unIngreso.setIdCaso(new Caso(idCaso));
               
               ingr.Save(unIngreso, 0);
            }
            catch(Exception ex)
            {
            }
        }
        //eliminar
        else if("8".equals(opcion))
        {
            Integer idIngresos =Integer.valueOf(request.getParameter("idIngreso"));
            IngresosDao ingr= new IngresosDaoImp();
            ingr.Delete(idIngresos);
        }
        //registrar medicamento
        else if("9".equals(opcion))
        {
            try
            {
             SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");    
            String medicamento =request.getParameter("medicamentoTratamiento");
            Date fechaMedicamento = sdf.parse(request.getParameter("fechaMedicamento"));
            String hor= request.getParameter("hor");
            String lni= request.getParameter("lni");
            String fin= request.getParameter("fin");
            Integer idIngresos =Integer.valueOf(request.getParameter("idIngreso"));
            Integer idMedicamento =Integer.valueOf(request.getParameter("idMedicamento"));
            IngresosDao ingr= new IngresosDaoImp();
            Medicamento medicamentos = new Medicamento(idMedicamento,medicamento,new java.sql.Date(fechaMedicamento.getTime()),hor,lni,fin, new Ingresos(idIngresos));
            ingr.guardarMedicamento(medicamentos);
            
            
            
            }
            catch(Exception ex)
            {
            }
        }
        else if("10".equals(opcion))
        {
            try
            {
                Integer idIngresos =Integer.valueOf(request.getParameter("idIngreso"));
                IngresosDao ingr= new IngresosDaoImp();
                
                List<Medicamento> list= ingr.list(idIngresos); 
             ObjectMapper OBJECT_MAPPER = new ObjectMapper();
             String json = OBJECT_MAPPER.writeValueAsString(list);
             response.getWriter().write(json);
                
            }
            catch(Exception ex)
            {
            }
        }
        else if("11".equals(opcion))
        {
            Integer idMedicamento =Integer.valueOf(request.getParameter("idMedicamento"));
            IngresosDao ingr= new IngresosDaoImp();
            ingr.DeleteMedicamento(idMedicamento);
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
