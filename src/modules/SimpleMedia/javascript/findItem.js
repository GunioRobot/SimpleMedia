//=============================================================================
// Stand alone file selector for SimpleMedia
// (C) Axel Guckelsberger (2007-2011)
// based on Mediashare implementation
// (C) Jorn Wildt 2006
//=============================================================================

//=============================================================================
// External interface functions
//=============================================================================

function SimpleMediaFindItemXinha(editor, smURL)
{
    // Save editor for access in selector window
    currentSimpleMediaEditor = editor;

    window.open(smURL, '', getPopupAttributes());
}

function getPopupAttributes()
{
    var pWidth = screen.width * 0.75;
    var pHeight = screen.height * 0.66;
    return 'width=' + pWidth + ',height=' + pHeight + ',scrollbars,resizable';
}


//=============================================================================
// Internal stuff
//=============================================================================

// htmlArea 3.0 editor for access in selector window
var currentSimpleMediaEditor = null;
var currentSimpleMediaInput = null;

var simpleMedia = {}

simpleMedia.find = {}

simpleMedia.find.onLoad = function(baseID, selectedMediumId) {
    $('SimpleMedia_onlyimages').observe('click', simpleMedia.find.onParamChanged);
    if ($('SimpleMedia_thumbnr') != undefined) {
        $('SimpleMedia_thumbnr').observe('change', simpleMedia.find.onParamChanged);
    }
    $('SimpleMedia_sort').observe('change', simpleMedia.find.onParamChanged);
    $('SimpleMedia_sortdir').observe('change', simpleMedia.find.onParamChanged);
    $('SimpleMedia_pagesize').observe('change', simpleMedia.find.onParamChanged);
    $('SimpleMedia_gosearch').observe('click', simpleMedia.find.onParamChanged)
                             .observe('keypress', simpleMedia.find.onParamChanged);
    $('SimpleMedia_submit').hide();
    $('SimpleMedia_cancel').observe('click', simpleMedia.find.handleCancel);
}

simpleMedia.find.onParamChanged = function() {
    $('selectorForm').submit();
}

simpleMedia.find.handleCancel = function() {
    var editor = $F('editorName');
    if (editor == 'xinha') {
        var w = parent.window;
        window.close();
        w.focus();
    } else if (editor == 'tinymce') {
        tinyMCEPopup.close();
        //smClosePopup();
    } else if (editor == 'ckeditor') {
        /** to be done*/
    } else {
        alert('Close Editor: ' + editor);
    }
}


function getPasteSnippet(mode, mediumId) {
    var fileUrl = $F('fileurl' + mediumId);
    var titleText = $F('imgtitle' + mediumId);
    var descText = $F('imgdesc' + mediumId);

    var pasteMode = $F('SimpleMedia_pasteas');

    if (pasteMode == 7) {
        return mediumId;
    }

    if (!$('SimpleMedia_onlyimages').checked) {
        // link to original download
        if (mode == 'url') {
            return fileUrl;
        } else {
            return '<a href="' + fileUrl + '" title="' + descText + '">' + titleText + '</a>';
        }
    }

    // only images

    var thumbUrl = $F('thumburl' + mediumId);

    if (pasteMode == 1) {
        // thumbnail with link to view original
        return '<a href="' + fileUrl + '" title="' + descText + '"><img src="' + thumbUrl + '" alt="' + titleText + '" /></a>';
    } else if (pasteMode == 2) {
        // thumbnail with link to detail page
        var detailUrl = $F('detailurl' + mediumId);
        return '<a href="' + detailUrl + '" title="' + descText + '"><img src="' + thumbUrl + '" alt="' + titleText + '" /></a>';
    } else if (pasteMode == 3) {
        // thumbnail image
        return '<img src="' + thumbUrl + '" alt="' + titleText + '" />';
    } else if (pasteMode == 4) {
        // original image
        return '<img src="' + fileUrl + '" alt="' + titleText + '" />';
    } else if (pasteMode > 4 && pasteMode < 7) {
        if (mode == 'url') {
            // plugin mode
            if (pasteMode == 5) {
                // link to thumbnail
                return thumbUrl;
            } else if (pasteMode == 6) {
                // link to original
                return fileUrl;
            }
        } else {
            // editor mode
            if (pasteMode == 5) {
                // link to thumbnail
                return '<a href="' + thumbUrl + '" title="' + descText + '">' + titleText + '</a>';
            } else if (pasteMode == 6) {
                // link to original
                return '<a href="' + fileUrl + '" title="' + descText + '">' + titleText + '</a>';
            }
        }
    } else if (pasteMode == 8) {
        // original with link to itself
        return '<a href="' + fileUrl + '" title="' + descText + '"><img src="' + fileUrl + '" alt="' + titleText + '" /></a>';
    }
}


  // User clicks on "select item" button
simpleMedia.find.selectItem = function(mediumId) {
    var editor = $F('editorName');
    if (editor == 'xinha') {
        if (window.opener.currentSimpleMediaEditor != null) {
            var html = getPasteSnippet('html', mediumId);

            window.opener.currentSimpleMediaEditor.focusEditor();
            window.opener.currentSimpleMediaEditor.insertHTML(html);
        } else {
            var html = getPasteSnippet('url', mediumId);
            var currentInput = window.opener.currentSimpleMediaInput;

            if (currentInput.tagName == 'INPUT') {
                // Simply overwrite value of input elements
                currentInput.value = html;
            } else if (currentInput.tagName == 'TEXTAREA') {
                // Try to paste into textarea - technique depends on environment
                if (typeof document.selection != 'undefined') {
                    // IE: Move focus to textarea (which fortunately keeps its current selection) and overwrite selection
                    currentInput.focus();
                    window.opener.document.selection.createRange().text = html;
                } else if (typeof currentInput.selectionStart != 'undefined') {
                    // Firefox: Get start and end points of selection and create new value based on old value
                    var startPos = currentInput.selectionStart;
                    var endPos = currentInput.selectionEnd;
                    currentInput.value = currentInput.value.substring(0, startPos)
                                        + html
                                        + currentInput.value.substring(endPos, currentInput.value.length);
                } else {
                    // Others: just append to the current value
                    currentInput.value += html;
                }
            }
        }
    } else if (editor == 'tinymce') {
        var html = getPasteSnippet('html', mediumId);
        tinyMCEPopup.editor.execCommand('mceInsertContent', false, html);
        tinyMCEPopup.close();
        return;
    } else if (editor == 'ckeditor') {
        /** to be done*/
    } else {
        alert('Insert into Editor: ' + editor);
    }
    smClosePopup();
}


