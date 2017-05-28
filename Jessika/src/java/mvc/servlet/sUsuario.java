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
import javax.servlet.http.HttpSession;
import mvc.modelo.smDao.UsuarioDao;
import mvc.modelo.smDaoImp.UsuarioDaoImp;
import org.codehaus.jackson.map.ObjectMapper;

/**
 *
 * @author Deivi
 */
public class sUsuario extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet sUsuario</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet sUsuario at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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
        //processRequest(request, response);
       String result = "", op = request.getParameter("op");
       HttpSession sesion = request.getSession();
       if("close".equals(op))
       {
           sesion.invalidate();
           response.sendRedirect("login.jsp");
       
       }
        
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
       // processRequest(request, response);
       response.setContentType("text/plain");
       PrintWriter out = response.getWriter();
       String result = "", op = request.getParameter("op");
       HttpSession sesion = request.getSession();
       if("login".equals(op))
       {
            String user = request.getParameter("usuario");
            String clave = request.getParameter("clave");
            UsuarioDao usuario= new UsuarioDaoImp();
            String usuarioLogueado=usuario.Login(user, clave);
            ObjectMapper OBJECT_MAPPER = new ObjectMapper();
            if(sesion.getAttribute("usuario") == null)
            {
                if(!"".equals(usuarioLogueado))
                {
                    sesion.setAttribute("usuario", user);
                    sesion.setAttribute("nombresUsuario", usuarioLogueado);
                    sesion.setAttribute("nombreEstablecimiento", "Hospital del dia Revelo");
                    //response.sendRedirect("home.jsp");
                    String json = OBJECT_MAPPER.writeValueAsString(1);
                    response.getWriter().write(json);
                }
                else
                {
                    String json = OBJECT_MAPPER.writeValueAsString(0);
                    response.getWriter().write(json);
                    
                }
            }            
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
