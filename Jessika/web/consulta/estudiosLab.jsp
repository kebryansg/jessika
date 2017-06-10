<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="container-fluid">
    <div class="row">
        <div class="pull-right ">
            <div class="col-md-12">

                <div class="form-inline">
                    <input class="form-control" id="txt_filterEstudiosLab" placeholder="Buscar">
                    <select class="selectpicker" data-width="150px" id="cboCategoria">

                    </select>
                </div>
            </div>
        </div>
        <div class="pull-left">
            <div class="col-md-12">
                <div class="form-inline">
                    <label for="txt_filterPaciente" class="control-label">Mostrar</label>
                    <select class="selectpicker" data-width="80px" id="cantListEstudiosLab">
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
    <div id="toolbarEstudiosLab">
        <button id="btnSelecc" class="btn btn-default">Agregar</button>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="table-responsive">
                <table data-toggle="table" 
                       data-toolbar="#toolbarEstudiosLab" 
                       data-click-to-select="true"
                       data-height="300" id="tableEstudiosLab">
                    <thead style="font-weight: bold;">
                        <tr>
                            <th data-field="state" data-checkbox="true"></th>
                            <th data-field="ID" data-align="center">Codigo</th>
                            <th data-field="categoria">Categoria</th>
                            <th data-field="estudio">Estudio de laboratorio</th>
                        </tr>
                    </thead>
                </table>
            </div>

        </div>       
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="pull-right">
                <ul id="pagEstudiosLab" class="pagination">
                    <li>
                        <a href="#" aria-label="Anterior">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" aria-label="Siguiente">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </div>

        </div>
    </div>
    <div class="toolbarEstudiosLabSelec">
        <button id="btnRemover" class="btn btn-default">Remover</button>    
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="table-responsive">
                <table id="tableEstudiosLabSelec" 
                       data-toolbar="#toolbarEstudiosLabSelec"  
                       data-click-to-select="true"
                       data-toggle="table" data-height="250">
                    <thead style="font-weight: bold;">
                        <tr>
                            <th data-field="state" data-checkbox="true"></th>
                            <th data-field="id" data-align="center">Codigo</th>
                            <th data-field="estudio">Estudio de laboratorio</th>
                        </tr>
                    </thead>
                    <tbody ></tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="consulta/js/estudioLab.js" type="text/javascript"></script>
