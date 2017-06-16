package mvc.servlet;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mvc.controlador.entidades.ip.Paciente;
import mvc.controlador.entidades.sm.Caso;
import mvc.controlador.entidades.sm.Causa;
import mvc.controlador.entidades.sm.Consulta;
import mvc.controlador.entidades.sm.ConsultaEstudiosImagen;
import mvc.controlador.entidades.sm.ConsultaEstudiosLabs;
import mvc.controlador.entidades.sm.DetalleEstudiosLabs;
import mvc.controlador.entidades.sm.DetallesEstudiosImg;
import mvc.controlador.entidades.sm.HistorialClinico;
import mvc.controlador.entidades.sm.MedicoEspecialidad;
import mvc.controlador.entidades.sm.Metodos;
import mvc.controlador.entidades.sm.SignosVitales;
import mvc.controlador.entidades.sm.TipoConsulta;
import mvc.modelo.ipDaoImp.PacienteDaoImp;
import mvc.modelo.smDaoImp.CasoDaoImp;
import mvc.modelo.smDaoImp.CausaDaoImp;
import mvc.modelo.smDaoImp.ConsultaDaoImp;
import mvc.modelo.smDaoImp.ConsultaEstudiosImagenDaoImp;
import mvc.modelo.smDaoImp.ConsultaEstudiosLabsDaoImp;
import mvc.modelo.smDaoImp.EstudiosLaboratorioDaoImp;
import mvc.modelo.smDaoImp.HistorialClinicoDaoImp;
import mvc.modelo.smDaoImp.MetodosDaoImp;
import mvc.modelo.smDaoImp.SignosVitalesDaoImp;
import mvc.modelo.smDaoImp.TipoConsultaDaoImp;
import test.test;

