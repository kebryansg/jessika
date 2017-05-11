/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
ocultarModal();

/*-------------------------------Variables-------------------------------------------------------------------------*/
var pagina=1;
var diagnosticos=[];    
var datos=[];
var medicinas=[];
var indice=0;
var idMedicamento=0;
var idIngreso=0;
var ultimo=0;
var filas=5;
var indiceMedicamentos=0;
 var bandera=0;
/*-------------------------------Ingresos-------------------------------------------------------------------------*/
//Buscar Ingresos
$('#tabMantenimientoIngresos #btnBuscar').click(function(event) {                        
         cargarIngresos();
     });    
//Ingresos cargar
function cargarIngresos()
    {
        $.ajax({
            type: 'Post',
            url: 'sIngresosHospital',
            data: {            
                opcion: '5',
                fechaEgreso: $("#dtpFechaEgresoIngresos").val(),
                fechaIngreso:$("#dtpFechaIngresoIngresos").val(),
                totalMostrar:5,
                pagina:pagina
            },
            async: false,
            success:function(data){  
                console.log(data);
                var resultado = JSON && JSON.parse(data) || $.parseJSON(data);                                    
                console.log(resultado[0].registros);
                $('#paginacionIngresosEditar').find('li').remove();
                var totalPaginas=resultado[0].registros/5;
                totalPaginas=Math.ceil(totalPaginas);
                $("#paginacionIngresosEditar ul").append('<li id="atras"><a href="#">&laquo;</a></li>');
                filas=resultado.length;
                var indice=0;
                for(i=0;i <totalPaginas; i++)                
                {
                    indice=parseInt(i)+1;
                    if(indice==pagina)
                        $("#paginacionIngresosEditar ul").append('<li id='+indice+' class="active"><a href="#">'+indice+'</a></li>');
                    else 
                        $("#paginacionIngresosEditar ul ").append('<li id='+indice+'><a href="#">'+indice+'</a></li>');
                }
                ultimo=indice;
                $("#paginacionIngresosEditar ul").append('<li id="adelante"> <a href="#">&raquo;</a></li>');
                $('#tablaIngresos tr').remove();
                $('#tablaIngresos thead').append("<tr>\n\                                                        <th>No.</th>\n\
                                                        <th class='col-lg-1'>Cédula</th>\n\
                                                        <th>Nombres</th>\n\
                                                        <th>Apellidos</th>\n\
                                                        <th style='display:none;' class='col-lg-2'>idTipoIngregos</th>\n\
                                                        <th style='display:none;'>idCaso</th>\n\
                                                        \n\<th style='display:none;'>Id. Espegreso</th>\n\
                                                        <th style='display:none;'>E. Egreso</th>\n\
                                                        <th>F. Ingreso</th>\n\
                                                        <th>F. Egreso</th>\n\
                                                        <th style='display:none;'>Hora</th>\n\
                                                        <th class='col-lg-1' style='display:none;'>Cond. Egreso</th>\n\
                                                        <th class='col-lg-2'>D. Egreso</th>\n\
                                                        <th style='display:none;' class='col-lg-1'>S. Egreso</th>\n\
                                                        <th style='display:none;' class='col-lg-1'>S. Egreso 2</th>\n\
                                                        <th style='display:none;' class='col-lg-1'>C. Externa</th>\n\
                                                        <th class='col-lg-1'>Cód.</th>\n\
                                                        <th >Acción.</th></tr>");
                var valor="btn-group";
                    for(i=0;i <resultado.length; i++)
                    {
                        diagnosticos[i]=resultado[i].definitivoEgreso;
                        if(diagnosticos[i].length>=17)
                            var res = diagnosticos[i].substring(0, 17)+'...';
                        else
                            res = diagnosticos[i];
                        if(i==4)
                            valor="btn-group dropup";
                        $('#tablaIngresos').append("<tr >\n\
                                                        <td>"+resultado[i].id+"</td>\n\
                                                        <td>"+resultado[i].unPaciente.cedula+"</td>\n\
                                                        <td>"+resultado[i].unPaciente.nombre1+ ' '+resultado[i].unPaciente.nombre2+"</td>\n\
                                                        <td>"+resultado[i].unPaciente.apellido1+" "+resultado[i].unPaciente.apellido2+"</td>\n\
                                                        <td style='display:none;'>"+resultado[i].idTipoIngreso.id+"</td>\n\
                                                        <td style='display:none;'>"+resultado[i].idCaso.id+"</td>\n\
                                                        <td style='display:none;'>"+resultado[i].idEspecialidadEgreso.id+"</td>\n\
                                                        <td style='display:none;'>"+resultado[i].idEspecialidadEgreso.descripcion+"</td>\n\
                                                        <td>"+resultado[i].fechaEntrada+"</td>\n\
                                                        <td>"+resultado[i].fechaSalida+"</td>\n\
                                                        <td style='display:none;'>"+resultado[i].hora+"</td>\n\
                                                        <td style='display:none;'>"+resultado[i].condicionEgreso+"</td>\n\
                                                        <td>"+res+"</td>\n\
                                                        <td style='display:none;'>"+resultado[i].secundarioEgreso+"</td>\n\
                                                        <td style='display:none;'>"+resultado[i].secundarioEgreso2+"</td>\n\
                                                        <td style='display:none;'>"+resultado[i].causaExterna+"</td>\n\
                                                        <td>"+resultado[i].codigoDiagnosticoDefinitivo+"</td>\n\
                                                        <td style='width: 20%' >\n\
                                                            <button id='botonEditar' class='btn btn-primary'><span class='glyphicon glyphicon-pencil'></span> </button> \n\
                                                            \n\
                                                            <button id='btnEliminar' class='btn btn-danger'><span class='glyphicon glyphicon-trash'></span></a></button>\n\
\n\
                                                            <div class='"+valor+"'>\n\
                                                            \n\<button id='btnMedicinas' type='button' class='btn btn-warning dropdown-toggle' data-toggle='dropdown'>Medicinas <span class='caret'></span></button>\
                                                               <ul class='dropdown-menu' role='menu'>\n\
                                                                    <li id='opAgregarMedicina'><a href='#'>Agregar</a></li>\n\
                                                                    <li id='opMantenimientoMedicina'><a href='#'>Editar</a></li>     \n\
                                                                    \n\
                                                               </ul>\n\
                                                            </div>\n\
</td>\n\
                                                    </tr>");
                }
            }
        });
    
     } 
