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
                    <button class="btn btn-info" id="btnCancelarConsulta">Cancelar</button>
                    <button class="btn btn-info">Guardar</button>
                </div>

                <div class="pull-left">
                    <div class="form-inline">
                        <div class="form-group">
                            <label for="casoId" class="control-label" >Nº Caso: </label>
                            <input type="text" class="form-control" style="width: 80px;" readonly id="casoId" value="0">
                        </div>
                        <div class="form-group">
                            <label for="casoId" class="control-label">Paciente:</label>
                            <input type="text" class="form-control" style="width: 300px;" readonly id="PacienteId">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <hr>
        <div class="row">
            <div class="col-md-3">
                <br>
                <div class="form-group">
                    <label class="control-label" for="con_Fecha">Fecha</label>
                    <div class="input-group date form_date" data-date="" data-date-format="yyyy-mm-dd">
                        <input class="form-control" validate="date" id="con_Fecha" size="16" type="text" value="" readonly>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    </div>    
                </div>
                <div class="form-group">
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
            <div class="col-md-9">
                <div class="well" style="background-color: #fff;">
                    <div class="form-group col-md-2">
                        <label class="form-control-label">Peso:</label>
                        <input validate="text" type="text" class="form-control solo-numero" placeholder="kg" id="sv_Peso">
                    </div>
                    <div class="form-group col-md-2">
                        <label class="form-control-label">Talla:</label>
                        <input validate="text" type="text" class="form-control solo-numero" placeholder="cm" id="sv_Talla">
                    </div>
                    <div class="form-group col-md-2">
                        <label class="form-control-label">Temp.:</label>
                        <input validate="text" type="text" class="form-control solo-numero" placeholder="ºC" id="sv_Temperatura">
                    </div>
                    <div class="form-group col-md-3">
                        <label class="form-control-label">F. Cardìaca:</label>
                        <input validate="text" type="text" class="form-control solo-numero" placeholder="x Min." id="sv_Frecuencia">
                    </div>
                    <div class="form-group col-md-3">
                        <label class="form-control-label">Presiòn Arterial:</label>
                        <input validate="text" type="text" class="form-control solo-numero" placeholder="mmHg" id="sv_Presion">
                    </div>


                    <div class="form-group col-md-6">
                        <label class="form-control-label">FUM:</label>
                        <div class="input-group date form_date" data-date="" data-date-format="yyyy-mm-dd">
                            <input class="form-control" validate="date" id="sv_FUM" size="16" type="text" value="" readonly>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                        </div>  
                    </div>
                    <div class="form-group col-md-6">
                        <label class="form-control-label">FUC:</label>
                        <div class="input-group date form_date" data-date="" data-date-format="yyyy-mm-dd">
                            <input class="form-control" validate="date" id="sv_FUC" size="16" type="text" value="" readonly>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                        </div>  
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label">Motivo</label>
                    <textarea class="form-control" validate="text" rows="3" id="con_Motivo"></textarea>
                </div>
                <div class="form-group">
                    <label class="control-label">Sintomas</label>
                    <textarea class="form-control" validate="text" rows="3" id="con_Sintomas"></textarea>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label">Diagnostico</label>
                    <textarea class="form-control" validate="text" rows="3" id="con_Motivo"></textarea>
                </div>
                <div class="form-group">
                    <label class="control-label">Prescripciòn</label>
                    <textarea class="form-control" validate="text" rows="3" id="con_Sintomas"></textarea>
                </div>
            </div>
        </div>
        <hr>
        <div class="row">
                <div class="form-group has-error col-md-3" id="showLabs">
                    <button class="btn btn-danger" onclick="openModal('estLab')">Estudios Laboratorios</button>
                    <span class="help-block">Ningun estudio de laboratorio.</span>
                </div>
                <div class="form-group has-error col-md-3" id="showImgs">
                    <button class="btn btn-danger" onclick="">Estudios Imagenes</button>
                    <span class="help-block">Ningun estudio de imagenes.</span>
                </div>
        </div>
    </div>
</div>

<div class="modal fade" id="estLab" role="dialog">
    <div class="modal-dialog modal-lg" >
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
