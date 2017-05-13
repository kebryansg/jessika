<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="contenedor-tabs">
    <div class="container-fluid">
        <div class="row">
            <div class="pull-right">
                <div class="col-md-12">
                    <input class="form-control" id="txt_filterPaciente" placeholder="Buscar">
                </div>
            </div>
            <div class="pull-left">
                <div class="col-md-12">
                    <div class="form-inline">
                        <label for="txt_filterPaciente" class="control-label">Mostrar</label>
                        <select class="selectpicker" data-width="80px" id="cantList">
                            <option value="5">5</option>
                            <option value="10">10</option>
                            <option value="20">20</option>
                            <option value="30">30</option>
                        </select>
                    </div>
                </div>

            </div>
        </div>    
        <br>
        <div class="row">
            <div class="col-md-12">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover table-striped">
                        <thead style="font-weight: bold;">
                            <tr>
                                <td style="width: 12%;">Historia Clinica</td>
                                <td>Cèdula</td>
                                <td>Apellidos y Nombres</td>
                                <td>Ciudad</td>
                                <td>Domicilio</td>
                                <td style="width: 15%;">Acciòn</td>
                            </tr>
                        </thead>
                        <tbody id="tablePaciente"></tbody>
                    </table>
                </div>

            </div>       
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="pull-right">
                    <ul id="pagPacientes" class="pagination"></ul>    
                </div>

            </div>
        </div>
    </div>

</div>
<div class="modal fade" id="editPaciente" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Editar paciente</h4>
            </div>
            <div class="modal-body">

            </div>
            <!--<div class="modal-footer">

                <button id="btnActualizar" type="button"  class="btn btn-primary">Guardar</button>
            </div>-->
        </div>
    </div>
</div>
<script src="resources/js/configuracionInicial.js" type="text/javascript" ></script> 
<script src="paciente/js/styleListPaciente.js" type="text/javascript"></script>-

<script type="text/javascript">
    $(function () {
        /*$.getScript("paciente/js/paciente.js", function () {
         indexPag(1,5,"");
         });*/
    });
</script>
