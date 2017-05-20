<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--<i class="glyphicon glyphicon-plus"></i>-->
<div class="container-fluid">
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
            <label class="control-label" for="con_nombrePaciente">Nº Historia C.:</label>
            <input class="form-control solo-numero" readonly  id="con_historiaPaciente" placeholder="Nº Historia C." type="text" >
        </div>
        <div class="form-group col-md-2">
            <label class="control-label" for="con_nombrePaciente">Cedula:</label>
            <input class="form-control solo-numero" readonly  id="con_cedulaPaciente" placeholder="Cedula Paciente" type="text" >
        </div>
        <div class="form-group col-md-4">

            <label class="control-label" for="con_nombrePaciente">Paciente:</label>
            <input class="form-control solo-numero" readonly  id="con_nombrePaciente" placeholder="Nombre Paciente" type="text" >
        </div>
        <!--<div class="form-group col-md-2">
            <label class="control-label" for="con_ciudadPaciente">Ciudad:</label>
            <input class="form-control solo-numero" readonly  id="con_ciudadPaciente" placeholder="Ciudad Paciente" type="text" >
        </div>-->
    </div>  
    <hr>
    <div class="row">
        <div class="col-md-12">
            <div class="pull-left">

                <select class="form-control selectpicker" validate="select" data-live-search="true" >
                    <option value="5">5</option>
                    <option value="5">10</option>
                    <option value="5">20</option>
                </select>
            </div>
            <div class="pull-right">
                <button class="btn btn-info" id="btnNewConsulta"> Nueva Consulta </button>
            </div>
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-md-12">
            <div class="table-responsive">
                <table data-toggle="table" data-height="300" id="tbHC" >
                    <thead>
                    <th>Fecha</th>
                    <th>Motivo</th>
                    <th>Accion</th>
                    </thead>
                    <tbody>
                        <tr>
                            <td>2017-05-10</td>
                            <td>Molestias abdominales</td>
                            <td>
                                <button name="addHistorialCaso" class="btn btn-info" data-toggle="tooltip" data-placement="top" title="Agregar al caso..!"> <i class="glyphicon glyphicon-plus"></i> </button>
                                <button name="viewHistorialCaso" class="btn btn-info" data-toggle="tooltip" data-placement="top" title="Historial caso..!" > <i class="glyphicon glyphicon-align-justify"></i> </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="row">

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

<script src="resources/bootstrap/table/bootstrap-table.min.js" type="text/javascript"></script>
<script src="resources/js/configuracionInicial.js" type="text/javascript"></script>
<script src="consulta/js/style_ListHistorialC.js" type="text/javascript"></script>