public class sConsulta extends HttpServlet {

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
            out.println("<title>Servlet sConsulta</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet sConsulta at " + request.getContextPath() + "</h1>");
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
        final String FORMATO_FECHA = "yyyy-MM-dd";
        final DateFormat DF = new SimpleDateFormat(FORMATO_FECHA);
        Gson gson = new GsonBuilder().setDateFormat(FORMATO_FECHA).create();
        String result = "";
        String op = request.getParameter("op");
        List<String> resultList = new ArrayList();
        switch (op) {
            case "edit":
                Consulta value = new ConsultaDaoImp().edit(Integer.parseInt(request.getParameter("id")));
                Paciente p = new PacienteDaoImp().edit_HC(value.getIdCaso().getIdHistorialClinico().getId());
                String tipoConsulta = new TipoConsultaDaoImp().edit(value.getIdTipoConsulta()).getDescripcion();
                String metodo_causa = (tipoConsulta.equals("1")) ? new CausaDaoImp().edit(value.getIdMetodo()).getDescripcion() : new MetodosDaoImp().edit_detMetodos(value.getIdMetodo()).getDescripcion();

                SignosVitales s_v = new SignosVitalesDaoImp().editar(value.getId());

                out.print("{ \"esti\": " + gson.toJson(new ConsultaEstudiosImagenDaoImp().list(value.getId())) + " ,  \"estl\" : " + gson.toJson(new ConsultaEstudiosLabsDaoImp().list(value.getId())) + " , \"sv\": " + gson.toJson(s_v) + ",  \"consulta\": " + gson.toJson(value) + ", \"paciente\" : \"" + p.getNombres() + "\", \"sexoP\" : \"" + (p.getSexo() ? "H" : "M") + "\" ,\"tipoConsulta\" : \"" + tipoConsulta + "\",\"metodo_causa\" : \"" + metodo_causa + "\"  }");
                out.flush();
                out.close();
                break;
            case "detCaso":
                List<Consulta> list_detCaso = new CasoDaoImp().listDetConsulta(Integer.parseInt(request.getParameter("caso")));

                for (Consulta consulta : list_detCaso) {
                    resultList.add("{"
                            + "\"id\" : \"" + consulta.getId() + "\","
                            + "\"caso\" : \"" + consulta.getIdCaso().getId() + "\","
                            + "\"fecha\" : \"" + consulta.getFecha() + "\","
                            + "\"tipo\" : \"" + consulta.getSintoma() + "\","
                            + "\"motivo\" : \"" + consulta.getMotivo() + "\","
                            + "\"especialidad\" : \"" + consulta.getPrescripcion() + "\","
                            //+ "\"view\" : \"<button class='btn'> > </button>\""
                            + "}");

                }
                out.print("[" + String.join(",", resultList) + "]");
                out.flush();
                out.close();
                break;
            case "select":
                List<Causa> list_causa = new CausaDaoImp().list_filter(request.getParameter("q"));
                if (list_causa.isEmpty()) {
                    list_causa.add(new Causa(-1, request.getParameter("q").toUpperCase()));
                }
                result = gson.toJson(list_causa);
                out.print(result);
                out.flush();
                out.close();
                break;
            case "list":
                List<Consulta> list = new CasoDaoImp().listConsulta(Integer.parseInt(request.getParameter("idHc")), "", "", request.getParameter("filter"), 0, 5);
                for (Consulta con : list) {
                    resultList.add("{"
                            + "\"fecha\": \"" + test.SQLSave(con.getFecha()) + "\","
                            + "\"motivo\": \"" + con.getMotivo() + "\","
                            + "\"accion\": \"<button name='addHistorialCaso' data-id='" + con.getIdCaso().getId() + "' class='btn btn-info' data-toggle='tooltip' data-placement='top' title='Agregar al caso..!'> <i class='glyphicon glyphicon-plus'></i> </button> <button name='viewHistorialCaso' data-id='" + con.getIdCaso().getId() + "' data-toggle='modal' data-target='#viewHistorialCaso' class='btn btn-info' data-toggle='tooltip' data-placement='top' title='Historial caso..!' > <i class='glyphicon glyphicon-align-justify'></i> </button>\""
                            + "}");
                }
                out.print("[" + String.join(",", resultList) + "]");
                out.flush();
                out.close();
                break;
            case "paciente":
                String codPaciente = request.getParameter("cod");
                String opcion = (codPaciente.length() == 10) ? "cedula" : "hc";
                HistorialClinico hc = new HistorialClinicoDaoImp().edit_Paciente(opcion, codPaciente);
                if (hc.getId() != 0) {
                    Paciente pc = new PacienteDaoImp().edit(hc.getIdPaciente());
                    out.print("{\"paciente\":" + gson.toJson(pc) + ",\"hc_id\": " + hc.getId() + "}");
                } else {
                    out.print("null");
                }
                out.flush();
                out.close();
                break;
            case "save":

                // <editor-fold defaultstate="collapsed" desc="Save">
                // Signos Vitales
                SignosVitales sv = new SignosVitales(Integer.parseInt(request.getParameter("sv[id]")));
                sv.setPeso(request.getParameter("sv[peso]"));
                sv.setTalla(request.getParameter("sv[talla]"));
                sv.setTemperatura(request.getParameter("sv[temperatura]"));
                sv.setPresion(request.getParameter("sv[presion]"));
                sv.setFrecuenciaC(request.getParameter("sv[frecuenciaC]"));
                sv.setFum(test.fechaSQL(request.getParameter("sv[fum]")));
                sv.setFuc(test.fechaSQL(request.getParameter("sv[fuc]")));
                sv.setPeriodo(request.getParameter("sv[periodo]"));
                new SignosVitalesDaoImp().save(sv);
                // Signos Vitales

                Consulta consulta = new Consulta(0);
                consulta.setMotivo(request.getParameter("dc[motivo]").toUpperCase());
                consulta.setDiagnostico(request.getParameter("dc[diagnostico]").toUpperCase());
                consulta.setPrescripcion(request.getParameter("dc[prescripcion]").toUpperCase());
                consulta.setSintoma(request.getParameter("dc[sintomas]").toUpperCase());
                consulta.setFecha(test.fechaSQL(request.getParameter("fecha")));

                // Caso
                Caso cs = new Caso(Integer.parseInt(request.getParameter("idCaso")));
                if (cs.getId() == 0) {
                    cs.setIdHistorialClinico(new HistorialClinico(Integer.parseInt(request.getParameter("idHc"))));
                    new CasoDaoImp().save(cs);
                }
                // Caso

                consulta.setIdCaso(cs);
                consulta.setIdMedicoEspecialidad(new MedicoEspecialidad(Integer.parseInt(request.getParameter("idEspecialidad"))));
                consulta.setIdSignosvitales(sv);

                consulta.setIdTipoConsulta(Integer.parseInt(request.getParameter("dc[idTipoConsulta]")));
                if (consulta.getIdTipoConsulta() == 1) {
                    String idCausa = request.getParameter("dc[idMetodo][id]");
                    Causa causa = new Causa(idCausa.equals("-1") ? 0 : Integer.parseInt(idCausa), request.getParameter("dc[idMetodo][descripcion]"));
                    if (causa.getId() == 0) {
                        new CausaDaoImp().save(causa);
                    }
                    consulta.setIdMetodo(causa.getId());
                } else {
                    Metodos metodo = new Metodos(Integer.parseInt(request.getParameter("dc[idMetodo][id]")));
                    consulta.setIdMetodo(metodo.getId());
                }

                new ConsultaDaoImp().save(consulta);

                //Estudios Lab
                String[] estudLabs = request.getParameterValues("estudLab[]");
                if (estudLabs != null) {
                    for (String estudLab : estudLabs) {
                        ConsultaEstudiosLabs cEstLab = new ConsultaEstudiosLabs();
                        cEstLab.setIdConsulta(consulta);
                        cEstLab.setIdDetalleEstudiosLabs(new DetalleEstudiosLabs(Integer.parseInt(estudLab)));
                        new ConsultaEstudiosLabsDaoImp().save(cEstLab);
                    }
                }
                //Estudios Lab
                String estuImgs = request.getParameter("estuImg");
                if (estuImgs != null) {
                    estImg_ob[] estuImgs_a = gson.fromJson(estuImgs, estImg_ob[].class);
                    for (estImg_ob img_ob : estuImgs_a) {
                        ConsultaEstudiosImagen cEstImg = new ConsultaEstudiosImagen();
                        cEstImg.setIdConsulta(consulta);
                        cEstImg.setIdDetalleEstudiosImagen(new DetallesEstudiosImg(img_ob.getId()));
                        cEstImg.setDetExtremidad(img_ob.getDetExtre());
                        new ConsultaEstudiosImagenDaoImp().save(cEstImg);
                    }
                }
                out.print("hecho");
                out.flush();
                out.close();
// </editor-fold >

                break;
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

class estImg_ob {

    private int id;
    private String detExtre;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDetExtre() {
        return detExtre;
    }

    public void setDetExtre(String detExtre) {
        this.detExtre = detExtre;
    }

}
