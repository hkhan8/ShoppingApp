function ShowToast(providedText, durationMs) {
    Toastify({
        text: providedText,
        duration: durationMs,
        newWindow: true,
        close: false,
        gravity: "bottom", // `top` or `bottom`
        position: "right", // `left`, `center` or `right`
        stopOnFocus: true, // Prevents dismissing of toast on hover
        style: {
            background: "linear-gradient(to right, #FD151B, #F1C40F)",
        }
    }).showToast();
}

async function ConfirmDeleteItem(itemId) {
    if (confirm("Are you sure you want to delete this item?")) {

        // grab a reference to the spinner container - for showing the spinner above the table
        //var spinnerContainer = document.getElementById("TableSpinner")
        //spinnerContainer.style.display = "flex";

        $('#SpinnerModal').modal('show');

        //$.ajax("/Jokes/DeleteJoke?id=" + itemId, {
        //    method: "DELETE",
        //    success: function (result) {
        //        await UpdateJokeTable();
        //        spinnerContainer.style.display = "none";
        //    },
        //    error: function (error) {
        //        console.log(error)
        //        spinnerContainer.style.display = "none";
        //    }
        //})

        await fetch("/Items/DeleteItem?id=" + itemId, {
            method: 'DELETE'
        })
        await UpdateItemTable();

        $('#SpinnerModal').modal('hide');

        //spinnerContainer.style.display = "none";



    } else {
        console.log("Not Deleting")
    }
}

async function UpdateItemTable() {
    //fetch('/Jokes/JokeTable')
    //    .then(response => response.text())
    //    .then(htmlContent => {
    //        document.getElementById("JokeTable").innerHTML = htmlContent
    //        return true;
    //    })

    let result = await fetch('/Items/ItemTable');
    let response = await result.text();
    document.getElementById("ItemTable").innerHTML = response;
    return true;

}

function CreateModal() {
    console.log("Creating")


    fetch('/Items/CreatePartial')
        .then(response => response.text())
        .then(htmlContent => {
            console.log(htmlContent)
            document.getElementById("ModalBody").innerHTML = htmlContent
            document.getElementById("ModalHeader").innerHTML = "Create Item"

            // Adding an event listener to form submit
            var form = document.getElementById("CreateForm");
            form.addEventListener('submit', CreateSubmit)

            $('#ItemsModal').modal('show');
        });


}

async function CreateSubmit(e) {

    // Code to show and start the spinner
    var buttonSpinner = document.getElementById("btnCreateSpinner");
    buttonSpinner.style.display = "inline-block";

    e.preventDefault();
    let form = e.target;

    // convert the form to a FormData object
    let data = new FormData(form);

    // Fetch/Ajax to send to Controller
    let result = await fetch('Items/Create', {
        method: 'POST',
        body: data
    });

    await UpdateItemTable();

    // code to hide the spinner on the button
    buttonSpinner.style.display = "none";

    // Hide the modal
    $('#ItemsModal').modal('hide');
}

function EditModal(id) {
    fetch('/Items/EditPartial?id=' + id)
        .then(response => response.text())
        .then(htmlContent => {
            console.log(htmlContent)
            document.getElementById("ModalBody").innerHTML = htmlContent
            document.getElementById("ModalHeader").innerHTML = "Edit Item"

            // Add event lister to handle submitting the form
            var form = document.getElementById("EditForm");
            form.addEventListener("submit", EditSubmit);

            $('#ItemsModal').modal('show');
        });
}

async function EditSubmit(e) {

    // Code to show and start the spinner
    var buttonSpinner = document.getElementById("btnEditSpinner");
    buttonSpinner.style.display = "inline-block";

    e.preventDefault();
    let form = e.target;

    // convert the form to a FormData object
    let data = new FormData(form);

    // Fetch/Ajax to send to Controller
    let result = await fetch('Items/Edit', {
        method: 'PUT',
        body: data
    });

    console.log(result);
    await UpdateItemTable();

    buttonSpinner.style.display = "none";

    // Hide the modal
    $('#ItemsModal').modal('hide');
}

function DetailsModal(id) {
    fetch('/Items/DetailsPartial?id=' + id)
        .then(response => response.text())
        .then(htmlContent => {
            document.getElementById("ModalBody").innerHTML = htmlContent
            document.getElementById("ModalHeader").innerHTML = "Item Details"
            $('#ItemsModal').modal('show');
        });
}