//Editar Ingreso     
 $("#tabMantenimientoIngresos .table-responsive").on("click", "#botonEditar", function(){  
          var cont=0;    
          $(this).parents("tr").find("td").each(function(){
              datos[cont]=$(this).html();   
              cont++;
          });
          console.log(datos);
          $('#txtPaciente').val(datos[2]+' '+datos[3]);
          $('select[id=cboCondicionEgreso]').val(datos[11]);
          $('select[id=cboEspecialidadEgreso]').val(datos[6]);
          $('.selectpicker').selectpicker('refresh');
          $('#dtpFechaIngresoIngresosModal').val(datos[8]);
          $('#dtpFechaEgresoIngresosModal').val(datos[9]);             
          $('#dtpHoraIngreso').val(datos[10]);
          $('#txtCodigoCie').val(datos[16]);
          $('#txtDefinitivoEgreso').val(datos[12]);
          $('#txtSecundarioEgreso').val(datos[13]);   
          $('#txtSecundarioEgreso2').val(datos[14]);   
          $('#txtCausaExterna').val(datos[15]);   
          var id='modalEditarIngresos';
          $("#"+id).modal('show');
      });
//Actualizar Ingresos
 $('#tabMantenimientoIngresos #btnActualizar').click(function(event) {
        $.post('sIngresosHospital', {
            idIngreso : datos[0],
            fechaIngreso: $('#dtpFechaIngresoIngresosModal').val(),
            idTipoIngreso: 2,
            idEspecialidadEgreso: $('#cboEspecialidadEgreso').val(),
            fechaEgreso: $('#dtpFechaEgresoIngresosModal').val(),
            horaIngreso: $("#dtpHoraIngreso").val(),
            sos: 0,
            condicionEgreso: $("#cboCondicionEgreso").val(),
            definitivoEgreso: $("#txtDefinitivoEgreso").val(),
            secundarioEgreso: $("#txtSecundarioEgreso").val(),
            secundarioEgreso2: $("#txtSecundarioEgreso2").val(),
            causaExterna: $("#txtCausaExterna").val(),
            idCaso:datos[5],
            codigoDiagnosticoDefinitivo:$("#txtCodigoCie").val(),
            opcion:'7'                                
        }, function(responseText) {   
            console.log(responseText); 
            $($('.table-responsive').find('tbody > tr')[indice]).children('td')[5].innerHTML = datos[5];
            $($('.table-responsive').find('tbody > tr')[indice]).children('td')[6].innerHTML = $('#cboEspecialidadEgreso').val();            
            $($('.table-responsive').find('tbody > tr')[indice]).children('td')[8].innerHTML = $('#dtpFechaIngresoIngresosModal').val();
            $($('.table-responsive').find('tbody > tr')[indice]).children('td')[9].innerHTML = $('#dtpFechaEgresoIngresosModal').val();
            $($('.table-responsive').find('tbody > tr')[indice]).children('td')[10].innerHTML = $("#dtpHoraIngreso").val();
            $($('.table-responsive').find('tbody > tr')[indice]).children('td')[11].innerHTML = $("#cboCondicionEgreso").val();
            $($('.table-responsive').find('tbody > tr')[indice]).children('td')[12].innerHTML = $("#txtDefinitivoEgreso").val();
            $($('.table-responsive').find('tbody > tr')[indice]).children('td')[13].innerHTML = $("#txtSecundarioEgreso").val();
            $($('.table-responsive').find('tbody > tr')[indice]).children('td')[14].innerHTML = $("#txtSecundarioEgreso2").val();
            $($('.table-responsive').find('tbody > tr')[indice]).children('td')[15].innerHTML = $("#txtCausaExterna").val();
            $($('.table-responsive').find('tbody > tr')[indice]).children('td')[16].innerHTML = $("#txtCodigoCie").val();
            alertify.success("Datos Actualizados correctamente");
        });
    });
