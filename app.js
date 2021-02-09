// App Specific
// Automation
var SelectedAutomationId = null;
var SelectedUrl = null;
var loadAllAutomations = function(loadAutomations) {
    $.post("databasing.php", { command: "fields",  data: "Automation", clause:" ORDER BY OrderInt" }, function(data) {
        feedback(data);
        loadAutomations(data);
    });
}
var loadAutomations = function(value) {
    var cl = document.getElementById("automationList");
    while (cl.firstChild) {
        cl.removeChild(cl.firstChild);
    }
    try {
        var parsedValueArr = JSON.parse(value);
        parsedValueArr.forEach(function (obj) {
        for (let FieldName of ["Name", "Status", "Enabled", "Mode"]) {
            obj[FieldName] = obj[FieldName] == null ? "" : obj[FieldName];
        }
        SelectedAutomationId = SelectedAutomationId == null ? obj["Id"] : SelectedAutomationId;
        SelectedUrl = SelectedUrl == null ? obj["Mode"] : SelectedUrl;
        var li = document.createElement("li");
        var newdiv = document.createElement('div');
        var backgroundcolor = obj["Id"] == SelectedAutomationId ? "#DDDDFF" : "#EEEEEE";
        newdiv.innerHTML = '<div class="panel panel-info custom-panel" style="background-color:' + backgroundcolor + '"">' +
            '<label class="order-label">' + obj["OrderInt"] + '</label>' +
            '<button class="up-button" id="ccd' + obj["Id"] + '"onclick="upAutomation(this.id)">&uarr;</button>' +
            '<button class="down-button" id="ccd' + obj["Id"] + '"onclick="downAutomation(this.id)">&darr;</button>' +
            '<button class="run-button" id="aus' + obj["Id"] + '" onclick="updateSelectedAutomation(this.id)">Select</button>' +
            '<input class="automation-name" type="text" id="aut' + obj["Id"] + '" value="' + obj["Name"] + '" onfocusout="updateAutomationRow(this.id)"\></input>' +

            '<button class="delete-button" id="aud' + obj["Id"] + '"onclick="deleteAutomation(this.id)">X</button>' +
            '<div class="panel-body" id="apn' + obj["Id"] + '" >' +
            '<textarea class="command-text" id="aav' + obj["Id"] + '" onfocusout="updateAutomationRow(this.id)" spellcheck="false">' + obj["Mode"] + '</textarea>' +
            '</div>' +
            '</div>';
        li.appendChild(newdiv);
        cl.appendChild(li);
        });
        loadAllBatches(loadBatches, SelectedAutomationId);
    } catch (err) {
        feedback(err.message);
    }
    var li = document.createElement("li");
    var newdiv = document.createElement('div');
    newdiv.innerHTML = '<button  class="add-button" onclick="addAutomationRow()">New Automation</button>';
    li.appendChild(newdiv);
    cl.appendChild(li);
}
var addAutomationRow = function() {
    var updatesArr = [
        'INSERT INTO Automation (Name) VALUES ("")',
        'UPDATE Automation SET OrderInt = ((SELECT MAX(OrderInt) FROM Automation) + 1) WHERE Id = (SELECT MAX(Id) FROM Automation)'
    ];
    $.post("databasing.php", { command: "multiQuery", data: JSON.stringify(updatesArr) }, function(data) {
        feedback(data, true);
        loadAllAutomations(loadAutomations);
    });
}
var updateAutomationRow = function(id) {
    var idInt = id.substring(3, id.length);
    SelectedAutomationId = idInt;
    var updatesArr = ['UPDATE Automation SET Name = "'+document.getElementById("aut"+idInt).value+'", Mode = "'+document.getElementById("aav"+idInt).value+'" where Id = '+idInt];
    $.post("databasing.php", { command: "multiQuery", data: JSON.stringify(updatesArr) }, function(data) {
        feedback(data);
        SelectedBatchId = null;
        SelectedUrl = null;
        loadAllAutomations(loadAutomations);
    });
}
var updateSelectedAutomation = function(id) {
    var idInt = id.substring(3, id.length);
    SelectedBatchId = null;
    SelectedAutomationId = idInt;
    var updatesArr = ['UPDATE Config SET AutomationId='+SelectedAutomationId];
    $.post("databasing.php", { command: "multiQuery", data: JSON.stringify(updatesArr) }, function(data) {
        feedback(data);
    });
    $.post("databasing.php", { command: "fields",  data: "Automation", clause:"where Id = "+idInt }, function(automationData) {
        var parsedValueArr = JSON.parse(automationData);
        SelectedUrl = parsedValueArr[0]["Mode"];
        loadAllAutomations(loadAutomations);
    });
}
var deleteAutomation = function(id) {
    var idInt = id.substring(3, id.length);
    var updatesArr = [
        'DELETE FROM Command WHERE BatchInt = (SELECT Id FROM Batch WHERE AutomationInt = '+idInt+')',
        'DELETE FROM Batch WHERE AutomationInt = '+idInt,
        'DELETE FROM Automation WHERE Id = '+idInt
    ];
    $.post("databasing.php", { command: "multiQuery", data: JSON.stringify(updatesArr) }, function(data) {
        feedback(data);
        SelectedBatchId = null;
        SelectedAutomationId = null;
        SelectedUrl = null;
        loadAllAutomations(loadAutomations);
    });
}
var upAutomation = function(id) {
    var idInt = id.substring(3, id.length);
    var updatesArr = ['UPDATE Automation SET OrderInt = OrderInt - 1 WHERE Id = '+idInt];
    $.post("databasing.php", { command: "multiQuery", data: JSON.stringify(updatesArr) }, function(data) {
        feedback(data);
        SelectedBatchId = null;
        SelectedAutomationId = null;
        SelectedUrl = null;
        loadAllAutomations(loadAutomations);
    });
}
var downAutomation = function(id) {
    var idInt = id.substring(3, id.length);
    var updatesArr = ['UPDATE Automation SET OrderInt = OrderInt + 1 WHERE Id = '+idInt];
    $.post("databasing.php", { command: "multiQuery", data: JSON.stringify(updatesArr) }, function(data) {
        feedback(data);
        SelectedBatchId = null;
        SelectedAutomationId = null;
        SelectedUrl = null;
        loadAllAutomations(loadAutomations);
    });
}

