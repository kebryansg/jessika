/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mvc.servlet;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;
import mvc.controlador.entidades.ip.Enfermedad;
import mvc.controlador.entidades.ip.Obstetricos;
import mvc.controlador.entidades.ip.Paciente;
import mvc.controlador.entidades.ip.ParienteEnfermedadPaciente;
import mvc.controlador.entidades.ip.Parientes;
import mvc.controlador.entidades.ip.Parroquia;
import mvc.controlador.entidades.sm.HistorialClinico;
import mvc.modelo.ipDaoImp.ObstetricosDaoImp;
import mvc.modelo.ipDaoImp.PacienteDaoImp;
import mvc.modelo.ipDaoImp.ParienteEnfermedadPacienteDaoImp;
import mvc.modelo.ipDaoImp.ParroquiaDaoImp;
import mvc.modelo.smDaoImp.HistorialClinicoDaoImp;
import test.test;

/**
 *
 * @author kebryan
 */
public class sPaciente extends HttpServlet {

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
            out.println("<title>Servlet sPaciente</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet sPaciente at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        //processRequest(request, response);
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        String result = "", op = request.getParameter("op");
        List<Paciente> listP = null;
        //String cedula = request.getParameter("paciente[cedula]");
        Paciente paciente = new Paciente(0);
        //Gson gson = new Gson();
        //Gson gson = new GsonBuilder().registerTypeAdapter(java.util.Date.class, new BidirectionalDateSerializer()).create();
        final String FORMATO_FECHA = "yyyy-MM-dd";
        final DateFormat DF = new SimpleDateFormat(FORMATO_FECHA);
        Gson gson = new GsonBuilder().setDateFormat(FORMATO_FECHA).create();
        switch (op) {
            case "delete":
                new HistorialClinicoDaoImp().delete(Integer.parseInt(request.getParameter("id")));
                break;
            case "list":

                listP = new PacienteDaoImp().list_Filter(request.getParameter("filter"), 0, -1);
                out.print(listP.size());
                out.flush();
                out.close();
                break;
            case "list_filter":
                String filter = request.getParameter("filter");
                int topSQL = Integer.parseInt(request.getParameter("top"));
                int inicioSQL = Integer.parseInt(request.getParameter("pag"));

                listP = new PacienteDaoImp().list_Filter(filter, inicioSQL, topSQL);

                String listString = "";
                for (Paciente paciente1 : listP) {
                    listString += "<tr data-id='" + paciente1.getId() + "' >";
                    listString += "<td>" + paciente1.getHistoriaClinica() + "</td>";
                    listString += "<td>" + paciente1.getCedula() + "</td>";
                    listString += "<td>" + (paciente1.getApellido1() + " " + paciente1.getApellido2() + " " + paciente1.getNombre1() + " " + paciente1.getNombre2()).toUpperCase() + "</td>";
                    listString += "<td>" + paciente1.getCiudad() + "</td>";
                    listString += "<td>" + paciente1.getDomicilio() + "</td>";
                    listString += "<td>";
                    listString += "<button name='editPaciente' data-id='" + paciente1.getId() + "'  style='margin-right: 2px;' class='btn btn-primary'><span class='glyphicon glyphicon-pencil'></span> </button>";
                    listString += "<button name='deletPaciente' data-id='" + paciente1.getId() + "' class='btn btn-danger'><span class='glyphicon glyphicon-trash'></span> </button>";
                    listString += "</td>";
                    listString += "</tr>";
                }
                result = "{\"list\": \"" + listString + "\"}";
                out.print(result);
                out.flush();
                out.close();
                break;
            case "det":
                String detParroquia = new ParroquiaDaoImp().detParroquia(Integer.parseInt(request.getParameter("idParroquia")));
                out.print(detParroquia);
                out.close();
                break;
            case "edit":
                paciente = new PacienteDaoImp().edit(Integer.parseInt(request.getParameter("id")));
                Obstetricos obs = new ObstetricosDaoImp().edit_idPaciente(paciente.getId());
                List<ParienteEnfermedadPaciente> list = new ParienteEnfermedadPacienteDaoImp().list_Paciente(paciente.getId());
                out = response.getWriter();
                result = "{\"paciente\": " + gson.toJson(paciente) + ",\"obs\": " + gson.toJson(obs) + ",\"list\": " + gson.toJson(list) + "}";
                out.print(result);
                out.flush();
                out.close();
                break;
            case "save":
                //Paciente paciente = new Paciente(0); //Llama arriba
                paciente.setId(Integer.parseInt(request.getParameter("id")));
                int idPaciente = (paciente.getId() == 0) ? (test.getID("paciente") + 1) : paciente.getId();

                paciente.setCedula(request.getParameter("paciente[cedula]"));
                paciente.setNombre1(request.getParameter("paciente[primerNombre]"));
                paciente.setNombre2(request.getParameter("paciente[segundoNombre]"));
                paciente.setApellido1(request.getParameter("paciente[primerApellido]"));
                paciente.setApellido2(request.getParameter("paciente[segundoApellido]"));
                paciente.setFechaNacimiento(test.fechaSQL(request.getParameter("paciente[fechaNac]")));
                paciente.setNacionalidad(request.getParameter("paciente[nacionalidad]"));
                paciente.setTelefonoDomicilio(request.getParameter("paciente[telCasa]"));
                paciente.setEmail(request.getParameter("paciente[email]"));
                paciente.setEtnia(Integer.parseInt(request.getParameter("paciente[etnia]")));
                paciente.setDomicilio(request.getParameter("paciente[domicilio]"));
                paciente.setDiscapacidad(request.getParameter("paciente[discapacidad]").equals("true") ? 1 : 0);
                paciente.setCiudad(request.getParameter("paciente[ciudad]"));
                paciente.setEstadoCivil(request.getParameter("paciente[estadoCivil]"));
                
                paciente.setNombreContacto(request.getParameter("paciente[nombreContacto]"));
                paciente.setMovilContacto(request.getParameter("paciente[movilContacto]"));
                paciente.setParentezco(request.getParameter("paciente[parentezco]"));
                
                paciente.setTelefonoOficina(request.getParameter("paciente[telOficina]"));
                Boolean sexo = request.getParameter("paciente[genero]").equals("1") ? true : false;
                paciente.setSexo(sexo);
                paciente.setPaisNacimiento(request.getParameter("paciente[paisNac]"));
                paciente.setLugarNacimiento(request.getParameter("paciente[lugarNac]"));
                paciente.setIdParroquia(new Parroquia(Integer.parseInt(request.getParameter("paciente[parroquia]"))));

                if (request.getParameter("paciente[editImg]").equals("1")) {
                    saveFoto(request.getParameter("paciente[imagen]"), idPaciente);
                    paciente.setImagen("imagen/paciente/p_" + idPaciente + ".jpg");
                } else {
                    paciente.setImagen(request.getParameter("paciente[imagen]"));
                }
                if (paciente.getId() == 0) {
                    new HistorialClinicoDaoImp().save(new HistorialClinico("", idPaciente));
                }
                new PacienteDaoImp().save(paciente);
                paciente.setId(idPaciente);

                if (!sexo) {
                    Obstetricos obstetricos = new Obstetricos(Integer.parseInt(request.getParameter("paciente[idObs]")));
                    obstetricos.setGestas(Integer.parseInt(request.getParameter("paciente[gestacion]")));
                    obstetricos.setAbortos(Integer.parseInt(request.getParameter("paciente[abortos]")));
                    obstetricos.setCesareas(Integer.parseInt(request.getParameter("paciente[cesareas]")));
                    obstetricos.setFpp(test.fechaSQL(request.getParameter("paciente[fpp]")));
                    obstetricos.setHijosVivos(Integer.parseInt(request.getParameter("paciente[hijosVivos]")));
                    obstetricos.setIdPaciente(paciente);//Agregar Id
                    obstetricos.setMuertos(Integer.parseInt(request.getParameter("paciente[hijosMuertos]")));
                    obstetricos.setNacidosMuertos(Integer.parseInt(request.getParameter("paciente[nacidoMuerto]")));
                    obstetricos.setNacidosVivos(Integer.parseInt(request.getParameter("paciente[nacidoVivo]")));
                    obstetricos.setObservaciones("");
                    obstetricos.setPartos(Integer.parseInt(request.getParameter("paciente[partos]")));
                    new ObstetricosDaoImp().save(obstetricos);
                }
                //String arrayLis = request.getParameter("newAntecedentes");
                String[] parientes_enfermedad = request.getParameterValues("newAntecedentes[]");
                if (parientes_enfermedad != null) {
                    for (String pariente_enfermedad : parientes_enfermedad) {
                        ParienteEnfermedadPaciente par_enfer = new ParienteEnfermedadPaciente(0);
                        par_enfer.setIdPaciente(paciente);
                        par_enfer.setIdEnfermedad(new Enfermedad(Integer.parseInt(pariente_enfermedad.split(":")[0])));
                        par_enfer.setIdPariente(new Parientes(Integer.parseInt(pariente_enfermedad.split(":")[1])));
                        new ParienteEnfermedadPacienteDaoImp().save(par_enfer);
                    }
                }

                if (Integer.parseInt(request.getParameter("id")) != 0) {
                    String[] parientes_enfermedad_edit = request.getParameterValues("editAntecedentes[]");
                    if (parientes_enfermedad_edit != null) {
                        for (String value : parientes_enfermedad_edit) {
                            new ParienteEnfermedadPacienteDaoImp().delete(Integer.parseInt(value));
                        }
                    }

                }
                break;
        }
    }

    public void saveFoto(String data, int idPaciente) throws FileNotFoundException, IOException {
        String path = getServletContext().getRealPath("/");
        path = path.replace("web", "imagen");
        path = path.replace("build", "web");
        path = path + "paciente\\p_" + idPaciente + ".jpg";
        byte[] imageByteArray = DatatypeConverter.parseBase64Binary(data.substring(data.indexOf(",") + 1));
        try (FileOutputStream fileout = new FileOutputStream(path)) {
            fileout.write(imageByteArray);
            fileout.close();
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