//Eliminar Ingresos
$('#tabMantenimientoIngresos .table-responsive').on("click", "#btnEliminar", function(event){ 
        var cont=0;
        $(this).parents("tr").find("td").each(function(){
            datos[cont]=$(this).html();   
            cont++;
        });
        $.post('sIngresosHospital', {
            opcion : 8,
            idIngreso: datos[0]                                
        }, function(responseText) {  
            filas--;
            
            if(filas===0)
            {
                if(pagina>0)
                    pagina--;
                filas=5;
            }
             cargarIngresos();
            alertify.success("Registro eliminado");
        });
        event.preventDefault();
        $(this).closest('tr').remove();
    });    
//Paginacion Ingreso
 $('#paginacionIngresosEditar ul').click(function (e) {        
        var a = e.target.parentNode;        
        if(a.id!=="adelante" && a.id!=="atras")
        {
            pagina=a.id;
        }
        if(a.id==="adelante"  && pagina!==ultimo)    
            pagina=parseInt(pagina)+1
        if(a.id==="atras" && pagina!==1)    
            pagina=parseInt(pagina)-1;                        
        cargarIngresos();
    });    
//Indice Seleccionado
$("#tabMantenimientoIngresos .table-responsive").on("click", "tr", function(){  
         indice = $(this).index();
      });
    