// Batch
var SelectedBatchId = null;
var loadAllBatches = function(loadBatches, AutomationId) {
    $.post("databasing.php", { command: "fields",  data: "Batch", clause:"where AutomationInt = '"+AutomationId+"' ORDER BY OrderInt" }, function(data) {
        feedback(data);
        loadBatches(data);
    });
}
var loadBatches = function(value) {
    var cl = document.getElementById("batchList");
    while(cl.firstChild){ cl.removeChild(cl.firstChild); }
    var parsedValueArr = JSON.parse(value);
    parsedValueArr.forEach(function(obj) {
        for (let FieldName of ["Name","Status","Enabled","Mode"]) {
            obj[FieldName] = obj[FieldName] == null ? "" : obj[FieldName];
        }
        SelectedBatchId = SelectedBatchId == null ? obj["Id"] : SelectedBatchId;
        var li = document.createElement("li");
        var newdiv = document.createElement('div');
        var backgroundcolor = obj["Id"] == SelectedBatchId ? "#DDDDFF" : "#EEEEEE";
        newdiv.innerHTML = '<div class="panel panel-info custom-panel" style="background-color:'+backgroundcolor+'">' +
            '<label class="order-label">'+obj["OrderInt"]+'</label>'+
            '<button class="up-button" id="ccd'+obj["Id"]+'"onclick="upBatch(this.id)">&uarr;</button>' +
            '<button class="down-button" id="ccd'+obj["Id"]+'"onclick="downBatch(this.id)">&darr;</button>' +
            '<button class="run-button" id="bas'+obj["Id"]+'" onclick="updateSelectedBatch(this.id)">Select</button>' +
            '<input class="batch-name" type="text" id="bat'+obj["Id"]+'" value="' + obj["Name"] + '" onfocusout="updateBatchRow(this.id)"></input>' +

            '<button class="delete-button" id="bad'+obj["Id"]+'"onclick="deleteBatch(this.id)">X</button>' +
            '<div class="panel-body" id="bpn'+obj["Id"]+'">' +
            obj["Status"] + obj["Mode"] + obj["Enabled"] +
            '</div>' +
            '</div>';
        li.appendChild(newdiv);
        cl.appendChild(li);
    });
    var li = document.createElement("li");
    var newdiv = document.createElement('div');
    newdiv.innerHTML = '<button  class="add-button" onclick="addBatchRow()">New Batch</button>';
    li.appendChild(newdiv);
    cl.appendChild(li);
    loadAllCommands(loadCommands,SelectedBatchId);
}
var addBatchRow = function() {
    var updatesArr = [
        'INSERT INTO Batch (AutomationInt) VALUES ('+SelectedAutomationId+')',
        'UPDATE Batch SET OrderInt = ((SELECT MAX(OrderInt) FROM Batch WHERE AutomationInt ='+SelectedAutomationId+') + 1) WHERE Id = (SELECT MAX(Id) FROM Batch)'
    ];
    $.post("databasing.php", { command: "multiQuery", data: JSON.stringify(updatesArr) }, function(data) {
        feedback(data);
        loadAllBatches(loadBatches, SelectedAutomationId);
    });
}
var updateBatchRow = function(id) {
    var idInt = id.substring(3, id.length);
    var element = document.getElementById("bat"+idInt);
    var name = element.value;
    SelectedBatchId = idInt;
    var updatesArr = ['UPDATE Batch SET Name = "'+name+'" where Id = '+idInt];
    $.post("databasing.php", { command: "multiQuery", data: JSON.stringify(updatesArr) }, function(data) {
        feedback(data);
        loadAllBatches(loadBatches, SelectedAutomationId);
    });
}
var updateSelectedBatch = function(id) {
    var idInt = id.substring(3, id.length);
    SelectedBatchId = idInt;
    var updatesArr = ['UPDATE Config SET BatchId='+SelectedBatchId];
    $.post("databasing.php", { command: "multiQuery", data: JSON.stringify(updatesArr) }, function(data) {
        feedback(data);
    });
    loadAllBatches(loadBatches, SelectedAutomationId);
}
var deleteBatch = function(id) {
    var idInt = id.substring(3, id.length);
    var updatesArr = [
        'DELETE FROM Command WHERE BatchInt = '+idInt,
        'DELETE FROM Batch WHERE Id = '+idInt
    ];
    $.post("databasing.php", { command: "multiQuery", data: JSON.stringify(updatesArr) }, function(data) {
        feedback(data);
        SelectedBatchId = null;
        loadAllBatches(loadBatches, SelectedAutomationId);
    });
}
var upBatch = function(id) {
    var idInt = id.substring(3, id.length);
    var updatesArr = ['UPDATE Batch SET OrderInt = OrderInt - 1 WHERE Id = '+idInt];
    $.post("databasing.php", { command: "multiQuery", data: JSON.stringify(updatesArr) }, function(data) {
        feedback(data);
        loadAllBatches(loadBatches, SelectedAutomationId);
    });
}
var downBatch = function(id) {
    var idInt = id.substring(3, id.length);
    var updatesArr = ['UPDATE Batch SET OrderInt = OrderInt + 1 WHERE Id = '+idInt];
    $.post("databasing.php", { command: "multiQuery", data: JSON.stringify(updatesArr) }, function(data) {
        feedback(data);
        loadAllBatches(loadBatches, SelectedAutomationId);
    });
}

