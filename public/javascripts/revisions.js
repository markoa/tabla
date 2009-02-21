versionManager = {
    getSelectedVersions: function(selected) {
	var boxes = new Array();
	var elements = $('revisions_form').elements;
	boxes.selected_index = -1;

	for (var i = 0; i < elements.length; i++)
	    if (elements[i].name == "compare[]" && elements[i].checked) {
		if (elements[i] == selected) boxes.selected_index = boxes.length
		boxes.push(elements[i]);
	    }

	return boxes;
    },

    ensureSelectedVersions: function() {
	var boxes = this.getSelectedVersions();
	if (boxes.length == 2)
	    return true;
	else {
	    alert("You must select two versions to compare.");
	    return false;
	}
    },

    checked: function(checkbox) {
	if (!checkbox.checked) {
	    $('compare_button').disabled = true;
	    return;
	}

	var selections = this.getSelectedVersions();

	if (selections.length > 2)
	    for (var i = 0; i < selections.length; i++)
		if (selections[i] != checkbox)
		    selections[i].checked = false;

	this.examineCompareButton();
    },

    examineCompareButton: function() {
	var boxes = this.getSelectedVersions();
	$('compare_button').disabled = (boxes.length != 2);
    }
}

// eventManager

eventManager = {
    examineMinorCheckbox: function() {
	$('comment_field').disabled = $('minor_checkbox').checked;
    }
}

revisionManager = {
    updateContentPost: function() {
        text = $('revision_content').value;
        if (text.length == 0) {
            $('submit_inline_content_button').disabled = true;
            Element.show('no_blank_content_msg');
        } else {
            $('submit_inline_content_button').disabled = false;
            Element.hide('no_blank_content_msg');
        }
    }
}
