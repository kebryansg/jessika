package mvc.servlet;

import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mvc.controlador.entidades.sm.Especialidad;
import mvc.modelo.smDao.EspecialidadDao;
import mvc.modelo.smDaoImp.EspecialidadDaoImp;
import org.codehaus.jackson.map.ObjectMapper;
import java.util.List;
import test.list_count;

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
        response.setContentType("text/html; charset=iso-8859-1");
        PrintWriter out = response.getWriter();
        String opcion = request.getParameter("opcion");
        // KS: Variable q uso
        list_count l;
        List<String> resultList = new ArrayList<>();
        // KS: Variable q uso
        JsonObject object = new JsonObject();
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
        if ("1".equals(opcion)) {
            Integer bandera = Integer.valueOf(request.getParameter("bandera"));
            String buscar = request.getParameter("buscar");
            EspecialidadDao espe = new EspecialidadDaoImp();
            out.println(espe.totalRegistros(bandera, buscar));

        } //cargo las especialidades ya se paginado o buscado
        else if ("2".equals(opcion)) {
            String buscar = request.getParameter("buscar");
            EspecialidadDao espe = new EspecialidadDaoImp();
            Integer totalMostrar = Integer.valueOf(request.getParameter("totalMostrar"));
            Integer pagina = Integer.valueOf(request.getParameter("pagina"));
            l = espe.list(pagina, totalMostrar, buscar);
            for (Object object1 : l.getList()) {
                Especialidad especialidad = (Especialidad) object1;
                resultList.add("{"
                        + "\"id\": \"" + especialidad.getId() + "\","
                        + "\"descripcion\": \"" + especialidad.getDescripcion() + "\","
                        + "\"accion\": \"<button class='btn btn-info'>Editar</button><button class='btn btn-danger'>Eliminar</button>\""
                        + "}");
            }

            out.print("{\"count\":\"" + Math.ceil((float) l.getTotal() / totalMostrar) + "\", \"list\":[" + String.join(",", resultList) + "] }");
            out.flush();
            out.close();

            /*ObjectMapper OBJECT_MAPPER = new ObjectMapper();
            String json = OBJECT_MAPPER.writeValueAsString(list);
            response.getWriter().write(json);*/
        } else if ("delete".equals(opcion)) {
            // Obtengo los datos de la peticion
            int idEspecialidad = Integer.parseInt(request.getParameter("id"));
            new EspecialidadDaoImp().delete(idEspecialidad);
            out.println("ok");
            out.flush();
            out.close();
        } else if ("list".equals(opcion)) {
            //Obtener especialidades para combo
            EspecialidadDao esp = new EspecialidadDaoImp();
            List<Especialidad> list = esp.list();
            String result = "";
            for (Especialidad especialidad : list) {
                result += "<option value='" + especialidad.getId() + "'>" + especialidad.getDescripcion() + "</option>";
            }
            out.print(result);
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
