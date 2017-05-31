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
            <button class="btn btn-info" id="pac_Buscar" data-toggle="modal" data-target="#ListPaciente" ><i class="glyphicon glyphicon-search"></i> Buscar Paciente</button>    
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
        <div class="form-group col-md-4 hidden">
            <label class="control-label" for="con_sexoPaciente">Sexo:</label>
            <input class="form-control solo-numero" readonly  id="con_sexoPaciente" placeholder="Nombre Paciente" type="text" >
        </div>
    </div>  
    <hr>
    <div class="row">
        <div class="col-md-2">
            <select class="form-control selectpicker" validate="select" data-live-search="true" >
                <option value="5">5</option>
                <option value="5">10</option>
                <option value="5">20</option>
            </select>
        </div>
            <!--<div class="form-group col-md-3">
                <label class="control-label" for="con_Fecha">Fecha Inicio</label>
                <div class="input-group date form_date" data-date="" data-date-format="yyyy-mm-dd">
                    <input class="form-control" validate="date" id="con_Fecha" size="16" type="text" value="" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>    
            </div>
            <div class="form-group col-md-3">
                <label class="control-label" for="con_Fecha">Fecha Final</label>
                <div class="input-group date form_date" data-date="" data-date-format="yyyy-mm-dd">
                    <input class="form-control" validate="date" id="con_Fecha" size="16" type="text" value="" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>    
            </div>-->
        <div class="col-md-4 col-md-offset-6"> 
            <div class="form-inline">
                <input class="form-control" style="width: 150px;" placeholder="Buscar" id="txt_filterHistorialC">
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
                        
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="row">

    </div>
</div>

<div class="modal fade" id="ListPaciente" role="dialog" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Elegir pacientes</h4>
            </div>
            <div class="modal-body">
                
            </div>
        </div>
    </div>
</div>
<!--<script src="resources/js/configuracionInicial.js" type="text/javascript"></script>-->
<script src="consulta/js/style_ListHistorialC.js" type="text/javascript"></script>
<script type="text/javascript">
    $("tbHC").bootstrapTable();
</script>