/*-------------------------------Medicamentos-------------------------------------------------------------------------*/    
//Medicamentos cargar
 $("#tabMantenimientoIngresos .table-responsive").on("click", "#opMantenimientoMedicina", function(){
          var cont=0;    
          $(this).parents("tr").find("td").each(function(){
              datos[cont]=$(this).html();   
              cont++;
          });
          idIngreso=datos[0];
           $.post('sIngresosHospital', {
               idIngreso : datos[0],
               opcion: 10
           }, function(data) { 
               var resultado = JSON && JSON.parse(data) || $.parseJSON(data); 
               $('#tablaMedicamentos tr').remove();
               $('#tablaMedicamentos thead').append("<tr>\n\
                                                <th style='display:none;' class='col-lg-1'>id</th>\n\
                                                <th class='col-lg-2'>Fecha</th>\n\
                                                <th>Hor</th>\n\
                                                <th class='col-lg-1'>Lni</th>\n\
                                                  <th class='col-lg-1'>Fin</th>\n\
                                                <th >Administración de medicamentos y tratamientos</th>\n\
                                                <th style='display:none;'></th>\n\
                                                <th class='col-lg-1'>Acción</th>\n\
                                              </tr>");
               for(i=0;i <resultado.length; i++)
                {
                    $('#tablaMedicamentos').append("<tr>\n\                                                            \n\
                                                    <td style='display:none;'>"+resultado[i].id+"</td>\n\
                                                    \n\<td>"+resultado[i].fecha+"</td>\n\
                                                    \n\<td>"+resultado[i].hor+"</td>\n\
                                                    \n\ \n\<td>"+resultado[i].lni+"</td>\n\
                                                    \n\ \n\<td>"+resultado[i].fin+"</td>\n\
                                                    \n\ \n\<td>"+resultado[i].medicamentoTratamiento+"</td>\n\
                                                    \n\<td style='display:none;'>"+resultado[i].ingreso.id+"</td>\
                                                    <td style='width: 12%' ><button id='btnEditarMedicamento' class='btn btn-primary' '><span class='glyphicon glyphicon-pencil'></span> </button>\n\
                                                        <button id='btnEliminarMedicamento' class='btn btn-danger'><span class='glyphicon glyphicon-trash'></span></a></button>\n\
                                                    </td>\n\
                                                </tr>");
                }
           
       });
           
          var cont=0;    
          $(this).parents("tr").find("td").each(function(){
              datos[cont]=$(this).html();   
              cont++;
          });
          var id='mantenimientoMedicina';
          $("#"+id).modal('show');
      });
 //Editar Medicamentos
$("#tabMantenimientoIngresos .table-responsive").on("click", "#btnEditarMedicamento", function(){  
          var cont=0;    
          $(this).parents("tr").find("td").each(function(){
              medicinas[cont]=$(this).html();               
              cont++;
              
          });
          idMedicamento=medicinas[0];
          idIngreso=medicinas[6];
          var id='medicinas';
           $('#dtpFechaMedicamentoIngresosModal').val(medicinas[1]);
           $('#txtHor').val(medicinas[2]);
           $('#txtLni').val(medicinas[3]);
           $('#txtFin').val(medicinas[4]);
           $('#txtMedicamentos').val(medicinas[5]);
           remover($('#dtpFechaMedicamentoIngresosModal'));
           remover($('#txtMedicamentos'));
           $("#txtMedicamentoshelp").remove();  
           $("#dtpFechaMedicamentoIngresosModalhelp").remove();  
           $("#"+id).modal('show');
          
      });
//Agregar Medicamento
 $("#tabMantenimientoIngresos .table-responsive").on("click", "#opAgregarMedicina", function(){
         idMedicamento=0;
          var cont=0;    
          $(this).parents("tr").find("td").each(function(){              
              datos[cont]=$(this).html();   
              cont++;
          });
          idIngreso=datos[0];
          var id='medicinas';
          $.each($("#"+id+" input"), function (){
            $(this).val("");
            
        }); 
        $("#tabMantenimientoIngresos #dtpFechaMedicamentoIngresosModal").val('');
        $('#txtMedicamentos').val('');
          $("#"+id).modal('show');
      });            
//Actualizar - Guardar medicamentos      
 $('#tabMantenimientoIngresos #btnGuardarMedicamento').click(function(event) {          
          if(validaciones())
          {
          $.post('sIngresosHospital', {
              
            idIngreso : idIngreso,
            fechaMedicamento: $('#dtpFechaMedicamentoIngresosModal').val(),
            hor: $('#txtHor').val(),
            lni: $('#txtLni').val(),
            fin: $('#txtFin').val(),  
            medicamentoTratamiento:$('#txtMedicamentos').val(),
            opcion:'9',
            idMedicamento:idMedicamento
        }, function(responseText) {    
            if(idMedicamento===0)
                alertify.success("Datos registrados correctamente");
            else
            {
                //indiceMedicamentos
                $($('#tablaMedicamentos').find('tbody > tr')[indiceMedicamentos]).children('td')[1].innerHTML = $('#dtpFechaMedicamentoIngresosModal').val();
                $($('#tablaMedicamentos').find('tbody > tr')[indiceMedicamentos]).children('td')[2].innerHTML = $('#txtHor').val();
                $($('#tablaMedicamentos').find('tbody > tr')[indiceMedicamentos]).children('td')[3].innerHTML = $('#txtLni').val();
                $($('#tablaMedicamentos').find('tbody > tr')[indiceMedicamentos]).children('td')[4].innerHTML = $('#txtFin').val();
                $($('#tablaMedicamentos').find('tbody > tr')[indiceMedicamentos]).children('td')[5].innerHTML = $('#txtMedicamentos').val();
                alertify.success("Datos actualizados correctamente");
            }
            $("#medicinas").modal('toggle');
        });
        }
      });
