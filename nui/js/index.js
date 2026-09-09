
$(function () {
    function display(bool) {
        if (bool) {
            $(".container").show();
            $(".container-fazioni").hide();
            $(".container-list").hide();
            $(".container-deposito").hide()
            $(".container-boss").hide()
            $(".container-vestiti").hide()
            $(".container-veicoli").hide()
        } else {
            $(".container").hide();
            $(".container-fazioni").hide();
            $(".container-list").hide();
            $(".container-deposito").hide()
            $(".container-boss").hide()
            $(".container-vestiti").hide()
            $(".container-veicoli").hide()

        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        let item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)

            }
        }
        if(item.type === "list"){
            let container = this.document.getElementById(`grid`)
            console.log(item.data.name.length)
            for(let i = 0; i <= (item.data.name.length -1);i++){
                if(container.querySelector(`#${item.data.name[i]}`) === null){
                    let gridItem = $(`<div class="grid-item" id="${item.data.name[i]}"></div>`).appendTo(container)
                    let label = item.data.label[i].replace(/_/g, ' ');
                    let name = item.data.name[i].replace(/_/g, ' ')
                    $(`<h1 >Nome Fazione:<br> <span class="fazione-text">${name}</span></h1>`).appendTo(gridItem)
                    $(`<br>`).appendTo(gridItem)
                    $(`<h1>Label Fazione: <br><span class="fazione-text ">${label}</span> <br></h1>`).appendTo(gridItem)
                    $(`<br>`).appendTo(gridItem)
                    $(`<br>`).appendTo(gridItem)
                    $(`<button class="btn-del" onclick=del(${JSON.stringify(item.data.name[i])})>🗑 Delete</button>`).appendTo(gridItem)

                }
            }
        }
        if(item.type === "delStats"){
            $(`#${item.data}`).remove()
        }
    })
    document.onkeydown = (event) => {
        if(event.which === 27 ){
            $.post(`https://${GetParentResourceName()}/exit`, JSON.stringify({}))
            return
        }
    };    
    $(".developed-btn").click(function(){
        $.post(`https://${GetParentResourceName()}/discord`, JSON.stringify({}));
        return
    })
    $(".add-fazioni-btn").click(function(){
        $(".container-fazioni").show();
        $(".container").hide();
          
    })
    $("#fazioni-form").submit(function(e){
        e.preventDefault()
        let name = $("#nome-fazione").val()
        let label =$("#label-fazione").val()
        label = label.replace(/ /g, '_');
        name = name.replace(/ /g, '_');
        $.post(`https://${GetParentResourceName()}/add-fazione`, JSON.stringify({name, label}));
        $("#nome-fazione").val('')
        $("#label-fazione").val('')

    });
    $("#deposito-form").submit(function(e){
        e.preventDefault()
        let label = $("#label-deposito").val()
        let slot = $("#slot-deposito").val()
        let peso = $("#peso-deposito").val()
        let x = $("#coords-deposito-x").val()
        let y = $("#coords-deposito-y").val()
        let z = $("#coords-deposito-z").val()
        let fazione = $("#fazione-deposito").val()
        $.post(`https://${GetParentResourceName()}/add-deposito`, JSON.stringify({label,slot,peso,x,y,z,fazione}));
        $("#label-deposito").val('')
        $("#slot-deposito").val('')
        $("#peso-deposito").val('')
        $("#coords-deposito-x").val('')
        $("#coords-deposito-y").val('')
        $("#coords-deposito-z").val('')
        $("#fazione-deposito").val('')

    })
    $("#boss-form").submit(function(e){
        e.preventDefault()
        let name = $('#name-boss').val()
        let x = $("#coords-boss-x").val()
        let y = $("#coords-boss-y").val()
        let z = $("#coords-boss-z").val()
        $.post(`https://${GetParentResourceName()}/add-boss`, JSON.stringify({name,x,y,z}));
        $('#name-boss').val('')
        $("#coords-boss-x").val('')
        $("#coords-boss-y").val('')
        $("#coords-boss-z").val('')


    })
    $("#vestiti-form").submit(function(e){
        e.preventDefault()
        let name = $('#name-vestiti').val()
        let x = $("#coords-vestiti-x").val()
        let y = $("#coords-vestiti-y").val()
        let z = $("#coords-vestiti-z").val()
        $.post(`https://${GetParentResourceName()}/add-vestiti`, JSON.stringify({name,x,y,z}));
        $('#name-vestiti').val('')
        $("#coords-vestiti-x").val('')
        $("#coords-vestiti-y").val('')
        $("#coords-vestiti-z").val('')
    })
    $("#veicoli-form").submit(function(e){
        e.preventDefault()
        let name = $('#name-veicoli').val()
        let x = $("#coords-veicoli-x").val()
        let y = $("#coords-veicoli-y").val()
        let z = $("#coords-veicoli-z").val()
        let veh1 = $("#veh1").val()
        let veh2 = $("#veh2").val()
        let veh3 = $("#veh3").val()
        $.post(`https://${GetParentResourceName()}/add-veicoli`, JSON.stringify({name,x,y,z, veh1,veh2,veh3}));
        $('#name-veicoli').val('')
        $("#coords-veicoli-x").val('')
        $("#coords-veicoli-y").val('')
        $("#coords-veicoli-z").val('')
        $("#veh1").val('')
        $("#veh2").val('')
        $("#veh3").val('')


    })
    $(".btn-list").click(function(){
        $.post(`https://${GetParentResourceName()}/list`, JSON.stringify({}));
        $(".container-list").show();
        $(".container").hide();
    })
    $(".add-deposito-btn").click(function(){
        $(".container-deposito").show();
        $(".container").hide();
    })
    $(".add-boss-btn").click(function(){
        $(".container-boss").show()
        $(".container").hide()
    })
    $(".add-vestiti-btn").click(function(){
        $(".container-vestiti").show()
        $(".container").hide()
    })
    $(".add-veicoli-btn").click(function(){
        $(".container-veicoli").show()
        $(".container").hide()

    })
    $(".lt").click(function(){
        display(true)
    })
})