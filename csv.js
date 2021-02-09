function exportCartCsv() {
    var CartArr = GridDataJson.filter((item) => ExportArr.findIndex((id) => id == item.Id) > -1 );
    var data = CartArr;
    if (data.length > 0) {
        var fileName = 'CSVExport';
        let headerEntries = Object.keys(data[0]);
        let bodyEntries = data.map(d => headerEntries.map(h => d[h]).join(","));
        let csvContent = `data:text/csv;charset=utf-8,${headerEntries.join(",")}\n${bodyEntries.join("\n")}`;
        const encodedUri = encodeURI(csvContent);
        let link = document.createElement("a");
        link.setAttribute("href", encodedUri);
        link.setAttribute("download", `${fileName}.csv`);
        document.body.appendChild(link);
        link.click();
    }
}

// TODO there is some awesome javascript here below, to incorporate in various places throughout the app

var GridDataJson = [];
var ExportArr = [];
function resetCartColors() {
    Array.from(document.getElementsByClassName("carts")).forEach(function (elByClassName) {
        elByClassName.style.color = "#DDDDDD";
    });
}
function toggleExportCart(id) {
    var RowId = id.substr(4, id.length - 4);
    if (ExportArr.length == 0) {
        ExportArr.push(RowId);
    } else {
        if (ExportArr.includes(RowId)) {
            ExportArr = ExportArr.filter(function(item) { return item != RowId; });
        } else {
            ExportArr.push(RowId);
        }
    }
    Array.from(document.getElementsByClassName("carts")).forEach(function(elByClassName) {
        elByClassName.style.color = "#DDDDDD";
    });
    ExportArr.forEach(function(IdInt) {
        var elToUpdate = document.getElementById('cart'+IdInt);
        elToUpdate.style.color = "#18bc9c";
    });
}


let SearchFilterArray = [];
$(document).on('click','.searchFilter', function (event) {
    event.preventDefault();
    event.stopPropagation();
    event.stopImmediatePropagation();
    var Selected = 'fa fa-dot-circle-o';
    var Deselected = 'fa fa-circle-o';
    var el = document.getElementById(event.target.id);
    if (el != null) {
        el.className = document.getElementById(event.target.id).className == Deselected ? Selected : Deselected;
    }
    event.preventDefault();
    event.stopPropagation();
    event.stopImmediatePropagation();
});

function updateSearchFilters() {
    ExportArr= [];
    var SelectedArr = [];
    Array.from(document.getElementsByClassName('fa fa-dot-circle-o')).forEach(function(elByClassName) {
        SelectedArr.push(elByClassName.id);
    });
    resetCartColors();
    qc.pA('TrelloCard_ExportForm', 'selectFilter', 'QClickEvent', JSON.stringify(SelectedArr));
}