// Command
var loadAllCommands = function(loadCommands, BatchId) {
    $.post("databasing.php", { command: "fields",  data: "Command", clause:"where BatchInt = '"+BatchId+"' ORDER BY OrderInt" }, function(data) {
        feedback(data);
        loadCommands(data);
    });
}
var loadCommands = function(value) {
    var cl = document.getElementById("commandList");
    while(cl.firstChild) { cl.removeChild( cl.firstChild );}
    var parsedValueArr = JSON.parse(value);
    parsedValueArr.forEach(function(obj) {
        for (let FieldName of ["Name","Status","Enabled","Mode","Command"]) {
            obj[FieldName] = obj[FieldName] == null ? "" : obj[FieldName];
        }
        var li = document.createElement("li");
        var newdiv = document.createElement('div');
        newdiv.innerHTML = '<div class="panel panel-info custom-panel">' +
            '<label class="order-label">'+obj["OrderInt"]+'</label>'+
            '<button class="up-button" id="ccd'+obj["Id"]+'"onclick="upCommand(this.id)">&uarr;</button>' +
            '<button class="down-button" id="ccd'+obj["Id"]+'"onclick="downCommand(this.id)">&darr;</button>' +
            '<button class="run-button" id="ccr'+obj["Id"]+'" onclick="runCommand(this.id, false)">Run</button>' +
            '<input class="command-name" id="cmd'+obj["Id"]+'" value="' + obj["Name"] + '" onfocusout="updateCommandRow(this.id)"></input>' +
            '<button class="delete-button" id="ccd'+obj["Id"]+'"onclick="deleteCommand(this.id)">X</button>' +
            '<div class="panel-body" id="cpn'+obj["Id"]+'">' +
            '<textarea class="command-text" id="ccv'+obj["Id"]+'" onfocusout="updateCommandRow(this.id)" spellcheck="false">'+obj["Command"]+'</textarea>'+
            '</div></div>';
        li.appendChild(newdiv);
        cl.appendChild(li);
        const tx = document.getElementById('ccv'+obj["Id"]);
        tx.setAttribute('style', 'height:auto;');
        tx.setAttribute('style', 'height:' + (tx.scrollHeight+20) + 'px;overflow-y:hidden;');
    });
    var li = document.createElement("li");
    var newdiv = document.createElement('div');
    newdiv.innerHTML = '<button  class="add-button" onclick="addCommandRow()">New Command</button>';
    li.appendChild(newdiv);
    cl.appendChild(li);
}
var addCommandRow = function() {
    var updatesArr = [
        'INSERT INTO Command (BatchInt) VALUES ('+SelectedBatchId+')',
        'UPDATE Command SET OrderInt = ((SELECT MAX(OrderInt) FROM Command WHERE BatchInt ='+SelectedBatchId+') + 1) WHERE Id = (SELECT MAX(Id) FROM Command)'
    ];
    $.post("databasing.php", { command: "multiQuery", data: JSON.stringify(updatesArr) }, function(data) {
        feedback(data);
        loadAllCommands(loadCommands,SelectedBatchId);
    });
}
var updateCommandRow = function(id) {
    var idInt = id.substring(3, id.length);
    var name = document.getElementById("cmd"+idInt).value;
    var commandValue = document.getElementById("ccv"+idInt).value;
    var updatesArr = ['UPDATE Command SET Name = "'+name+'" where Id ='+idInt ];
    $.post("databasing.php", { command: "multiQuery", data: JSON.stringify(updatesArr) }, function(data) {
        $.post("databasing.php", { command: "updateCommand", data: commandValue, id: idInt }, function(data2) {
            feedback(data2);
            loadAllCommands(loadCommands,SelectedBatchId);
        });
    });
}
var runCommand = function(id, run_again) {
    feedback("Running", true);
    var idInt = id.substring(3, id.length);
    if (run_again) {
        var name = document.getElementById(id).getAttribute("data-value");
        $.post("databasing.php", { command: "fields",  data: "Command", clause:"where Id = "+idInt }, function(commandData) {
            var parsedValueArr = JSON.parse(commandData);
            var commandValue = parsedValueArr[0]["Command"];
            $.post("databasing.php", { command: "curl", url:SelectedUrl, data: commandValue }, function(data) {
                $.post("databasing.php", {command: "chirp",  data: data, commandValue: name, commandId: idInt }, function(data2) {
                    feedback("Done: "+data2, true);
                    loadAllPosts(loadPosts);
                });
            });
        });
    } else {
        var name = document.getElementById("cmd"+idInt).value;
        var commandValue = document.getElementById("ccv"+idInt).value;
        $.post("databasing.php", {command: "curl", url: SelectedUrl, data: commandValue}, function (data) {
            $.post("databasing.php", {command: "chirp", data: data, commandValue: name, commandId: idInt}, function (data2) {
                    feedback("Done: " + data2, true);
                    loadAllPosts(loadPosts);
            });
        });
    }
}
var deleteCommand = function(id) {
    var idInt = id.substring(3, id.length);
    var updatesArr = ['DELETE FROM Command where Id ='+idInt ];
    $.post("databasing.php", { command: "multiQuery", data: JSON.stringify(updatesArr) }, function(data) {
        feedback(data);
        loadAllCommands(loadCommands,SelectedBatchId);
    });
}
var upCommand = function(id) {
    var idInt = id.substring(3, id.length);
    var updatesArr = ['UPDATE Command SET OrderInt = OrderInt - 1 WHERE Id = '+idInt];
    $.post("databasing.php", { command: "multiQuery", data: JSON.stringify(updatesArr) }, function(data) {
        feedback(data);
        loadAllCommands(loadCommands,SelectedBatchId);
    });
}
var downCommand = function(id) {
    var idInt = id.substring(3, id.length);
    var updatesArr = ['UPDATE Command SET OrderInt = OrderInt + 1 WHERE Id = '+idInt];
    $.post("databasing.php", { command: "multiQuery", data: JSON.stringify(updatesArr) }, function(data) {
        feedback(data);
        loadAllCommands(loadCommands,SelectedBatchId);
    });
}