//Eliminar Medicamento  
$('#tabMantenimientoIngresos .table-responsive').on("click", "#btnEliminarMedicamento", function(event){ 
        var cont=0;
        $(this).parents("tr").find("td").each(function(){
            datos[cont]=$(this).html();   
            cont++;
        });
        $.post('sIngresosHospital', {
            opcion : 11,
            idMedicamento: datos[0]                                
        }, function(responseText) {              
            alertify.success("Registro eliminado");
        });
        event.preventDefault();
        $(this).closest('tr').remove();
    });    
 
//Indice Seleccionado Medicamentos
 $("#tablaMedicamentos").on("click", "tr", function(){  
         indiceMedicamentos = $(this).index();
         
      });
//Validaciones Medicamentos
function validarMedicamentos()
{
    $("#txtMedicamentoshelp").remove();  
    if ($('#txtMedicamentos').val() === null || $('#txtMedicamentos').val()==="" )
    {
        $('#txtMedicamentos').closest("div").addClass("has-error");
        $('#txtMedicamentos').after('<span id="' + $('#txtMedicamentos').attr("id") + 'help" class="help-block">Campo Vacio</span');
    }
    else
    {
        $('#txtMedicamentos').closest("div").removeClass("has-error");
    }
}
function validarDateIngresos()
{
    var value = $("#dtpFechaMedicamentoIngresosModal");
    $("#dtpFechaMedicamentoIngresosModalhelp").remove();     
    if ($(value).val() === null || $(value).val() === "") {
        $(value).closest("div").addClass("has-error");
        $(value).parent("div").after('<span id="' + $(value).attr("id") + 'help" style="color:#a94442;" class="help-block">Sin Fecha</span');
    } else
    {
        $(value).closest("div").removeClass("has-error");
        $("#"+$(value).attr("id") + 'help').remove();
    }
}
$('#txtMedicamentos').blur(function(){    		               
    validarMedicamentos();
});
$('#dtpFechaMedicamentoIngresosModal').blur(function(){    		               
    validarDateIngresos();
});
function validaciones()
{
    $("#tabMantenimientoIngresos .help-block").remove();    
    validarDateIngresos();
    validarMedicamentos();
    return $("#tabMantenimientoIngresos .help-block").length === 0;    
}
/*-------------------------------Otras-------------------------------------------------------------------------*/           
function ocultarModal()
     {
         $('.modal').on({ 
	            'show.bs.modal': function() {
	                var idx = $('.modal:visible').length;
	                $(this).css('z-index', 1040 + (10 * idx));
	            },
	            'shown.bs.modal': function() {
	                var idx = ($('.modal:visible').length) - 1; // raise backdrop after animation.
	                $('.modal-backdrop').not('.stacked')
	                .css('z-index', 1039 + (10 * idx))
	                .addClass('stacked');
	            },
	            'hidden.bs.modal': function() {
	                if ($('.modal:visible').length > 0) {
	                    // restore the modal-open class to the body element, so that scrolling works
	                    // properly after de-stacking a modal.
	                    setTimeout(function() {
	                        $(document.body).addClass('modal-open');
	                    }, 0);
	                }
	            }
	        });
         
     }
function remover(value)
{
    $(value).closest("div").removeClass("has-error");       
}
$('.dropdown-toggle').dropdown();
 $('[data-toggle="tooltip"]').tooltip();  
    
     
     
    
     

