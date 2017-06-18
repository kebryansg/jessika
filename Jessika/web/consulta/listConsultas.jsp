<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div id="toolbarReportesConsultas">
    <select class="selectpicker" data-width="80px" id="cantList">
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        
        
        <option value="5">5</option>
        <option value="10">10</option>
        <option value="20">20</option>
        <option value="30">30</option>
    </select>
</div>
<table id="tbConsultas"
       data-toogle="table"
       data-toolbar="#toolbarReportesConsultas">
    <thead>
        <tr>
            <th data-field="id" >ID</th>
            <th data-field="fecha" >Fecha</th>
            <th data-field="paciente" >Paciente</th>
            <th data-field="tipoConsulta" >Tipo Consulta</th>
            <th data-field="especialidad" >Especialidad</th>
            <th data-field="causa_motivo" >Causa - Motivo</th>
        </tr>
    </thead>
</table>
<div class="pull-right">
    <ul id="pag_tbConsultas" class="pagination">
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

<script src="consulta/js/style_listConsultas.js" type="text/javascript"></script>
