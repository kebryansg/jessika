/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$("#click").click(function(event)
{
    alert($("#dtpFechaReporte").val());
});
$("#btnGenerar").click(function(event) {  
    
     $.ajax({
            data: {            
                op: 'ingresos',
                fechaReporte: $("#dtpFechaReporte").val()                
            },
            url: "sExcel",
            type: "post",
            beforeSend: function(){
                 $('#btnGenerar').prop('disabled', true);
                document.getElementById("mostrar_loading").style.display="block";
                document.getElementById("mostrar_loading").innerHTML="<img src='resources/img/tenor.gif' width='300' heigth='300'>";
            },
            success: function(response){                                
                document.getElementById("mostrar_loading").style.display="none";
                document.getElementById("mostrar_tabla").innerHTML=response;
                $('#btnGenerar').prop('disabled', false);
            }

        });
});


