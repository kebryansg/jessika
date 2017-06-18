<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div id="toolbarReportesConsultas">
</div>
<table 
    data-toogle="table"
    data-toolbar="#toolbarReportesConsultas">
    <thead>
        <tr>
            <th>Fecha</th>
            <th>Paciente</th>
            <th>Motivo</th>
        </tr>
    </thead>
</table>
<script type="text/javascript">
    $("table").bootstrapTable();
</script>