function smClosePopup() {
    window.opener.focus();
    window.close();
}




//=============================================================================
// SimpleMedia item selector for Forms
//=============================================================================

simpleMedia.itemSelector = {};
simpleMedia.itemSelector.items = {};
simpleMedia.itemSelector.baseID = 0;
simpleMedia.itemSelector.selectedMediumId = 0;

simpleMedia.itemSelector.onLoad = function(baseID, selectedMediumId) {
    simpleMedia.itemSelector.baseID = baseID;
    simpleMedia.itemSelector.selectedMediumId = selectedMediumId;

    $(baseID + '_catid').observe('change', simpleMedia.itemSelector.onParamChanged);
    $(baseID + '_id').observe('change', simpleMedia.itemSelector.onFileChanged);
    $(baseID + '_onlyimages').observe('click', simpleMedia.itemSelector.onParamChanged);
    $(baseID + '_sort').observe('change', simpleMedia.itemSelector.onParamChanged);
    $(baseID + '_sortdir').observe('change', simpleMedia.itemSelector.onParamChanged);
    $('SimpleMedia_gosearch').observe('click', simpleMedia.itemSelector.onParamChanged)
                             .observe('keypress', simpleMedia.itemSelector.onParamChanged)

    $('linkButton').observe('click', function(e) { $('imgArea').hide(); });
    $('embedButton').observe('click', function(e) { $('imgArea').show(); });

    $('thumbSizeRow').select('input').each(function(elem) {
        elem.observe('click', simpleMedia.itemSelector.onParamChanged);
    });

    simpleMedia.itemSelector.getFileList();
}

simpleMedia.itemSelector.onParamChanged = function() {
    var baseID = simpleMedia.itemSelector.baseID;
    $('ajax_indicator').show();

    simpleMedia.itemSelector.getFileList();
}

simpleMedia.itemSelector.getFileList = function() {
    var baseID = simpleMedia.itemSelector.baseID;
    var pars = 'catid=' + $F(baseID + '_catid') + '&' +
               'onlyimages=' + $F(baseID + '_onlyimages') + '&' +
               'sort=' + $F(baseID + '_sort') + '&' +
               'sortdir=' + $F(baseID + '_sortdir') + '&' +
               'onlyimages=' + (($(baseID + '_onlyimages').checked) ? 1 : 0) + '&' +
               'keyword=' + $F(baseID + '_keyword');

    var thumbInput = $('thumbSizeRow').select('input').find(function(r) { return r.checked });
    pars += '&thumbnr=' + thumbInput.value;

    new Zikula.Ajax.Request('ajax.php?module=SimpleMedia&func=getFileList', {
        method: 'post',
        parameters: pars,
        onFailure: function(req) {
            Zikula.showajaxerror(req.getMessage());
            return;
        },
        onSuccess: function(req) {
            var baseID = simpleMedia.itemSelector.baseID;
            simpleMedia.itemSelector.items[baseID] = req.getData();
            $('ajax_indicator').hide();
            simpleMedia.itemSelector.updateMediumDropdownEntries();
            simpleMedia.itemSelector.updatePreview();
        }
    });
}

simpleMedia.itemSelector.updateMediumDropdownEntries = function() {
    var baseID = simpleMedia.itemSelector.baseID;
    var itemSelector = $(baseID + '_id');

    itemSelector.length = 0;

    var items = simpleMedia.itemSelector.items[baseID];
    for (i = 0; i < items.length; ++i) {
        var item = items[i];
        itemSelector.options[i] = new Option(item.title + ' (' + item.extension + ')', item.id, false);
    }

    if (simpleMedia.itemSelector.selectedMediumId > 0) {
        $(baseID + '_id').value = simpleMedia.itemSelector.selectedMediumId;
    }
}

simpleMedia.itemSelector.updatePreview = function() {
    var baseID = simpleMedia.itemSelector.baseID;
    var items = simpleMedia.itemSelector.items[baseID];

    $(baseID + '_previewcontainer').hide();

    if (items.length == 0) {
        return;
    }

    var selectedElement = items[0];
    if (simpleMedia.itemSelector.selectedMediumId > 0) {
        for (i = 0; i < items.length; ++i) {
            if (items[i].id == simpleMedia.itemSelector.selectedMediumId) {
                selectedElement = items[i];
                break;
            }
        }
    }

    if (selectedElement !== null) {
        $(baseID + '_previewcontainer').update(window.atob(selectedElement.previewInfo))
                                       .show();
    }
}

simpleMedia.itemSelector.onFileChanged = function() {
    var baseID = simpleMedia.itemSelector.baseID;
    var itemSelector = $(baseID + '_id');
    var preview = window.atob(simpleMedia.itemSelector.items[baseID][itemSelector.selectedIndex].previewInfo);
    $(baseID + '_previewcontainer').update(preview);
    simpleMedia.itemSelector.selectedMediumId = $F(baseID + '_id');
}

