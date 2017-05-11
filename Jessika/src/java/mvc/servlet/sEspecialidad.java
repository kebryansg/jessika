/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mvc.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mvc.controlador.entidades.sm.Especialidad;
import mvc.modelo.smDao.EspecialidadDao;
import mvc.modelo.smDaoImp.EspecialidadDaoImp;
import org.codehaus.jackson.map.ObjectMapper;
import java.util.List;

/**
 *
 * @author Byron
 */
public class sEspecialidad extends HttpServlet {

    
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
               /*if("0".equals(idEspecialidad))
               {
                   Integer ultimoId=esp.id();
                   out.println("<tr class='active'>");
                   out.println("<td>"+ultimoId+"</td>");	
                   out.println("<td id='"+ultimoId+"'>"+descripcionEspecialidad+"</td>");
                   out.println("<td style=''width: 20%'>");
                   out.println("<button id='botonEditar' class='btn btn-primary' ><span class='glyphicon glyphicon-pencil'></span> </button>");
                   out.println("<button id='btnEliminar' class='btn btn-danger'><span class='glyphicon glyphicon-trash'></span></a></button>");
                    out.println("</td>");
                   out.println("</tr>");
               }*/
               //cargo total de registros
               if("1".equals(opcion))
               {
                   Integer bandera =Integer.valueOf(request.getParameter("bandera"));
                    String buscar =request.getParameter("buscar");
                    EspecialidadDao espe= new EspecialidadDaoImp();                                        
                    out.println(espe.totalRegistros(bandera, buscar));
                   
               }
               //cargo las especialidades ya se paginado o buscado
               else if("2".equals(opcion))
               {
                   Integer bandera =Integer.valueOf(request.getParameter("bandera"));
                   String buscar =request.getParameter("buscar");
                   EspecialidadDao espe= new EspecialidadDaoImp();                                                           
                   Integer totalMostrar =Integer.valueOf(request.getParameter("totalMostrar"));
                   Integer  pagina =Integer.valueOf( request.getParameter("pagina"));
                   List <Especialidad> list= espe.list(pagina,totalMostrar,bandera,buscar); 
                   ObjectMapper OBJECT_MAPPER = new ObjectMapper();
                   String json = OBJECT_MAPPER.writeValueAsString(list);
                   response.getWriter().write(json);
               }
               else if("3".equals(opcion))
               {
                   // Obtengo los datos de la peticion
		String descripcionEspecialidad = request.getParameter("descripcionEspecialidad");
		String idEspecialidad = request.getParameter("idEspecialidad");
                String visible = request.getParameter("visible");
                
                EspecialidadDao esp = new EspecialidadDaoImp();
                Especialidad especialidad= new Especialidad(Integer.parseInt(idEspecialidad),descripcionEspecialidad,visible);
                esp.save(especialidad);
                 out.println(descripcionEspecialidad);
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
