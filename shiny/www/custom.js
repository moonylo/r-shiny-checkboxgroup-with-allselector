function selectOrDeselectAllOfInputId(inputId, isChecked) {
  var inputIdReal = inputId.replace("_allSelector","")
  var allCheckboxes = document.getElementById(inputIdReal).getElementsByTagName("input")
  for(var i=0; i < allCheckboxes.length; ++i) {
    allCheckboxes[i].checked = isChecked
  }
}

function checkOrUncheckAllSelectorIfNeeded(event) {
  if(event.target.parentElement.parentElement.className != "checkbox") {
    return;
  }
  const inputId = event.target.name
  if (inputId == null || inputId.endsWith("_allSelector")) {
    return
  }
  var isClickedBoxChecked = event.target.checked;
  var mainDiv = document.getElementById(inputId)
  if( mainDiv == null) {
    return
  }
  var allCheckboxes = mainDiv.getElementsByTagName("input")
  var allSelectorExists = allCheckboxes[0].name.endsWith("_allSelector")
  if (allSelectorExists == false){
    return
  }
  for (var i=0; i < allCheckboxes.length; ++i) {
    if (i==0) {
      continue;
    }
    if (allCheckboxes[i].checked !== isClickedBoxChecked) {
      allCheckboxes[0].checked = false;
      return
    }
  }
  allCheckboxes[0].checked = isClickedBoxChecked;
}

document.addEventListener('click', checkOrUncheckAllSelectorIfNeeded, false)