// Config
var loadAllConfig = function(loadConfig) {
    $.post("databasing.php", { command: "fields",  data: "Config", clause:"" }, function(data) {
        feedback(data);
        loadConfig(data);
    });
}
var loadConfig = function(value) {
    try {
        var parsedValueArr = JSON.parse(value);
        SelectedAutomationId = parsedValueArr[0]["AutomationId"];
        SelectedBatchId = parsedValueArr[0]["BatchId"];
        $.post("databasing.php", {
            command: "fields",
            data: "Automation",
            clause: "where Id = " + SelectedAutomationId
        }, function (automationData) {
            try {
                var parsedValueArr2 = JSON.parse(automationData);
                SelectedUrl = parsedValueArr2[0]["Mode"];
            } catch (err) {
                feedback(err.message);
            }
        });
    } catch (err) {
        var updatesArr = ['INSERT INTO Config (AutomationId, BatchId) VALUES (1,1)'];
        $.post("databasing.php", { command: "multiQuery", data: JSON.stringify(updatesArr) }, function(data) {
            feedback(data, true);
        });
    }
}

// Results
var clearResults = function() {
    var updatesArr = ['DELETE FROM webcat_db.Posts' ];
    $.post("databasing.php", { command: "multiQuery", data: JSON.stringify(updatesArr) }, function(data) {
        feedback(data);
        loadAllPosts(loadPosts);
    });
}