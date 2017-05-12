<%@page import="mvc.modelo.smDaoImp.EspecialidadDaoImp"%>
<%@page import="mvc.controlador.entidades.sm.Especialidad"%>
<%@page import="mvc.modelo.smDao.EspecialidadDao"%>
<%@page import="mvc.controlador.entidades.sm.Medico"%>
<%@page import="mvc.modelo.smDaoImp.MedicoDaoImp"%>
<%@page import="java.util.List"%>
<%@page import="mvc.modelo.smDao.MedicoDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script src="medico/js/editarMedico.js"></script>



<!--<script src="resources/js/style.js" type="text/javascript"></script>-->


<!--<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>-->

<div class="contenedor-tabs" >
    <div id="optionEditarMedico" data-id="1">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <div class="tab-content" id="tabMedicoEditar"  >
                        <br>
                        <div class="row">
                            <div class="pull-right">
                                <div class="col-md-12">
                                    <input class="form-control" id="txtBuscar" placeholder="Buscar">
                                </div>
                            </div>
                            
                            <div class="pull-left">
                                <div class="col-md-12">
                                    <div class="form-inline">
                                        <label for="txt_filterPaciente" class="control-label">Mostrar</label>
                                        <select class="selectpicker" data-width="80px" id="cboMostrar">
                                            <option value="5">5</option>
                                            <option value="10">10</option>
                                            <option value="20">20</option>
                                            <option value="30">30</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>    
                        <hr/>
                        <!--Tabla-->
                        <div >
                            <div class="row" >
                                <div class="col-xs-12">
                                    <div class="table-responsive" style="margin: 0 auto; text-align:left">
                                        <table id="tablaMedico" class="table table-bordered table-hover table-striped">
                                            <thead><tr></tr></thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>  
                        <!--Paginacion-->
                        <div style="text-align: right; width: 100%;" id="paginacionMedico">
                            <ul class="pagination" id="paginacionMedicoul" ></ul>
                        </div>
                    
                    <!--Formulario ventana modal-->
                    <form class="form-horizontal" id="myForm">
                        <div class="modal fade" id="modalEditarMedico" role="dialog">
                            <div class="modal-dialog modal-lg" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        <h4 class="modal-title">Editar Médico</h4>
                                    </div>
                                    <div class="modal-body" >
                                        <!--Fila 1- 3 botones Cédula -  Primer nombre - Segundo nombre-->
                                        <div class="row" style="padding-bottom: 12px">
                                            <div class="col-xs-3">
                                                <label for="exampleInputEmail1">Cédula</label>
                                                <input onblur="validarCedula()" validate="text" type="text" id="txtCedulaModal" class="form-control" >
                                            </div>
                                            
                                            <div class="col-xs-4">
                                                <label for="exampleInputEmail1">Primer Nombre</label>
                                                <input validate="text" id="txtPrimerNombreModal" type="text" class="form-control" >                        
                                            </div>
                                            <div class="col-xs-4">
                                                <label validate="text" for="exampleInputEmail1">Segundo Nombre</label>
                                                <input id="txtSegundoNombreModal" type="text" class="form-control">
                                            </div>
                                        </div>
                                        <!--Fila 2- 3 botones Apellidos-  Domicilio-->
                                        <div class="row" style="padding-bottom: 12px">
                                            <div class="col-xs-3">
                                                <label for="exampleInputEmail1">Primer Apellido</label>
                                                <input  validate="text" id="txtPrimerApellidoModal" type="text" class="form-control" >
                                            </div>
                                            <div class="col-xs-4">
                                                <label for="exampleInputEmail1">Segundo Apellido</label>
                                                <input validate="text" id="txtSegundoApellidoModal" type="text" class="form-control" >
                                            </div>
                                            <div class="col-xs-4">
                                                <label for="exampleInputEmail1">Domicilio</label>
                                                <input validate="text" id="txtDomicilioModal" type="text" class="form-control">
                                            </div>
                                        </div>
                                        <!--Fila 3- 3 botones Ciudad-  Tel Domicilio- Tel -->
                                        <div class="row" style="padding-bottom: 12px">
                                            <div class="col-xs-3">
                                                <label for="exampleInputEmail1">Ciudad</label>
                                                <input validate="text" id="txtCiudadModal" type="text" class="form-control" >
                                            </div>
                                            <div class="col-xs-4">
                                                <label for="exampleInputEmail1">Teléf. Domicilio</label>
                                                <input validate="text" id="txtTelefonoDomicilioModal" type="text" class="form-control" >
                                            </div>
                                            <div class="col-xs-4">
                                                <label for="exampleInputEmail1">Teléf. Oficina</label>
                                                <input validate="text" id="txtTelefonoOficinaModal" type="text" class="form-control">
                                            </div>                                            
                                        </div>
                                        <!-- Fila 4 - 3 botnoes Movil - Email - Estado -->
                                        <div class="row" style="padding-bottom: 12px"> 
                                            <div class="col-xs-3">
                                                <label for="exampleInputEmail1">Teléf. Movil</label>
                                                <input validate="text" id="txtTelefonoMovilModal" type="text" class="form-control" >
                                            </div>
                                            <div class="col-xs-4">
                                                <label for="exampleInputEmail1">E-mail</label>
                                                <input id="txtEmailModal" type="email" validate="email" class="form-control" >
                                            </div>
                                            <div class="col-xs-4">
                                                <label for="exampleInputEmail1">Estado</label>
                                                <select validate="select" id="cboEstadoModal" class="selectpicker" >
                                                    <option value="1">Activo</option>
                                                    <option value="2">Inactivo</option>                            
                                                </select>
                                            </div>
                                        </div>
                                        <!--Fila 5 1 Boton Especialidad-->
                                        <div class="row" style="padding-bottom: 12px">
                                            <div class="col-xs-3">
                                                <label for="exampleInputEmail1">Especialidad</label>
                                                <select validate="select" id="cboEspecialidades" data-live-search="true" class="selectpicker" multiple title="Seleccione">
                                                    <%
                                                        EspecialidadDao esp = new EspecialidadDaoImp();
                                                        List<Especialidad> list = esp.list();
                                                        for (Especialidad elem : list) {%>
                                                        <option value="<%= elem.getId()%>"><%=elem.getDescripcion()%></option>
                                                        <% }%>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <!--Pie del modal-->
                                    <div class="modal-footer">
                                        <button id="btnActualizar" type="button"  class="btn btn-primary">Guardar</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
                                                </div>
                                          