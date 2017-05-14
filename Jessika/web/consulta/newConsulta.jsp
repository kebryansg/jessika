<%@page import="java.util.List"%>
<%@page import="mvc.modelo.smDaoImp.MedicoEspecialidadDaoImp"%>
<%@page import="mvc.controlador.entidades.sm.MedicoEspecialidad"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="contenedor-tabs">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="pull-right">
                    <button class="btn btn-info">Guardar</button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="form-group col-md-2">
                <input class="form-control solo-numero" maxlength="10" validate="date" id="txt_cargarPaciente" placeholder="Buscar (cedula)" type="text" >
            </div>
            <div class="form-group col-md-4">
                <button class="btn btn-info" id="pac_Cargar" >Cargar</button>    
                <button class="btn btn-info" id="pac_Buscar" ><i class="glyphicon glyphicon-search"></i> Buscar Paciente</button>    
            </div>
        </div>    
        <div class="row">
            <div class="form-group col-md-2">
                <label class="control-label" for="con_nombrePaciente">Nº Historia Clinica:</label>
                <input class="form-control solo-numero" readonly  id="con_historiaPaciente" placeholder="Nº Historia Clinica" type="text" >
            </div>
            <div class="form-group col-md-2">
                <label class="control-label" for="con_nombrePaciente">Cedula:</label>
                <input class="form-control solo-numero" readonly  id="con_cedulaPaciente" placeholder="Cedula Paciente" type="text" >
            </div>
            <div class="form-group col-md-4">

                <label class="control-label" for="con_nombrePaciente">Paciente:</label>
                <input class="form-control solo-numero" readonly  id="con_nombrePaciente" placeholder="Nombre Paciente" type="text" >
            </div>
            <div class="form-group col-md-3">
                <label class="control-label" for="con_ciudadPaciente">Ciudad:</label>
                <input class="form-control solo-numero" readonly  id="con_ciudadPaciente" placeholder="Ciudad Paciente" type="text" >
            </div>
        </div>  
        <hr>
        <div class="row">
            <div class="col-md-6">
                <div class="row">
                    <div class="form-group col-md-6">
                        <label class="control-label" for="con_Fecha">Fecha</label>
                        <div class="input-group date form_date" data-date="" data-date-format="yyyy-mm-dd">
                            <input class="form-control" validate="date" id="con_Fecha" size="16" type="text" value="" readonly>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                        </div>    
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label" for="cboEspecialidadMedico">Especilidad</label>
                        <select class="form-control selectpicker" validate="select" data-live-search="true" id="cboEspecialidadMedico">
                            <option value="0">Seleccione</option>
                            <%
                                List<MedicoEspecialidad> list = new MedicoEspecialidadDaoImp().list(1068);
                                for (MedicoEspecialidad m_e : list) {
                            %>
                            <option value="0"><%= m_e.getIdEspecialidad().getDescripcion()%></option>
                            <%
                                }
                            %>  
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label">Motivo</label>
                    <textarea class="form-control" validate="text" rows="3" id="con_Motivo"></textarea>
                </div>
                <div class="form-group">
                    <label class="control-label">Sintomas</label>
                    <textarea class="form-control" validate="text" rows="5" id="con_Sintomas"></textarea>
                </div>
            </div>
            <div class="col-md-6">
                <div class="col-md-4">
                    <button class="btn btn-danger btn-block" onclick="openModal_Clean('SignosVitales')">Signos Vitales</button>
                    <button class="btn btn-danger btn-block" onclick="openModal('estLab')">Signos Vitales</button>
                </div>


            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="SignosVitales" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Signos Vitales</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="form-group col-md-4">
                        <label class="form-control-label">Peso:</label>
                        <input validate="text" type="text" class="form-control solo-numero" placeholder="kg" id="sv_Peso">
                    </div>
                    <div class="form-group col-md-4">
                        <label class="form-control-label">Talla:</label>
                        <input validate="text" type="text" class="form-control solo-numero" placeholder="cm" id="sv_Talla">
                    </div>
                    <div class="form-group col-md-4">
                        <label class="form-control-label">Frecuencia Cardìaca:</label>
                        <input validate="text" type="text" class="form-control solo-numero" placeholder="x Minuto" id="sv_Frecuencia">
                    </div>
                    <div class="form-group col-md-4">
                        <label class="form-control-label">Presiòn Arterial:</label>
                        <input validate="text" type="text" class="form-control solo-numero" placeholder="mmHg" id="sv_Presion">
                    </div>
                    <div class="form-group col-md-4">
                        <label class="form-control-label">Temperatura:</label>
                        <input validate="text" type="text" class="form-control solo-numero" placeholder="ºC" id="sv_Temperatura">
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="form-group col-md-4">
                        <label class="form-control-label">FUM:</label>
                        <div class="input-group date form_date" data-date="" data-date-format="yyyy-mm-dd">
                            <input class="form-control" validate="date" id="sv_FUM" size="16" type="text" value="" readonly>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                        </div>  
                    </div>
                    <div class="form-group col-md-4">
                        <label class="form-control-label">FUC:</label>
                        <div class="input-group date form_date" data-date="" data-date-format="yyyy-mm-dd">
                            <input class="form-control" validate="date" id="sv_FUC" size="16" type="text" value="" readonly>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                        </div>  
                    </div>
                </div>

            </div>
            <div class="modal-footer">

                <button id="btnActualizar" type="button"  class="btn btn-primary">Guardar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="ListPaciente" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Elegir pacientes</h4>
            </div>
            <div class="modal-body">

            </div>
            <!--<div class="modal-footer">

                <button id="btnActualizar" type="button"  class="btn btn-primary">Guardar</button>
            </div>-->
        </div>
    </div>
</div>

<div class="modal fade" id="estLab" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Estudios de Laboratorio</h4>
            </div>
            <div class="modal-body">

            </div>
            <!--<div class="modal-footer">

                <button id="btnActualizar" type="button"  class="btn btn-primary">Guardar</button>
            </div>-->
        </div>
    </div>
</div>                        


<script src="consulta/js/styleConsulta.js" type="text/javascript"></script>

<script type="text/javascript">
                        $("#estLab .modal-body").load("consulta/estudiosLab.jsp");

                        //openModal("estLab");
</script>
<!--<script src="resources/js/configuracionInicial.js" type="text/javascript" ></script>-->