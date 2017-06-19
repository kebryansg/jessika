/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$('#descargarEgresos').hide();
$('#descargarCamas').hide();
$('#descargarCamasIndividual').hide();
//descargarCamasIndividual
$(function () {
    $.ajax({
        url: 'sEstablecimiento',
        data: {            
            opcion:'1'
        },
        type: "post",
        success: function(data){ 
            var resultado = JSON && JSON.parse(data) || $.parseJSON(data);
            
            if(data==="[]")
            //if(resultado.qlength<=0)
            {
                $('#btnGenerar').prop('disabled', true);
                $("#msgAlert").fadeIn();
            }
            else
                $('#btnGenerar').prop('disabled', false);
        }
    });  
});
$("#click").click(function(event)
{
    alert($("#dtpFechaReporte").val());
});
//btnDescargarCamas
$("#btnDescargarCamas").click(function(event) {  
  $.ajax({
            data: {                 
            },
            url: "sDownloadFile",
            type: "post",
            success: function(response){                                
               alert("ok") ;
            }

        });  
});
$("#btnGenerar").click(function(event) {      
     $.ajax({
            data: {            
                
                fechaReporte: $("#dtpFechaReporte").val()                
            },
            url: "sExcel",
            type: "post",
            beforeSend: function(){
                 $('#btnGenerar').prop('disabled', true);
                 waitingDialog.show('Este proceso podría tardar varios minutos',{
                     headerText: 'Generando archivos'				                     
                 });
                 $('#descargarEgresos').hide();
                 $('#descargarCamas').hide();
                 $('#descargarCamasIndividual').hide();
                //document.getElementById("mostrar_loading").style.display="block";
               // document.getElementById("mostrar_loading").innerHTML="<img src='resources/img/tenor.gif' width='300' heigth='300'>";
            },
            success: function(data){   
               console.log(data);
               var resultado = JSON && JSON.parse(data) || $.parseJSON(data);               
                $("#descargarEgresos").attr("href","xlsx/"+resultado.egresos);
                $("#descargarCamas").attr("href","xlsx/"+resultado.camas);
                $('#descargarCamasIndividual').attr("href","xlsx/"+resultado.camasIndividual);                
                $('#descargarCamasIndividual').show("slow");
                $('#descargarEgresos').show("slow");
                $('#descargarCamas').show("slow");
                //document.getElementById("mostrar_loading").style.display="none";
                waitingDialog.hide();
                //document.getElementById("mostrar_tabla").innerHTML=data;
                $('#btnGenerar').prop('disabled', false);
            }

        });
});


